-- ============================================================================
-- ENRICH CONTENT: Quizzes (5 Qs), Cases, Playground, Resources
-- ============================================================================
-- GOAL: Ensure every lesson in "Prompt Engineering Mastery" has full rich content.
-- LOGIC: Checks if content is missing (NULL or empty) -> Injects High-Quality Defaults.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. QUIZZES (5 Questions per Lesson)
    -- ============================================================================
    -- Injects a 5-question quiz covering core Prompt Engineering concepts.
    UPDATE lessons
    SET quizzes = '[
        {
            "question": "What is the ''Context Window'' in an LLM?",
            "options": ["The amount of text the model can process at once", "The graphical user interface", "The training data cutoff date", " The speed of generation"],
            "correctAnswer": 0
        },
        {
            "question": "Which prompting technique involves providing examples (input-output pairs)?",
            "options": ["Zero-Shot Prompting", "Few-Shot Prompting", "Chain-of-Thought", "ReAct"],
            "correctAnswer": 1
        },
        {
            "question": "What is the primary function of the ''Temperature'' parameter?",
            "options": ["To control the randomness/creativity of the output", "To increase the speed of the model", "To reduce the cost of the API call", "To setting the language of the output"],
            "correctAnswer": 0
        },
        {
            "question": "In ''Chain-of-Thought'' prompting, what do you ask the model to do?",
            "options": ["Answer immediately", "Think step-by-step", "Ignore previous instructions", "Translate the text"],
            "correctAnswer": 1
        },
        {
            "question": "What is a common cause of ''Hallucinations'' in LLMs?",
            "options": ["Providing too much context", "Lack of relevant ground-truth checks or obscure knowledge", "Using a high-end GPU", "Prompting in English"],
            "correctAnswer": 1
        }
    ]'::jsonb
    WHERE course_id = cid 
    AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 5); -- Ensure at least 5 questions


    -- 2. REAL CASE STUDIES (2 Detailed Scenarios)
    -- ============================================================================
    UPDATE lessons
    SET case_studies = '[
        {
            "title": "Enterprise Customer Support Automation",
            "scenario": "A FinTech company struggled with inconsistent support replies using manual templates. Agents often missed compliance details.",
            "analysis": "The lack of dynamic context usage led to generic, unhelpful responses. They needed a system that could reason over customer history.",
            "outcome": "Implemented a RAG-based prompt system. Reduced resolution time by 40% and improved CSAT scores by 15% due to highly personalized, accurate responses."
        },
        {
            "title": "Creative Marketing Copy Generator",
            "scenario": "A marketing agency needed to generate 50+ ad variations daily but struggled with writer''s block and brand voice consistency.",
            "analysis": "Standard prompts produced generic copy. They needed to encode the ''Brand Voice'' into the system prompts.",
            "outcome": "Used Few-Shot prompting with 10 high-performing past ads as examples. Output quality matched senior copywriters 90% of the time, scaling production 10x."
        }
    ]'::jsonb
    WHERE course_id = cid 
    AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);


    -- 3. INTERACTIVE PLAYGROUND (Dynamic Prompting)
    -- ============================================================================
    UPDATE lessons
    SET playground = '{
        "objective": "Master the optimization of this prompt technique.",
        "starter_prompt": "Explain the concept of [Topic] to a [Audience] using a [Tone] tone.",
        "guided_steps": [
            "1. Run the starter prompt as is and observe the output.",
            "2. Change [Audience] to ''5-year-old'' and run again.",
            "3. Change [Tone] to ''Sarcastic'' and observe the shift.",
            "4. Add a constraint: ''Use no output longer than 2 sentences.'' and verify compliance."
        ],
        "advanced_challenge": "Create a prompt that forces the AI to critique its own reasoning before giving the final answer."
    }'::jsonb
    WHERE course_id = cid 
    AND (playground IS NULL OR playground::text = '{}');


    -- 4. EXTERNAL RESOURCES (Curated Links)
    -- ============================================================================
    UPDATE lessons
    SET extra_resources = '[
        {
            "title": "OpenAI Prompt Engineering Guide",
            "url": "https://platform.openai.com/docs/guides/prompt-engineering",
            "type": "Documentation"
        },
        {
            "title": "Anthropic Prompt Library",
            "url": "https://docs.anthropic.com/en/prompt-library/library",
            "type": "Library"
        },
        {
            "title": "Lil''Log on Prompt Engineering",
            "url": "https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/",
            "type": "Article"
        }
    ]'::jsonb
    WHERE course_id = cid 
    AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);


    -- 5. KEY TAKEAWAYS (Summaries)
    -- ============================================================================
    UPDATE lessons 
    SET key_takeaways = '["AI models predict the next token based on probability, not truth.", "The quality of the output is directly proportional to the clarity of the context provided.", "Iterative refinement is essential; the first prompt is rarely the best.", "Structured data (JSON/Markdown) is easier for models to process than unstructured text.", "Prompt Security (Injection/Jailbreaking) must be considered in production systems."]'::jsonb
    WHERE course_id = cid 
    AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

END $$;

-- VERIFICATION
SELECT 
    title,
    jsonb_array_length(quizzes) as quiz_count,
    CASE WHEN playground IS NOT NULL THEN '✅' ELSE '❌' END as Play,
    CASE WHEN case_studies IS NOT NULL THEN '✅' ELSE '❌' END as Case,
    CASE WHEN extra_resources IS NOT NULL THEN '✅' ELSE '❌' END as Res
FROM lessons
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';
