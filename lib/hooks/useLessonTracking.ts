import { useEffect, useRef } from 'react';
import { usePathname } from 'next/navigation';
import { useAppStore } from '../store';

export function useLessonTracking() {
	const pathname = usePathname();
	const { addInteraction } = useAppStore();
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
						addInteraction({
							interaction_type: 'lesson_exit',
							lesson_id: lastLessonIdRef.current
						});
					}
				}

				// Log the start of the new lesson
				addInteraction({
					interaction_type: 'lesson_start',
					lesson_id: lessonId
				});

				lastLessonIdRef.current = lessonId;
				startTimeRef.current = Date.now();
			}
		} else if (isLeavingLesson && lastLessonIdRef.current !== null && startTimeRef.current !== null) {
			const timeSpent = Date.now() - startTimeRef.current;
			if (timeSpent > 10000) {
				console.log('Logging lesson exit');
				addInteraction({
					interaction_type: 'lesson_exit',
					lesson_id: lastLessonIdRef.current
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
					addInteraction({
						interaction_type: 'lesson_exit',
						lesson_id: lastLessonIdRef.current
					});
				}
			}
		};
	}, [pathname, addInteraction]);
}