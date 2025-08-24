-- Migration V33: Add experimental strategies for A/B testing
-- This migration adds support for assigning users to different experimental strategies
-- that control which interaction types trigger mastery updates

-- Create experimental strategies table
CREATE TABLE experimental_strategies (
    strategy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    strategy_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- Create strategy interaction rules table
-- Defines which interaction types trigger mastery updates for each strategy
CREATE TABLE strategy_interaction_rules (
    strategy_id UUID NOT NULL REFERENCES experimental_strategies(strategy_id) ON DELETE CASCADE,
    interaction_type VARCHAR(255) NOT NULL,
    mastery_update_weight DOUBLE PRECISION DEFAULT 1.0,
    is_required BOOLEAN DEFAULT false,
    created_at TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (strategy_id, interaction_type),
    CONSTRAINT valid_interaction_type CHECK (
        interaction_type IN (
            'LESSON_START', 'LESSON_EXIT', 'HINT_REQUESTED', 
            'SCAFFOLD_REQUESTED', 'SCAFFOLD_ATTEMPTED', 'SCAFFOLD_ANSWER',
            'QUESTION_PRESENTED', 'QUESTION_ATTEMPTED', 'QUESTION_SKIPPED'
        )
    )
);

-- Create user experimental assignments table
-- Links users to their assigned experimental strategy
CREATE TABLE user_experimental_assignments (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    strategy_id UUID NOT NULL REFERENCES experimental_strategies(strategy_id) ON DELETE RESTRICT,
    assigned_at TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    assigned_by UUID REFERENCES users(user_id) ON DELETE SET NULL,
    
    CONSTRAINT user_can_only_have_one_strategy UNIQUE (user_id)
);

-- Create indexes for performance
CREATE INDEX idx_strategy_interaction_rules_strategy_id ON strategy_interaction_rules(strategy_id);
CREATE INDEX idx_user_experimental_assignments_strategy_id ON user_experimental_assignments(strategy_id);
CREATE INDEX idx_user_experimental_assignments_assigned_by ON user_experimental_assignments(assigned_by);

-- Insert default experimental strategies
INSERT INTO experimental_strategies (strategy_name, description) VALUES
('CONTROL', 'Control group: Only QUESTION_ATTEMPTED interactions update mastery'),
('HINT_SUPPORT', 'Hint support group: QUESTION_ATTEMPTED + HINT_REQUESTED interactions update mastery'),
('SCAFFOLD_SUPPORT', 'Scaffold support group: QUESTION_ATTEMPTED + SCAFFOLD_ATTEMPTED interactions update mastery'),
('FULL_SUPPORT', 'Full support group: QUESTION_ATTEMPTED + HINT_REQUESTED + SCAFFOLD_ATTEMPTED interactions update mastery');

-- Insert default interaction rules for each strategy
-- CONTROL strategy: only QUESTION_ATTEMPTED
INSERT INTO strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required) 
SELECT strategy_id, 'QUESTION_ATTEMPTED', 1.0, true 
FROM experimental_strategies WHERE strategy_name = 'CONTROL';

-- HINT_SUPPORT strategy: QUESTION_ATTEMPTED + HINT_REQUESTED
INSERT INTO strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required) VALUES
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'HINT_SUPPORT'), 'QUESTION_ATTEMPTED', 1.0, true),
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'HINT_SUPPORT'), 'HINT_REQUESTED', 0.5, true);

-- SCAFFOLD_SUPPORT strategy: QUESTION_ATTEMPTED + SCAFFOLD_ATTEMPTED
INSERT INTO strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required) VALUES
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'SCAFFOLD_SUPPORT'), 'QUESTION_ATTEMPTED', 1.0, true),
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'SCAFFOLD_SUPPORT'), 'SCAFFOLD_ATTEMPTED', 0.3, true);

-- FULL_SUPPORT strategy: QUESTION_ATTEMPTED + HINT_REQUESTED + SCAFFOLD_ATTEMPTED
INSERT INTO strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required) VALUES
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'FULL_SUPPORT'), 'QUESTION_ATTEMPTED', 1.0, true),
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'FULL_SUPPORT'), 'HINT_REQUESTED', 0.5, true),
((SELECT strategy_id FROM experimental_strategies WHERE strategy_name = 'FULL_SUPPORT'), 'SCAFFOLD_ATTEMPTED', 0.3, true);

-- Assign all existing users to CONTROL strategy by default
INSERT INTO user_experimental_assignments (user_id, strategy_id)
SELECT u.user_id, es.strategy_id
FROM users u
CROSS JOIN experimental_strategies es
WHERE es.strategy_name = 'CONTROL'
ON CONFLICT (user_id) DO NOTHING;
