CREATE OR REPLACE FUNCTION recommend_questions(
    p_user_id               UUID,
    p_context               TEXT,             -- 'lesson' | 'global'
    p_lesson_id             UUID DEFAULT NULL,
    p_module_id             UUID DEFAULT NULL,
    p_limit                 INT DEFAULT 10,
    p_include_prerequisites BOOLEAN DEFAULT NULL,
    p_max_recency_days      INT DEFAULT 30,
    p_skip_recency_days     INT DEFAULT 3,
    p_per_kc_limit          INT DEFAULT 2
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
    -- Validate context
    IF p_context NOT IN ('lesson','global') THEN
        RAISE EXCEPTION 'Invalid p_context: %. Use ''lesson'' or ''global''.', p_context;
    END IF;
    IF p_context = 'lesson' AND p_lesson_id IS NULL THEN
        RAISE EXCEPTION 'p_lesson_id is required when p_context = ''lesson''.';
    END IF;

    -- Determine prerequisite inclusion default
    v_include_prereqs := COALESCE(p_include_prerequisites, p_context = 'global');

    RETURN QUERY
    WITH
    -- 1) Base KCs
    base_kcs AS (
        SELECT lkm.kc_id, lkm.target_mastery::NUMERIC AS target_mastery
        FROM lesson_kc_mapping lkm
        WHERE p_context = 'lesson' AND lkm.lesson_id = p_lesson_id

        UNION ALL

        SELECT kc.kc_id, 1.0::NUMERIC AS target_mastery
        FROM knowledge_components kc
        WHERE p_context = 'global'
          AND (p_module_id IS NULL OR kc.kc_id IN (
                SELECT mkm.kc_id FROM module_kc_mapping mkm WHERE mkm.module_id = p_module_id
          ))
    ),

    -- 2) Recursive prerequisites (only for global context)
    RECURSIVE prereq_kcs AS (
        SELECT mkp.kc_id, mkp.prerequisite_kc_id AS kc_id_prereq
        FROM module_kc_prerequisite mkp
        WHERE v_include_prereqs AND mkp.kc_id IN (SELECT kc_id FROM base_kcs)

        UNION ALL

        SELECT p.kc_id, mkp.prerequisite_kc_id
        FROM prereq_kcs p
        JOIN module_kc_prerequisite mkp ON mkp.kc_id = p.kc_id_prereq
    ),

    -- 3) User mastery
    user_mastery AS (
        SELECT rk.kc_id,
               COALESCE(ukm.p_mastery, 0.0)::NUMERIC AS p_mastery,
               rk.target_mastery
        FROM base_kcs rk
        LEFT JOIN user_kc_mastery ukm
               ON ukm.kc_id = rk.kc_id
              AND ukm.user_id = p_user_id
    ),

    -- 4) Candidate questions
    kc_questions AS (
        SELECT q.question_id, q.question_text, qkm.kc_id, qkm.weight::NUMERIC AS weight,
               um.p_mastery, um.target_mastery
        FROM user_mastery um
        JOIN question_kc_mapping qkm ON qkm.kc_id = um.kc_id
        JOIN questions q ON q.question_id = qkm.question_id
    ),

    -- 5) Last correct / skipped timestamps
    last_correct AS (
        SELECT ui.question_id, MAX(ui.timestamp) AS last_correct_answer
        FROM user_interactions ui
        WHERE ui.user_id = p_user_id AND ui.is_correct = TRUE
        GROUP BY ui.question_id
    ),

    last_skipped AS (
        SELECT ui.question_id, MAX(ui.timestamp) AS last_skipped_answer
        FROM user_interactions ui
        WHERE ui.user_id = p_user_id AND ui.interaction_type = 'QUESTION_SKIPPED'
        GROUP BY ui.question_id
    ),

    -- 6) Check prerequisite mastery (global context only)
    ready_to_learn AS (
        SELECT kq.*, 
               CASE 
                   WHEN p_context = 'lesson' THEN TRUE
                   ELSE
                       -- All prereqs mastered?
                       CASE 
                           WHEN COUNT(pk.kc_id_prereq) = 0 THEN TRUE
                           WHEN SUM(CASE WHEN COALESCE(um_pr.p_mastery,0.0) >= 1.0 THEN 0 ELSE 1 END) = 0 THEN TRUE
                           ELSE FALSE
                       END
               END AS ready
        FROM kc_questions kq
        LEFT JOIN prereq_kcs pk ON pk.kc_id = kq.kc_id
        LEFT JOIN user_kc_mastery um_pr ON um_pr.kc_id = pk.kc_id_prereq AND um_pr.user_id = p_user_id
        GROUP BY kq.question_id, kq.question_text, kq.kc_id, kq.weight, kq.p_mastery, kq.target_mastery
    ),

    -- 7) Compute recency
    with_recency AS (
        SELECT rtl.*,
               lc.last_correct_answer,
               ls.last_skipped_answer,
               CASE
                   WHEN lc.last_correct_answer IS NULL AND ls.last_skipped_answer IS NULL THEN 1.0
                   WHEN lc.last_correct_answer IS NOT NULL THEN
                       CASE
                           WHEN EXTRACT(EPOCH FROM (NOW() - lc.last_correct_answer))/86400 < p_max_recency_days THEN 0.0
                           WHEN EXTRACT(EPOCH FROM (NOW() - lc.last_correct_answer))/86400 < 3*p_max_recency_days THEN
                               (EXTRACT(EPOCH FROM (NOW() - lc.last_correct_answer))/86400 - p_max_recency_days)/(2*p_max_recency_days)
                           ELSE 1.0
                       END
                   WHEN ls.last_skipped_answer IS NOT NULL THEN
                       CASE
                           WHEN EXTRACT(EPOCH FROM (NOW() - ls.last_skipped_answer))/86400 < p_skip_recency_days THEN 0.0
                           ELSE 1.0
                       END
               END::NUMERIC AS recency_factor
        FROM ready_to_learn rtl
        LEFT JOIN last_correct lc ON lc.question_id = rtl.question_id
        LEFT JOIN last_skipped ls ON ls.question_id = rtl.question_id
        WHERE rtl.ready = TRUE
    ),

    -- 8) Final ranking with per-KC limit
    ranked AS (
        SELECT wr.*,
               (wr.weight * (wr.target_mastery - wr.p_mastery) * wr.recency_factor) AS priority_score,
               ROW_NUMBER() OVER (PARTITION BY wr.kc_id ORDER BY (wr.weight * (wr.target_mastery - wr.p_mastery) * wr.recency_factor) DESC, wr.question_id) AS kc_rank
        FROM with_recency wr
        WHERE (wr.target_mastery - wr.p_mastery) > 0 AND wr.recency_factor > 0
    )

    SELECT question_id, question_text, kc_id AS primary_kc, priority_score, 
           (target_mastery - p_mastery) AS mastery_gap, recency_factor, last_correct_answer
    FROM ranked
    WHERE kc_rank <= p_per_kc_limit
    ORDER BY priority_score DESC
    LIMIT p_limit;
END;
$$;
