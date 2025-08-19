-- ============================================================
-- Function: recommend_questions
-- Purpose : Unified adaptive question recommendation engine
-- Contexts:
--   - 'lesson' : reinforce KCs from a specific lesson
--   - 'global' : practice across all (or module-filtered) KCs
--
-- Scoring:
--   priority_score =
--       qkm.weight
--     * mastery_gap                -- GREATEST(0, target_mastery - p_mastery)
--     * recency_factor             -- 0..1 based on time since last correct
--
-- Recency (spaced repetition):
--   - Never answered correctly            => recency_factor = 1.0
--   - Correct < p_max_recency_days ago    => 0.0 (skip)
--   - Correct between p_max and 3*p_max   => linear ramp 0..1
--   - Correct >= 3*p_max                  => 1.0
--
-- Prerequisites:
--   - Default: OFF for 'lesson', ON for 'global' (can be overridden)
--
-- Diversity:
--   - Limit how many questions per KC using p_per_kc_limit
--
-- Returns:
--   question_id, question_text, primary_kc, priority_score,
--   mastery_gap, recency_factor, last_correct_answer
-- ============================================================
CREATE OR REPLACE FUNCTION recommend_questions(
    p_user_id              UUID,
    p_context              TEXT,             -- 'lesson' | 'global'
    p_lesson_id            UUID DEFAULT NULL,
    p_module_id            UUID DEFAULT NULL,
    p_limit                INT  DEFAULT 10,
    p_include_prerequisites BOOLEAN DEFAULT NULL,  -- NULL => auto by context
    p_max_recency_days     INT  DEFAULT 30,
    p_per_kc_limit         INT  DEFAULT 2
)
RETURNS TABLE (
    question_id UUID,
    question_text TEXT,
    primary_kc UUID,
    priority_score NUMERIC,
    mastery_gap NUMERIC,
    recency_factor NUMERIC,
    last_correct_answer TIMESTAMP
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_include_prereqs BOOLEAN;
BEGIN
    -- -----------------------------
    -- Validate context & parameters
    -- -----------------------------
    IF p_context NOT IN ('lesson', 'global') THEN
        RAISE EXCEPTION 'Invalid p_context: %. Use ''lesson'' or ''global''.', p_context;
    END IF;

    IF p_context = 'lesson' AND p_lesson_id IS NULL THEN
        RAISE EXCEPTION 'p_lesson_id is required when p_context = ''lesson''.';
    END IF;

    -- Decide default behavior for prerequisites by context if not explicitly set
    v_include_prereqs := COALESCE(p_include_prerequisites, p_context = 'global');

    RETURN QUERY
    WITH
    -- 1) Seed KCs based on context
    base_kcs AS (
        -- Lesson context: take KCs from lesson_kc_mapping
        SELECT lkm.kc_id,
               lkm.target_mastery::NUMERIC AS target_mastery
        FROM lesson_kc_mapping lkm
        WHERE p_context = 'lesson' AND lkm.lesson_id = p_lesson_id

        UNION ALL

        -- Global context: all KCs (optionally filtered by module)
        SELECT kc.kc_id,
               1.0::NUMERIC AS target_mastery
        FROM knowledge_components kc
        WHERE p_context = 'global'
          AND (
              p_module_id IS NULL
              OR kc.kc_id IN (
                    SELECT mkm.kc_id
                    FROM module_kc_mapping mkm
                    WHERE mkm.module_id = p_module_id
              )
          )
    ),

    -- 2) Optional prerequisite expansion
    prereq_kcs AS (
        -- If using prerequisites, pull distinct prerequisite_kc_id
        -- We use the edges from module_kc_prerequisite; if module filter is provided,
        -- prefer edges for that module; otherwise include across all modules.
        SELECT DISTINCT mkp.prerequisite_kc_id AS kc_id,
               1.0::NUMERIC AS target_mastery
        FROM module_kc_prerequisite mkp
        WHERE v_include_prereqs
          AND mkp.kc_id IN (SELECT kc_id FROM base_kcs)
          AND (
               p_module_id IS NULL
               OR mkp.module_id = p_module_id
          )
    ),

    -- 3) Relevant KCs = base + (optional) prerequisites
    relevant_kcs AS (
        SELECT kc_id, target_mastery FROM base_kcs
        UNION
        SELECT kc_id, target_mastery FROM prereq_kcs
    ),

    -- 4) User mastery for relevant KCs (default 0 if missing)
    user_mastery AS (
        SELECT rk.kc_id,
               rk.target_mastery,
               COALESCE(ukm.p_mastery, 0.0)::NUMERIC AS p_mastery
        FROM relevant_kcs rk
        LEFT JOIN user_kc_mastery ukm
               ON ukm.kc_id = rk.kc_id
              AND ukm.user_id = p_user_id
    ),

    -- 5) Candidate questions mapped to relevant KCs
    kc_questions AS (
        SELECT
            q.question_id,
            q.question_text,
            qkm.kc_id,
            qkm.weight::NUMERIC AS weight,
            um.target_mastery,
            um.p_mastery
        FROM user_mastery um
        JOIN question_kc_mapping qkm ON qkm.kc_id = um.kc_id
        JOIN questions q ON q.question_id = qkm.question_id
    ),

    -- 6) Last correct answer timestamp per question for this user
    last_correct AS (
        SELECT
            ui.question_id,
            MAX(ui.timestamp) AS last_correct_answer
        FROM user_interactions ui
        WHERE ui.user_id = p_user_id
          AND ui.is_correct = TRUE
        GROUP BY ui.question_id
    ),

    -- 7) Join recency & compute factors
    scored AS (
        SELECT
            kq.question_id,
            kq.question_text,
            kq.kc_id AS primary_kc,
            kq.weight,
            GREATEST(0, kq.target_mastery - kq.p_mastery)::NUMERIC AS mastery_gap,
            lc.last_correct_answer,
            -- Compute recency_factor based on p_max_recency_days
            CASE
                WHEN lc.last_correct_answer IS NULL THEN 1.0
                ELSE
                    -- Age in whole days
                    GREATEST(0, EXTRACT(EPOCH FROM (NOW() - lc.last_correct_answer)) / 86400.0)
            END AS age_days
        FROM kc_questions kq
        LEFT JOIN last_correct lc ON lc.question_id = kq.question_id
    ),

    -- 8) Apply recency curve and drop recent-correct (< p_max_recency_days)
    with_recency AS (
        SELECT
            s.question_id,
            s.question_text,
            s.primary_kc,
            s.mastery_gap,
            s.last_correct_answer,
            CASE
                WHEN s.last_correct_answer IS NULL THEN 1.0
                WHEN s.age_days < p_max_recency_days THEN 0.0
                WHEN s.age_days >= p_max_recency_days
                     AND s.age_days < (3 * p_max_recency_days)
                    THEN (s.age_days - p_max_recency_days) / (2.0 * p_max_recency_days)
                ELSE 1.0
            END::NUMERIC AS recency_factor,

            -- priority_score uses the *original* weight; we need it here:
            -- join back to weight via question_id+kc_id is already in 'scored' (but weight not kept).
            -- Quick re-join to get weight: (safe because mapping is per (question,kc))
            (SELECT qkm.weight::NUMERIC
             FROM question_kc_mapping qkm
             WHERE qkm.question_id = s.question_id
               AND qkm.kc_id = s.primary_kc
             LIMIT 1) AS weight
        FROM scored s
    ),

    -- 9) Compute final score and enforce per-KC diversity
    ranked AS (
        SELECT
            wr.question_id,
            wr.question_text,
            wr.primary_kc,
            (wr.weight * wr.mastery_gap * wr.recency_factor)::NUMERIC AS priority_score,
            wr.mastery_gap,
            wr.recency_factor,
            wr.last_correct_answer,
            ROW_NUMBER() OVER (
                PARTITION BY wr.primary_kc
                ORDER BY (wr.weight * wr.mastery_gap * wr.recency_factor) DESC, wr.question_id
            ) AS kc_rank
        FROM with_recency wr
        WHERE wr.recency_factor > 0   -- drops very-recently-correct
          AND wr.mastery_gap > 0      -- only if there is learning value
    )

    SELECT
        r.question_id,
        r.question_text,
        r.primary_kc,
        r.priority_score,
        r.mastery_gap,
        r.recency_factor,
        r.last_correct_answer::TIMESTAMP
    FROM ranked r
    WHERE r.kc_rank <= p_per_kc_limit
    ORDER BY r.priority_score DESC
    LIMIT p_limit;
END;
$$;
