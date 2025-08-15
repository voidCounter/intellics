"use client"

import { useState, useEffect } from "react"

// Interactive Progress Bar Slider Component
export const InteractiveProgressBar = ({ 
  value, 
  onChange, 
  type, 
  disabled = false 
}: { 
  value: number; 
  onChange: (value: number) => void; 
  type: 'mastery' | 'weight';
  disabled?: boolean;
}) => {
  const [isDragging, setIsDragging] = useState(false);
  const [dragValue, setDragValue] = useState(value);

  const getColorClass = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.8) return 'bg-green-500';
      if (val >= 0.6) return 'bg-blue-500';
      if (val >= 0.4) return 'bg-yellow-500';
      return 'bg-red-500';
    } else {
      if (val >= 0.8) return 'bg-purple-500';
      if (val >= 0.6) return 'bg-indigo-500';
      if (val >= 0.4) return 'bg-blue-500';
      return 'bg-gray-500';
    }
  };

  const getMasteryLabel = (val: number) => {
    if (val >= 0.9) return 'Expert';
    if (val >= 0.8) return 'Advanced';
    if (val >= 0.6) return 'Intermediate';
    if (val >= 0.4) return 'Beginner';
    return 'Novice';
  };

  const getWeightLabel = (val: number) => {
    if (val >= 0.8) return 'High';
    if (val >= 0.6) return 'Medium-High';
    if (val >= 0.4) return 'Medium';
    if (val >= 0.2) return 'Low-Medium';
    return 'Low';
  };

  const getLevelColor = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.8) return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200';
      if (val >= 0.6) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      if (val >= 0.4) return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200';
      return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
    } else {
      if (val >= 0.8) return 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200';
      if (val >= 0.6) return 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200';
      if (val >= 0.4) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200';
    }
  };

  const handleMouseDown = (e: React.MouseEvent<HTMLDivElement>) => {
    if (disabled) return;
    setIsDragging(true);
    handleMouseMove(e);
    
    // Add global mouse event listeners for continuous dragging
    document.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseup', handleMouseUp);
  };

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement> | MouseEvent) => {
    if (!isDragging || disabled) return;
    
    // Get the progress bar container for calculating position
    let progressBar: Element | null = null;
    
    if (e.currentTarget && 'closest' in e.currentTarget) {
      progressBar = (e.currentTarget as Element).closest('.progress-bar-container');
    }
    
    if (!progressBar) {
      progressBar = document.querySelector('.progress-bar-container');
    }
    
    if (!progressBar) return;
    
    const rect = progressBar.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const percentage = Math.max(0, Math.min(1, x / rect.width));
    const newValue = Math.round(percentage * 10) / 10; // Round to 0.1
    
    setDragValue(newValue);
  };

  const handleMouseUp = () => {
    if (isDragging && !disabled) {
      onChange(dragValue);
      setIsDragging(false);
      
      // Remove global mouse event listeners
      document.removeEventListener('mousemove', handleMouseMove);
      document.removeEventListener('mouseup', handleMouseUp);
    }
  };

  const handleClick = (e: React.MouseEvent<HTMLDivElement>) => {
    if (disabled) return;
    
    const rect = e.currentTarget.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const percentage = Math.max(0, Math.min(1, x / rect.width));
    const newValue = Math.round(percentage * 10) / 10;
    onChange(newValue);
  };

  const currentValue = isDragging ? dragValue : value;
  const percentage = Math.round(currentValue * 100);

  // Cleanup event listeners on unmount or when dragging stops
  useEffect(() => {
    return () => {
      document.removeEventListener('mousemove', handleMouseMove);
      document.removeEventListener('mouseup', handleMouseUp);
    };
  }, []);

  return (
    <div className="flex items-center gap-4">
      {/* Interactive Progress Bar */}
      <div className="flex-1">
        <div 
          className={`progress-bar-container relative w-full h-3 bg-gray-200 rounded-full cursor-pointer border border-gray-300 transition-all duration-200 ${
            isDragging ? 'ring-2 ring-primary ring-opacity-50' : ''
          } ${disabled ? 'opacity-50 cursor-not-allowed' : ''}`}
          onMouseDown={(e) => {
            // Only handle mouse down if not clicking on the handle
            if (!(e.target as Element).closest('.progress-handle')) {
              handleMouseDown(e);
            }
          }}
          onClick={(e) => {
            // Only handle clicks if not clicking on the handle
            if (!(e.target as Element).closest('.progress-handle')) {
              handleClick(e);
            }
          }}
          onTouchStart={(e) => {
            if (disabled) return;
            setIsDragging(true);
            const touch = e.touches[0];
            const rect = e.currentTarget.getBoundingClientRect();
            const x = touch.clientX - rect.left;
            const percentage = Math.max(0, Math.min(1, x / rect.width));
            const newValue = Math.round(percentage * 10) / 10;
            setDragValue(newValue);
          }}
          onTouchMove={(e) => {
            if (!isDragging || disabled) return;
            e.preventDefault();
            const touch = e.touches[0];
            const rect = e.currentTarget.getBoundingClientRect();
            const x = touch.clientX - rect.left;
            const percentage = Math.max(0, Math.min(1, x / rect.width));
            const newValue = Math.round(percentage * 10) / 10;
            setDragValue(newValue);
          }}
          onTouchEnd={() => {
            if (isDragging && !disabled) {
              onChange(dragValue);
              setIsDragging(false);
            }
          }}
        >
          {/* Progress Fill */}
          <div 
            className={`h-full rounded-full transition-all duration-200 pointer-events-none ${getColorClass(currentValue)}`}
            style={{ width: `${percentage}%` }}
          />
          
          {/* Draggable Handle */}
          <div 
            className={`progress-handle absolute top-1/2 w-5 h-5 bg-white border-2 border-gray-400 rounded-full shadow-md transform -translate-y-1/2 transition-all duration-200 cursor-pointer z-20 ${
              isDragging ? 'scale-125 border-primary' : 'hover:scale-110'
            }`}
            style={{ left: `${percentage}%`, marginLeft: '-8.5px' }}
            onMouseDown={(e) => {
              e.stopPropagation(); // Prevent event bubbling to progress bar
              e.preventDefault(); // Prevent any default behavior
              handleMouseDown(e);
            }}
          />
          
          {/* Level Markers */}
          <div className="absolute inset-0 flex justify-between items-center px-1 pointer-events-none">
            {[0, 0.2, 0.4, 0.6, 0.8, 1.0].map((mark) => (
              <div 
                key={mark}
                className={`w-1 h-1 rounded-full ${
                  mark <= currentValue ? 'bg-white' : 'bg-gray-400'
                }`}
              />
            ))}
          </div>
        </div>
        
        {/* Value Labels */}
        <div className="flex justify-between text-xs text-muted-foreground mt-1 select-none">
          <span>0.0</span>
          <span>0.5</span>
          <span>1.0</span>
        </div>
      </div>

      {/* Current Value Display */}
      <div className="flex flex-col items-center gap-1 min-w-[4rem] select-none">
        <span className="text-lg font-bold text-foreground">
          {currentValue.toFixed(1)}
        </span>
        <span className="text-xs text-muted-foreground">
          {percentage}%
        </span>
      </div>

      {/* Level Badge */}
      <div className="flex flex-col items-center gap-1 min-w-[5rem] select-none">
        <span className={`text-xs font-medium px-2 py-1 rounded-full ${getLevelColor(currentValue)}`}>
          {type === 'mastery' ? getMasteryLabel(currentValue) : getWeightLabel(currentValue)}
        </span>
      </div>
    </div>
  );
};

