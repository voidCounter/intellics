import { useEffect, useRef } from 'react';
import { usePathname } from 'next/navigation';
import { useInteractionLogger } from '../services/interactionLogger';
import { InteractionType } from '@/types/api';

export function useLessonTracking() {
	const pathname = usePathname();
	const interactionLogger = useInteractionLogger();
	const lastLessonIdRef = useRef<number | null>(null);
	const startTimeRef = useRef<number | null>(null);

	useEffect(() => {
		console.log('Pathname changed:', pathname);
		const lessonMatch = pathname.match(/^\/lessons\/(\d+)$/);
		const isLeavingLesson = !lessonMatch && !pathname.startsWith('/lessons');

		if (lessonMatch) {
			const lessonId = parseInt(lessonMatch[1]);

			// If we're entering a new lesson
			if (lessonId !== lastLessonIdRef.current) {
				// If we had a previous lesson, log its exit
				if (lastLessonIdRef.current !== null && startTimeRef.current !== null) {
					const timeSpent = Date.now() - startTimeRef.current;
					if (timeSpent > 10000) {
						// Log lesson exit using interactionLogger
						interactionLogger.logLessonExit(
							'no_session', // We don't have sessionId in this context
							lastLessonIdRef.current.toString(),
							undefined, // moduleId not available in this context
							Math.floor(timeSpent / 1000)
						).catch((error: unknown) => {
							console.error('Failed to log lesson exit interaction:', error);
						});
					}
				}

				// Log the start of the new lesson
				interactionLogger.logLessonStart(
					'no_session', // We don't have sessionId in this context
					lessonId.toString(),
					undefined // moduleId not available in this context
				).catch((error: unknown) => {
					console.error('Failed to log lesson start interaction:', error);
				});

				lastLessonIdRef.current = lessonId;
				startTimeRef.current = Date.now();
			}
		} else if (isLeavingLesson && lastLessonIdRef.current !== null && startTimeRef.current !== null) {
			const timeSpent = Date.now() - startTimeRef.current;
			if (timeSpent > 10000) {
				console.log('Logging lesson exit');
				// Log lesson exit using interactionLogger
				interactionLogger.logLessonExit(
					'no_session', // We don't have sessionId in this context
					lastLessonIdRef.current.toString(),
					undefined, // moduleId not available in this context
					Math.floor(timeSpent / 1000)
				).catch((error: unknown) => {
					console.error('Failed to log lesson exit interaction:', error);
				});
			}
			lastLessonIdRef.current = null;
			startTimeRef.current = null;
		}

		// Cleanup on unmount
		return () => {
			if (lastLessonIdRef.current !== null && startTimeRef.current !== null) {
				const timeSpent = Date.now() - startTimeRef.current;
				if (timeSpent > 10000) {
					// Log lesson exit using interactionLogger
					interactionLogger.logLessonExit(
						'no_session', // We don't have sessionId in this context
						lastLessonIdRef.current.toString(),
						undefined, // moduleId not available in this context
						Math.floor(timeSpent / 1000)
					).catch((error: unknown) => {
						console.error('Failed to log lesson exit interaction:', error);
					});
				}
			}
		};
	}, [pathname, interactionLogger]);
}