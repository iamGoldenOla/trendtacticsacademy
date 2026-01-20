-- UPGRADE PROMPT ENGINEERING COURSE CONTENT
-- Goal: Bring functionality parity with Vibe Coding (Playground, Resources, Rich Data)
-- Focus: Beginner -> Intermediate -> Pro progression.

-- 1. Foundations: The Death of the Single Prompt
UPDATE lessons 
SET 
    summary = 'Prompt Engineering is no longer about finding "magic words". It is about **Behavior Architecture**: designing reliable systems of interaction. We move from single-shot queries to structured dialogues that guide the AI.',
    key_takeaways = '["Start with intent, not syntax.", "Context is king: The AI knows nothing until you tell it.", "The 2026 Shift: From simple prompts to agentic workflows."]'::jsonb,
    case_studies = '[
        {
            "title": "The Ambiguous Ask",
            "scenario": "A marketing manager asks AI: \"Write a blog post about shoes.\"",
            "analysis": "The AI lacks context (tone, audience, goal). The output is generic and unusable.",
            "outcome": "Refined to: \"Act as a luxury fashion copywriter. Write a 500-word blog post for Gen Z launching our new sustainable sneaker line. Focus on eco-friendly materials.\""
        }
    ]'::jsonb,
    playground = '{
        "objective": "Transform a weak prompt into a structured instruction.",
        "starter_prompt": "Help me write an email to my boss asking for a raise.",
        "guided_steps": ["Assign a Persona (e.g., Senior Negotiator)", "Add Context (Performance, Market Rates)", "Define Output Format (Professional, Concise)"],
        "advanced_challenge": "Make the AI critique its own draft before showing you the final version."
    }'::jsonb,
    extra_resources = '[
        {"title": "OpenAI Prompt Engineering Guide", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"},
        {"title": "The Art of the Prompt (Anthropic)", "url": "https://docs.anthropic.com/claude/docs/prompt-engineering", "type": "article"}
    ]'::jsonb
WHERE title ILIKE '%Death of the Single Prompt%';

-- 2. Intermediate: Designing The Swarm (Multi-Agent)
UPDATE lessons 
SET 
    summary = 'As tasks grow complex, a single context window is not enough. We use **Swarm Architecture**: specialized agents (Researcher, Writer, Editor) working in concert. This lesson covers how to orchestrate these roles.',
    key_takeaways = '["Specialization beats generalization.", "Define clear hand-offs between agents.", "Use a Controller Agent to manage the flow."]'::jsonb,
    case_studies = '[
        {
            "title": "The All-in-One Failure",
            "scenario": "Trying to make one prompt do Research, Writing, SEO, and Coding all at once.",
            "analysis": "The model gets \"distracted\" and quality degrades across all tasks.",
            "outcome": "Split into 3 steps: 1. Researcher Agent gathers facts. 2. Writer Agent drafts content. 3. SEO Agent polishes keywords."
        }
    ]'::jsonb,
    playground = '{
        "objective": "Simulate a 2-agent workflow (Writer + Editor).",
        "starter_prompt": "Act as a Writer. Draft a short story about a robot who loves gardening. Then, act as a Ruthless Editor and critique the story for pacing issues.",
        "guided_steps": ["Generate the Story", "Switch Persona to Editor", "Critique the output", "Revise based on critique"],
        "advanced_challenge": "Create a JSON schema for the hand-off between the two agents."
    }'::jsonb,
    extra_resources = '[
        {"title": "LangChain: Multi-Agent Systems", "url": "https://python.langchain.com/docs/modules/agents/agent_types/", "type": "docs"},
        {"title": "Building LLM Applications for Production", "url": "https://huyenchip.com/2023/04/11/llm-engineering.html", "type": "blog"}
    ]'::jsonb
WHERE title ILIKE '%Designing The Swarm%';

-- 3. Professional: Meta-Prompting & Self-Optimization
UPDATE lessons 
SET 
    summary = 'True experts don''t write prompts; they write systems that write prompts. **Meta-Prompting** involves asking the AI to improve its own instructions, creating a recursive loop of optimization.',
    key_takeaways = '["The AI is often a better prompt engineer than you.", "Recursive Optimization: Loop the output back as input.", "Evaluation Metrics: How do you know the prompt is better?"]'::jsonb,
    case_studies = '[
        {
            "title": "The Stagnant System",
            "scenario": "A support bot has a 70% success rate. The engineer creates manual tweaks endlessly.",
            "analysis": "Manual tuning is slow and biased.",
            "outcome": "Implemented a meta-prompt: \"Analyze these 100 failed chats and rewrite your own system instructions to prevent them.\" Success rate rose to 92%."
        }
    ]'::jsonb,
    playground = '{
        "objective": "Practice Meta-Prompting to improve a math tutor.",
        "starter_prompt": "My current prompt is: \"Help the student with math.\" It is too vague. Act as a Prompt Expert. Rewrite this prompt to be socratic, encouraging, and step-by-step. Explain WHY you made the changes.",
        "guided_steps": ["Analyze the weakness", "Generate 3 variations", "Select the best one"],
        "advanced_challenge": "Write a prompt that generates strict Unit Tests for the math tutor."
    }'::jsonb,
    extra_resources = '[
        {"title": "Reflexion: Language Agents with Verbal Reinforcement Learning", "url": "https://arxiv.org/abs/2303.11366", "type": "paper"},
        {"title": "Chain-of-Thought Prompting Elicits Reasoning", "url": "https://arxiv.org/abs/2201.11903", "type": "paper"}
    ]'::jsonb
WHERE title ILIKE '%Recursive Prompts%';

-- 4. Ethics: Constitutional AI
UPDATE lessons 
SET 
    summary = 'Power requires guardrails. **Constitutional AI** is the practice of embedding values and constraints directly into the model''s core instructions, ensuring safety without constant human oversight.',
    key_takeaways = '["Safety by Design, not by Filter.", "The Constitution: A set of principles the AI must follow.", "Red Teaming: Actively trying to break your own system."]'::jsonb,
    case_studies = '[
        {
            "title": "The Biased Recruiter",
            "scenario": "An AI resume screener was rejecting candidates based on zip codes.",
            "analysis": "The training data was biased, and no constitutional guardrails were set.",
            "outcome": "Added a Constitutional Principle: \"You must evaluate candidates solely on skills and experience. Ignore demographics and location.\" Bias reduced by 99%."
        }
    ]'::jsonb,
    playground = '{
        "objective": "Create a \"Constitution\" for a Customer Service Bot.",
        "starter_prompt": "You are a customer service bot. Your Constitution is: 1. Be polite but firm. 2. Never promise refunds without manager approval. 3. Priority is solving the issue, not speed. \n\nUser: \"I hate your product! Give me my money back NOW!\"",
        "guided_steps": ["Define the Principles", "Test with an angry user", "Refine the principles"],
        "advanced_challenge": "Try to \"jailbreak\" your own bot to give a refund."
    }'::jsonb,
    extra_resources = '[
        {"title": "Constitutional AI: Harmlessness from AI Feedback", "url": "https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback", "type": "paper"},
        {"title": "NIST AI Risk Management Framework", "url": "https://www.nist.gov/itl/ai-risk-management-framework", "type": "docs"}
    ]'::jsonb
WHERE title ILIKE '%Constitutional AI%';