// Component for displaying mastery/weight with visual representation
export const ValueDisplay = ({ label, value, type, showLevelBadge = true }: { 
  label: string; 
  value: number; 
  type: 'mastery' | 'weight';
  showLevelBadge?: boolean;
}) => {
  const percentage = Math.round(value * 100);
  
  const getColorClass = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.8) return 'bg-green-500';
      if (val >= 0.6) return 'bg-blue-500';
      if (val >= 0.4) return 'bg-yellow-500';
      return 'bg-red-500';
    } else {
      if (val >= 0.8) return 'bg-purple-500';
      if (val >= 0.6) return 'bg-indigo-500';
      if (val >= 0.4) return 'bg-blue-500';
      return 'bg-gray-500';
    }
  };

  const getMasteryLabel = (val: number) => {
    if (val >= 0.9) return 'Expert';
    if (val >= 0.8) return 'Advanced';
    if (val >= 0.6) return 'Intermediate';
    if (val >= 0.4) return 'Beginner';
    return 'Novice';
  };

  const getWeightLabel = (val: number) => {
    if (val >= 0.8) return 'High';
    if (val >= 0.6) return 'Medium-High';
    if (val >= 0.4) return 'Medium';
    if (val >= 0.2) return 'Low-Medium';
    return 'Low';
  };

  const getLevelColor = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.8) return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200';
      if (val >= 0.6) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      if (val >= 0.4) return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200';
      return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
    } else {
      if (val >= 0.8) return 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200';
      if (val >= 0.6) return 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200';
      if (val >= 0.4) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200';
    }
  };

  return (
    <div className="flex items-center gap-3">
      <span className="text-sm font-medium text-muted-foreground">{label}:</span>
      <div className="flex items-center gap-3">
        {/* Visual Progress Bar */}
        <div className="w-20 h-2.5 bg-gray-200 rounded-full overflow-hidden border border-gray-300">
          <div 
            className={`h-full ${getColorClass(value)} transition-all duration-300 ease-out`}
            style={{ width: `${percentage}%` }}
          />
        </div>
        
        {/* Value and Percentage */}
        <div className="flex flex-col items-start gap-1">
          <span className="text-sm font-bold text-foreground">
            {percentage}%
          </span>
        </div>
        
        {/* Human-readable Label (optional) */}
        {showLevelBadge && (
          <div className="flex flex-col items-start gap-1">
            <span className={`text-xs font-medium px-2 py-1 rounded-full ${getLevelColor(value)}`}>
              {type === 'mastery' ? getMasteryLabel(value) : getWeightLabel(value)}
            </span>
          </div>
        )}
      </div>
    </div>
  );
};

// Utility function for getting level color (can be used elsewhere)
export const getLevelColor = (value: number, type: 'mastery' | 'weight') => {
  if (type === 'mastery') {
    if (value >= 0.8) return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200';
    if (value >= 0.6) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
    if (value >= 0.4) return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200';
    return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
  } else {
    if (value >= 0.8) return 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200';
    if (value >= 0.6) return 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200';
    if (value >= 0.4) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
    return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200';
  }
};

// Utility function for getting level label (can be used elsewhere)
export const getLevelLabel = (value: number, type: 'mastery' | 'weight') => {
  if (type === 'mastery') {
    if (value >= 0.9) return 'Expert';
    if (value >= 0.8) return 'Advanced';
    if (value >= 0.6) return 'Intermediate';
    if (value >= 0.4) return 'Beginner';
    return 'Novice';
  } else {
    if (value >= 0.8) return 'High';
    if (value >= 0.6) return 'Medium-High';
    if (value >= 0.4) return 'Medium';
    if (value >= 0.2) return 'Low-Medium';
    return 'Low';
  }
};

// Simple Level Badge Component for displaying mastery/weight levels
export const LevelBadge = ({ value, type, showLabel = true }: { 
  value: number; 
  type: 'mastery' | 'weight';
  showLabel?: boolean;
}) => {
  const getLevelColor = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.8) return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200';
      if (val >= 0.6) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      if (val >= 0.4) return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200';
      return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
    } else {
      if (val >= 0.8) return 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200';
      if (val >= 0.6) return 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200';
      if (val >= 0.4) return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
      return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200';
    }
  };

  const getLevelLabel = (val: number) => {
    if (type === 'mastery') {
      if (val >= 0.9) return 'Expert';
      if (val >= 0.8) return 'Advanced';
      if (val >= 0.6) return 'Intermediate';
      if (val >= 0.4) return 'Beginner';
      return 'Novice';
    } else {
      if (val >= 0.8) return 'High';
      if (val >= 0.6) return 'Medium-High';
      if (val >= 0.4) return 'Medium';
      if (val >= 0.2) return 'Low-Medium';
      return 'Low';
    }
  };

  return (
    <div className="flex items-center gap-2">
      {showLabel && (
        <span className="text-xs text-muted-foreground uppercase tracking-wide">
          {type === 'mastery' ? 'Target Mastery' : 'Weight'}
        </span>
      )}
      <span className={`text-xs font-medium px-1.5 py-0.5 rounded-full ${getLevelColor(value)}`}>
        {getLevelLabel(value)}
      </span>
    </div>
  );
};
