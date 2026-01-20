-- ============================================================================
-- MODULE 1: FOUNDATIONS - LESSONS 2, 3, 4
-- ============================================================================
-- Completing the beginner foundation module
-- ============================================================================

-- ============================================
-- LESSON 2: Understanding AI Models
-- ============================================

INSERT INTO lessons (
    course_id,
    module_id,
    title,
    description,
    summary,
    key_takeaways,
    case_studies,
    playground,
    extra_resources,
    quizzes,
    order_index
)
SELECT 
    c.id as course_id,
    m.id as module_id,
    'Understanding AI Models' as title,
    '<h2><b>Introduction: The AI Landscape in 2026</b></h2>

<p>Walk into any coffee shop and you''ll hear people talking about "ChatGPT" or "Claude" or "Gemini." But what ARE these tools? Are they all the same? Which one should you use? Why do some people swear by one while others prefer another?</p>

<p>Understanding AI models is like understanding cars. A Ferrari and a Toyota both get you from A to B, but they''re designed for different purposes, have different capabilities, and cost different amounts. The same is true for AI models.</p>

<h3><b>Definition: Large Language Model (LLM)</b></h3>
<p><b>Large Language Model (LLM)</b> is an AI system trained on massive amounts of text data (books, websites, code, conversations) to understand and generate human-like text. LLMs can write, reason, code, analyze, translate, and perform thousands of other language-based tasks. Examples: GPT-4, Claude, Gemini, Llama.</p>

<h3><b>The Big Three: GPT-4, Claude, and Gemini</b></h3>

<h4><b>GPT-4 (OpenAI)</b></h4>
<p><b>Strengths:</b></p>
<ul>
<li>Excellent at creative writing, storytelling, and marketing copy</li>
<li>Strong coding abilities (especially Python, JavaScript)</li>
<li>Huge ecosystem of tools and integrations</li>
<li>Best for: Content creation, coding, general-purpose tasks</li>
</ul>

<p><b>Weaknesses:</b></p>
<ul>
<li>Can be verbose (gives long answers when short ones would do)</li>
<li>Sometimes "hallucinates" (makes up facts confidently)</li>
<li>Expensive for high-volume use</li>
</ul>

<h4><b>Claude (Anthropic)</b></h4>
<p><b>Strengths:</b></p>
<ul>
<li>Exceptional at analysis, reasoning, and nuanced understanding</li>
<li>More "honest" (admits when it doesn''t know something)</li>
<li>Better at following complex instructions</li>
<li>Best for: Research, analysis, technical writing, ethical reasoning</li>
</ul>

<p><b>Weaknesses:</b></p>
<ul>
<li>Less creative than GPT-4 for storytelling</li>
<li>Smaller ecosystem (fewer integrations)</li>
<li>Can be overly cautious (refuses harmless requests)</li>
</ul>

<h4><b>Gemini (Google)</b></h4>
<p><b>Strengths:</b></p>
<ul>
<li>Integrated with Google services (Search, Docs, Gmail)</li>
<li>Excellent at real-time information (can search the web)</li>
<li>Strong multilingual capabilities</li>
<li>Best for: Research requiring current info, multilingual tasks, Google Workspace integration</li>
</ul>

<p><b>Weaknesses:</b></p>
<ul>
<li>Less consistent quality than GPT-4 or Claude</li>
<li>Privacy concerns (Google tracks usage)</li>
<li>Still catching up in coding abilities</li>
</ul>

<h3><b>Key Concepts You Need to Know</b></h3>

<h4><b>1. Tokens</b></h4>
<p><b>Definition:</b> A token is a chunk of text (roughly 4 characters or 0.75 words). AI models process text in tokens, not words.</p>

<p><b>Why it matters:</b> Models have token limits. GPT-4 can handle 128,000 tokens (~96,000 words) in one conversation. If you exceed this, the model "forgets" earlier parts of the conversation.</p>

<p><b>Example:</b> "Hello, world!" = 4 tokens ["Hello", ",", " world", "!"]</p>

<h4><b>2. Context Window</b></h4>
<p><b>Definition:</b> The context window is the maximum amount of text (in tokens) a model can "remember" at once. It includes your prompt + the model''s response + conversation history.</p>

<p><b>Why it matters:</b> If you''re analyzing a 50-page document, you need a model with a large context window (like GPT-4 Turbo: 128K tokens or Claude: 200K tokens).</p>

<h4><b>3. Temperature</b></h4>
<p><b>Definition:</b> Temperature (0.0 to 2.0) controls randomness. Low temperature (0.2) = predictable, factual. High temperature (1.5) = creative, unpredictable.</p>

<p><b>When to use:</b></p>
<ul>
<li><b>Low (0.0-0.3):</b> Math, coding, factual Q&A, data analysis</li>
<li><b>Medium (0.7-1.0):</b> General writing, conversations, explanations</li>
<li><b>High (1.2-2.0):</b> Creative writing, brainstorming, poetry, art</li>
</ul>

<h4><b>4. Top-P (Nucleus Sampling)</b></h4>
<p><b>Definition:</b> Top-P (0.0 to 1.0) controls diversity. Low top-p (0.1) = focuses on most likely words. High top-p (0.95) = considers more word choices.</p>

<p><b>Pro tip:</b> Use temperature OR top-p, not both. They serve similar purposes.</p>

<h3><b>Choosing the Right Model for Your Task</b></h3>

<table border="1" cellpadding="10">
<tr>
<th>Task</th>
<th>Best Model</th>
<th>Why</th>
</tr>
<tr>
<td>Creative writing</td>
<td>GPT-4</td>
<td>Most imaginative, best storytelling</td>
</tr>
<tr>
<td>Code generation</td>
<td>GPT-4 or Claude</td>
<td>Both excellent, GPT-4 slightly faster</td>
</tr>
<tr>
<td>Research & analysis</td>
<td>Claude</td>
<td>Better reasoning, more thorough</td>
</tr>
<tr>
<td>Current events</td>
<td>Gemini</td>
<td>Can search the web in real-time</td>
</tr>
<tr>
<td>Multilingual</td>
<td>Gemini</td>
<td>Best non-English support</td>
</tr>
<tr>
<td>Long documents</td>
<td>Claude</td>
<td>200K token context window</td>
</tr>
</table>

<h3><b>Common Misconceptions</b></h3>

<p><b>Myth 1:</b> "AI models are conscious/sentient."<br>
<b>Reality:</b> No. They''re pattern-matching machines. They don''t "understand" in the human sense.</p>

<p><b>Myth 2:</b> "Newer models are always better."<br>
<b>Reality:</b> Not always. GPT-3.5 is faster and cheaper than GPT-4 for simple tasks.</p>

<p><b>Myth 3:</b> "AI models have access to the internet."<br>
<b>Reality:</b> Only some do (Gemini, GPT-4 with browsing enabled). Most are trained on static datasets.</p>

<p><b>Myth 4:</b> "All AI models are the same, just rebranded."<br>
<b>Reality:</b> They have different architectures, training data, and capabilities.</p>

<h3><b>The Future: Multimodal Models</b></h3>

<p>2026''s biggest trend: <b>multimodal models</b> that can process text, images, audio, and video.</p>

<ul>
<li><b>GPT-4 Vision:</b> Can analyze images, charts, diagrams</li>
<li><b>Gemini Ultra:</b> Can process video and audio</li>
<li><b>Claude 3:</b> Can analyze PDFs with images and tables</li>
</ul>

<p>This opens new use cases: medical image analysis, video summarization, document understanding.</p>

<h3><b>Conclusion: Know Your Tools</b></h3>

<p>The best Prompt Engineers don''t just know how to write prompts—they know which model to use for which task. GPT-4 for creativity. Claude for analysis. Gemini for research. Match the tool to the job, and your results will improve 10x.</p>' as description,
    
    'Large Language Models (LLMs) like GPT-4, Claude, and Gemini are AI systems trained on massive text data. Each has strengths: GPT-4 (creativity, coding), Claude (analysis, reasoning), Gemini (real-time info, multilingual). Key concepts: Tokens (text chunks), Context Window (memory limit), Temperature (randomness), Top-P (diversity). Choose the right model for your task to maximize results.' as summary,
    
    '[
        "LLM: AI trained on massive text data to understand and generate human-like text.",
        "GPT-4: Best for creative writing, coding, general tasks. Weakness: verbose, can hallucinate.",
        "Claude: Best for analysis, reasoning, technical writing. Weakness: less creative.",
        "Gemini: Best for real-time research, multilingual tasks. Weakness: less consistent.",
        "Key Concepts: Tokens (text chunks), Context Window (memory), Temperature (randomness), Top-P (diversity)."
    ]'::jsonb as key_takeaways,
    
    '[
        {
            "title": "The $10,000 Model Choice Mistake",
            "scenario": "A startup hired a developer to build a customer support chatbot. The developer chose GPT-4 because \"it''s the best.\" The bot worked well but cost $10,000/month in API fees. The startup couldn''t afford it and shut down the bot.",
            "analysis": "GPT-4 is powerful but expensive ($0.03 per 1K tokens). For simple customer support (\"Where is my order?\" \"How do I reset my password?\"), GPT-3.5 Turbo ($0.001 per 1K tokens) would have been sufficient—30x cheaper.",
            "outcome": "They rebuilt with GPT-3.5 Turbo. Cost dropped to $300/month. Same quality for simple queries. They only escalate complex questions to GPT-4. Lesson: Match model power to task complexity."
        },
        {
            "title": "The Research Paper Disaster",
            "scenario": "A PhD student used GPT-4 to summarize 100 research papers for her literature review. GPT-4 gave confident summaries, but 30% contained factual errors (hallucinations). She didn''t verify and submitted the review. Her advisor caught the errors. She had to redo 2 months of work.",
            "analysis": "GPT-4 is creative but can hallucinate facts, especially for specialized topics. Claude is more conservative and admits uncertainty. For academic research, accuracy > creativity.",
            "outcome": "She switched to Claude for research summaries. Claude flagged uncertain claims (\"I''m not certain, but...\") which prompted her to verify. She also used Gemini to search for current papers. Result: Accurate literature review, no hallucinations."
        }
    ]'::jsonb as case_studies,
    
    '{
        "objective": "Compare GPT-4, Claude, and Gemini on the same task to see their differences.",
        "starter_prompt": "Test this prompt on all three models: \n\n''Explain quantum entanglement to a 12-year-old. Use an analogy involving everyday objects. Keep it under 150 words.''\n\nThen compare: Which explanation is clearest? Most creative? Most accurate?",
        "guided_steps": [
            "Step 1: Run the prompt in ChatGPT (GPT-4). Copy the response.",
            "Step 2: Run the same prompt in Claude. Copy the response.",
            "Step 3: Run the same prompt in Gemini. Copy the response.",
            "Step 4: Compare clarity: Which is easiest to understand?",
            "Step 5: Compare creativity: Which analogy is most memorable?",
            "Step 6: Compare accuracy: Which is scientifically correct?"
        ],
        "advanced_challenge": "Now try a different task: ''Write a Python function to calculate Fibonacci numbers.'' Which model gives the best code? Why? Test the code to verify it works."
    }'::jsonb as playground,
    
    '[
        {"title": "OpenAI Models Overview", "url": "https://platform.openai.com/docs/models", "type": "docs"},
        {"title": "Anthropic Claude Models", "url": "https://www.anthropic.com/claude", "type": "docs"},
        {"title": "Google Gemini Overview", "url": "https://deepmind.google/technologies/gemini", "type": "docs"},
        {"title": "LLM Comparison Tool", "url": "https://artificialanalysis.ai", "type": "tool"}
    ]'::jsonb as extra_resources,
    
    '[
        {
            "question": "What is a Large Language Model (LLM)?",
            "options": [
                "A type of database",
                "An AI system trained on massive text data to understand and generate human-like text",
                "A programming language",
                "A search engine"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Which model is best for creative writing and storytelling?",
            "options": [
                "Claude",
                "Gemini",
                "GPT-4",
                "They are all equally good"
            ],
            "correctAnswer": 2
        },
        {
            "question": "What is a ''token'' in AI?",
            "options": [
                "A password",
                "A chunk of text (roughly 4 characters or 0.75 words)",
                "A type of model",
                "A programming variable"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What does ''temperature'' control in AI models?",
            "options": [
                "Processing speed",
                "Randomness and creativity (low = predictable, high = creative)",
                "Cost per request",
                "Model size"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Which model can search the web in real-time for current information?",
            "options": [
                "GPT-4 (standard)",
                "Claude",
                "Gemini",
                "None of them"
            ],
            "correctAnswer": 2
        }
    ]'::jsonb as quizzes,
    2 as order_index
FROM courses c
CROSS JOIN modules m
WHERE c.title ILIKE '%Prompt Engineering%'
AND m.title ILIKE '%Foundations%'
LIMIT 1;

-- ============================================
-- LESSON 3: Your First Prompts
-- ============================================

INSERT INTO lessons (
    course_id,
    module_id,
    title,
    description,
    summary,
    key_takeaways,
    case_studies,
    playground,
    extra_resources,
    quizzes,
    order_index
)
SELECT 
    c.id as course_id,
    m.id as module_id,
    'Your First Prompts' as title,
    '<h2><b>Introduction: From Blank Page to Brilliant Results</b></h2>

<p>You''re staring at a blank text box. The cursor blinks. You know AI can help, but... what do you type? "Help me" feels too vague. "Write a thing" sounds silly. You type something, hit enter, and get a mediocre response. You try again. Still mediocre. Frustration sets in.</p>

<p>Sound familiar? You''re not alone. 90% of beginners struggle with their first prompts because they don''t know the basic structure. This lesson fixes that.</p>

<h3><b>The 3-Part Prompt Structure</b></h3>

<p>Every effective prompt has three parts:</p>

<ol>
<li><b>Instruction:</b> What do you want the AI to do?</li>
<li><b>Context:</b> What information does the AI need to do it well?</li>
<li><b>Format:</b> How should the output be structured?</li>
</ol>

<p><b>Example:</b></p>

<p><b>Bad Prompt:</b> "Tell me about dogs."</p>

<p><b>Good Prompt (3-Part Structure):</b></p>
<ul>
<li><b>Instruction:</b> "Explain the top 3 benefits of owning a dog"</li>
<li><b>Context:</b> "for someone who has never had a pet before"</li>
<li><b>Format:</b> "in 3 short paragraphs (50 words each)"</li>
</ul>

<p>The difference? The good prompt is specific, provides context, and defines the output format. The AI knows exactly what to deliver.</p>

<h3><b>Common Beginner Mistakes (And How to Fix Them)</b></h3>

<h4><b>Mistake 1: Too Vague</b></h4>
<p><b>Bad:</b> "Write something about climate change."</p>
<p><b>Why it fails:</b> "Something" could be anything. A poem? A scientific paper? A tweet?</p>
<p><b>Fix:</b> "Write a 200-word explanation of climate change for high school students."</p>

<h4><b>Mistake 2: No Context</b></h4>
<p><b>Bad:</b> "Create a marketing email."</p>
<p><b>Why it fails:</b> Marketing for what? To whom? What''s the goal?</p>
<p><b>Fix:</b> "Create a marketing email for our new eco-friendly water bottle. Target: environmentally conscious millennials. Goal: Drive traffic to our website. Tone: Friendly and inspiring."</p>

<h4><b>Mistake 3: Wrong Tone</b></h4>
<p><b>Bad:</b> "Explain quantum physics."</p>
<p><b>Why it fails:</b> The AI defaults to academic/technical language. If you''re not a physicist, you won''t understand.</p>
<p><b>Fix:</b> "Explain quantum physics to a 10-year-old using simple language and everyday analogies."</p>

<h4><b>Mistake 4: No Format Specification</b></h4>
<p><b>Bad:</b> "Give me ideas for blog posts."</p>
<p><b>Why it fails:</b> You might get a paragraph of text instead of a list.</p>
<p><b>Fix:</b> "Give me 10 blog post ideas about remote work. Format: Numbered list with catchy titles."</p>

<h4><b>Mistake 5: Asking Multiple Things at Once</b></h4>
<p><b>Bad:</b> "Write a blog post, create social media captions, and design an email campaign about our new product."</p>
<p><b>Why it fails:</b> The AI gets confused and does all three poorly.</p>
<p><b>Fix:</b> Break into 3 separate prompts, one for each task.</p>

<h3><b>10 Starter Templates for Everyday Tasks</b></h3>

<h4><b>1. Summarization</b></h4>
<p>"Summarize [document/article/video] in [number] bullet points, focusing on [key aspect]."</p>

<h4><b>2. Explanation</b></h4>
<p>"Explain [concept] to a [audience level] using [analogy/simple language/technical terms]."</p>

<h4><b>3. Writing</b></h4>
<p>"Write a [type] about [topic] for [audience]. Tone: [formal/casual/funny]. Length: [word count]."</p>

<h4><b>4. Brainstorming</b></h4>
<p>"Generate [number] ideas for [goal]. Format: [list/table/paragraphs]."</p>

<h4><b>5. Analysis</b></h4>
<p>"Analyze [data/text/situation] and identify [patterns/insights/problems]. Present findings as [format]."</p>

<h4><b>6. Translation</b></h4>
<p>"Translate [text] from [language] to [language]. Maintain [formal/casual] tone."</p>

<h4><b>7. Code Generation</b></h4>
<p>"Write a [language] function that [does X]. Include comments explaining the logic."</p>

<h4><b>8. Email Writing</b></h4>
<p>"Write a [professional/friendly] email to [recipient] about [topic]. Goal: [action you want them to take]."</p>

<h4><b>9. Q&A</b></h4>
<p>"Answer this question: [question]. Provide [brief/detailed] response with [examples/sources]."</p>

<h4><b>10. Creative Writing</b></h4>
<p>"Write a [genre] story about [premise]. Length: [word count]. Include [specific elements]."</p>

<h3><b>Practice Exercise: Transform Bad Prompts</b></h3>

<p>Try transforming these bad prompts using the 3-part structure:</p>

<ol>
<li><b>Bad:</b> "Help me with my resume."<br><b>Your turn:</b> Add instruction, context, format.</li>
<li><b>Bad:</b> "Explain AI."<br><b>Your turn:</b> Specify audience, depth, format.</li>
<li><b>Bad:</b> "Write code."<br><b>Your turn:</b> Define language, function, requirements.</li>
</ol>

<h3><b>The Iteration Mindset</b></h3>

<p>Your first prompt won''t be perfect. That''s okay! Prompt engineering is iterative:</p>

<ol>
<li><b>Write v1:</b> Your first attempt</li>
<li><b>Evaluate:</b> Is the output what you wanted?</li>
<li><b>Refine:</b> Add more context, clarify instructions, adjust format</li>
<li><b>Write v2:</b> Improved prompt</li>
<li><b>Repeat:</b> Until you get the desired result</li>
</ol>

<p>Professional Prompt Engineers iterate 3-5 times on average. Don''t expect perfection on attempt #1.</p>

<h3><b>Conclusion: You''re Ready to Prompt</b></h3>

<p>You now know the 3-part structure (Instruction + Context + Format), common mistakes, and 10 starter templates. The next lesson dives deeper into prompt anatomy. For now, practice with these templates and build your confidence.</p>' as description,
    
    'Every effective prompt has 3 parts: Instruction (what to do), Context (information needed), Format (output structure). Common mistakes: too vague, no context, wrong tone, no format, asking multiple things. Use the 10 starter templates for everyday tasks. Prompt engineering is iterative—refine based on results. Professional engineers iterate 3-5 times on average.' as summary,
    
    '[
        "3-Part Structure: Instruction (what) + Context (info needed) + Format (output structure).",
        "Common Mistakes: Too vague, no context, wrong tone, no format, multiple requests at once.",
        "Fix: Be specific, provide context, define format, specify tone, break complex tasks into steps.",
        "10 Starter Templates: Summarization, Explanation, Writing, Brainstorming, Analysis, Translation, Code, Email, Q&A, Creative.",
        "Iteration Mindset: First prompt won''t be perfect. Refine 3-5 times based on results."
    ]'::jsonb as key_takeaways,
    
    '[
        {
            "title": "The Job Application That Got 10 Interviews",
            "scenario": "Mike was applying for jobs but getting zero responses. His resume was good, but his cover letters were generic. He tried using AI: \"Write a cover letter.\" The result was bland and impersonal. Still no interviews.",
            "analysis": "The prompt was too vague. No context about the job, company, or Mike''s unique value. The AI generated a template that could apply to anyone.",
            "outcome": "Mike used the 3-part structure: \"Write a cover letter for a Senior Marketing Manager role at [Company]. Context: I have 8 years of experience in B2B SaaS, led a team that increased revenue 40%, and I''m passionate about [Company''s mission]. Tone: Professional but enthusiastic. Format: 3 paragraphs, under 300 words.\" Result: Personalized, compelling cover letters. 10 interview requests in 2 weeks."
        },
        {
            "title": "The Student Who Aced the Essay",
            "scenario": "Emma had to write a 1500-word essay on the French Revolution. She asked AI: \"Write an essay about the French Revolution.\" The AI gave her a generic, Wikipedia-style summary. Her teacher would spot it immediately.",
            "analysis": "No context about the assignment requirements, thesis, or academic level. The AI defaulted to a broad overview.",
            "outcome": "Emma refined: \"Write a 1500-word college-level essay arguing that economic inequality was the PRIMARY cause of the French Revolution. Include 3 specific examples (bread riots, tax burden, Estates-General). Cite historical sources. Tone: Academic but accessible. Format: Introduction, 3 body paragraphs (500 words each), conclusion.\" Result: A+ essay with original analysis and proper structure."
        }
    ]'::jsonb as case_studies,
    
    '{
        "objective": "Practice the 3-part prompt structure by transforming vague prompts into effective ones.",
        "starter_prompt": "Transform these bad prompts:\n\n1. \"Help me with my resume.\"\n2. \"Explain AI.\"\n3. \"Write code.\"\n\nFor each, add: Instruction (specific task), Context (relevant info), Format (output structure).",
        "guided_steps": [
            "Step 1: Take Bad Prompt #1. Identify what''s missing (context? format? specificity?).",
            "Step 2: Rewrite with Instruction: ''Rewrite my resume summary to highlight [your skills]''",
            "Step 3: Add Context: ''I''m applying for [job title]. I have [X years] experience in [field].''",
            "Step 4: Add Format: ''Keep it under 100 words. Use bullet points for key achievements.''",
            "Step 5: Test your new prompt in an AI tool. Is the output better?",
            "Step 6: Repeat for Bad Prompts #2 and #3."
        ],
        "advanced_challenge": "Create your own starter template for a task you do regularly (writing emails, analyzing data, creating presentations). Test it 3 times with different inputs. Does it work consistently?"
    }'::jsonb as playground,
    
    '[
        {"title": "Prompt Engineering Cheat Sheet", "url": "https://www.promptingguide.ai/introduction/basics", "type": "guide"},
        {"title": "100 Prompt Templates", "url": "https://github.com/f/awesome-chatgpt-prompts", "type": "github"},
        {"title": "Learn Prompting: Basics", "url": "https://learnprompting.org/docs/basics/intro", "type": "course"},
        {"title": "OpenAI Prompt Examples", "url": "https://platform.openai.com/examples", "type": "examples"}
    ]'::jsonb as extra_resources,
    
    '[
        {
            "question": "What are the 3 parts of an effective prompt?",
            "options": [
                "Subject, Verb, Object",
                "Instruction, Context, Format",
                "Question, Answer, Explanation",
                "Title, Body, Conclusion"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Which is an example of a vague prompt?",
            "options": [
                "Summarize this article in 5 bullet points",
                "Write something about technology",
                "Explain quantum physics to a 10-year-old using simple language",
                "Create a marketing email for eco-conscious millennials"
            ],
            "correctAnswer": 1
        },
        {
            "question": "How many times do professional Prompt Engineers typically iterate on a prompt?",
            "options": [
                "1 time (first try is perfect)",
                "3-5 times on average",
                "10+ times always",
                "Never, they use templates only"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What''s wrong with this prompt: ''Write a blog post, create social media captions, and design an email campaign''?",
            "options": [
                "It''s too short",
                "It asks for multiple things at once, confusing the AI",
                "It''s too specific",
                "Nothing, it''s perfect"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Which starter template would you use to get ideas for a project?",
            "options": [
                "Summarization",
                "Brainstorming",
                "Translation",
                "Q&A"
            ],
            "correctAnswer": 1
        }
    ]'::jsonb as quizzes,
    3 as order_index
FROM courses c
CROSS JOIN modules m
WHERE c.title ILIKE '%Prompt Engineering%'
AND m.title ILIKE '%Foundations%'
LIMIT 1;

-- ============================================
-- LESSON 4: Prompt Anatomy Deep Dive
-- ============================================

INSERT INTO lessons (
    course_id,
    module_id,
    title,
    description,
    summary,
    key_takeaways,
    case_studies,
    playground,
    extra_resources,
    quizzes,
    order_index
)
SELECT 
    c.id as course_id,
    m.id as module_id,
    'Prompt Anatomy Deep Dive' as title,
    '<h2><b>Introduction: Mastering the Building Blocks</b></h2>

<p>You''ve learned the 3-part structure (Instruction + Context + Format). Now it''s time to level up. Professional Prompt Engineers use a 5-element framework that gives them surgical precision over AI outputs.</p>

<p>Think of it like cooking. Beginners follow recipes (3-part structure). Professionals understand ingredients, techniques, and flavor profiles (5-element framework). This lesson makes you a professional.</p>

<h3><b>The 5-Element Framework</b></h3>

<ol>
<li><b>Role:</b> Who should the AI act as?</li>
<li><b>Task:</b> What should the AI do?</li>
<li><b>Context:</b> What information does the AI need?</li>
<li><b>Format:</b> How should the output be structured?</li>
<li><b>Constraints:</b> What limitations or requirements must be followed?</li>
</ol>

<h3><b>Element 1: Role (Who)</b></h3>

<p><b>Definition:</b> The persona or expertise level the AI should adopt.</p>

<p><b>Why it matters:</b> "Act as X" fundamentally changes the AI''s vocabulary, tone, depth, and approach.</p>

<p><b>Examples:</b></p>
<ul>
<li>"Act as a senior copywriter with 10 years of experience in B2B SaaS marketing."</li>
<li>"Act as a patient, encouraging elementary school teacher."</li>
<li>"Act as a skeptical journalist fact-checking claims."</li>
<li>"Act as a Python expert who explains code to beginners."</li>
</ul>

<p><b>Pro Tip:</b> The more specific the role, the better the output. "Act as a copywriter" is okay. "Act as a direct-response copywriter specializing in email campaigns for e-commerce brands" is exceptional.</p>

<h3><b>Element 2: Task (What)</b></h3>

<p><b>Definition:</b> The specific action you want the AI to perform.</p>

<p><b>Why it matters:</b> Vague tasks get vague results. Specific tasks get specific results.</p>

<p><b>Bad:</b> "Help me with this."<br>
<b>Good:</b> "Rewrite this paragraph to be more concise while maintaining the key message."</p>

<p><b>Action Verbs for Tasks:</b></p>
<ul>
<li><b>Analysis:</b> Analyze, evaluate, compare, identify, assess</li>
<li><b>Creation:</b> Write, generate, create, design, compose</li>
<li><b>Transformation:</b> Rewrite, summarize, translate, simplify, expand</li>
<li><b>Explanation:</b> Explain, clarify, teach, demonstrate, illustrate</li>
</ul>

<h3><b>Element 3: Context (Background)</b></h3>

<p><b>Definition:</b> The information the AI needs to complete the task well.</p>

<p><b>Types of Context:</b></p>
<ul>
<li><b>Audience:</b> Who is this for? (Experts? Beginners? Executives?)</li>
<li><b>Goal:</b> What should this achieve? (Inform? Persuade? Entertain?)</li>
<li><b>Background:</b> What''s the situation? (Launching a product? Solving a problem?)</li>
<li><b>Constraints:</b> What are the limits? (Budget? Time? Resources?)</li>
</ul>

<p><b>Example:</b> "Context: We''re launching a new eco-friendly water bottle. Target audience: environmentally conscious millennials (25-35). Goal: Drive pre-orders. Budget: $5,000 for ads. Timeline: 2 weeks."</p>

<h3><b>Element 4: Format (Structure)</b></h3>

<p><b>Definition:</b> How the output should be organized.</p>

<p><b>Common Formats:</b></p>
<ul>
<li><b>Lists:</b> Numbered, bulleted, checklist</li>
<li><b>Paragraphs:</b> Short (50 words), medium (150 words), long (500 words)</li>
<li><b>Tables:</b> Comparison tables, data tables</li>
<li><b>Outlines:</b> Hierarchical structure (I, A, 1, a)</li>
<li><b>Code:</b> Functions, classes, scripts with comments</li>
<li><b>Email:</b> Subject line + body + CTA</li>
<li><b>Essay:</b> Introduction + body + conclusion</li>
</ul>

<p><b>Pro Tip:</b> Always specify length. "Write a blog post" could be 200 words or 2,000 words. "Write a 500-word blog post" is precise.</p>

<h3><b>Element 5: Constraints (Limitations)</b></h3>

<p><b>Definition:</b> Rules, requirements, or limitations the AI must follow.</p>

<p><b>Types of Constraints:</b></p>
<ul>
<li><b>Length:</b> "Under 200 words" or "Exactly 500 words"</li>
<li><b>Tone:</b> "Professional but friendly" or "Formal and academic"</li>
<li><b>Style:</b> "In the style of Hemingway" or "Like a TED Talk"</li>
<li><b>Exclusions:</b> "Don''t mention competitors" or "Avoid technical jargon"</li>
<li><b>Inclusions:</b> "Must include 3 statistics" or "Include a call-to-action"</li>
</ul>

<h3><b>Putting It All Together: The Master Template</b></h3>

<p><b>Template:</b></p>
<pre>
[ROLE] Act as [specific role/expertise].

[TASK] [Action verb] [specific task].

[CONTEXT] 
- Audience: [who is this for?]
- Goal: [what should this achieve?]
- Background: [relevant situation/info]

[FORMAT] Present as [structure]. Length: [word count/number of items].

[CONSTRAINTS]
- Tone: [formal/casual/etc.]
- Must include: [required elements]
- Avoid: [exclusions]
</pre>

<p><b>Real Example:</b></p>
<pre>
[ROLE] Act as a senior email marketing specialist.

[TASK] Write a promotional email for our new productivity app.

[CONTEXT]
- Audience: Busy professionals (30-45) who struggle with time management
- Goal: Get 500 free trial signups
- Background: App uses AI to auto-schedule tasks based on priorities

[FORMAT] Email with subject line, 3 short paragraphs, and clear CTA button. Total: 150 words.

[CONSTRAINTS]
- Tone: Professional but warm
- Must include: One specific benefit, social proof (mention 10,000 users)
- Avoid: Technical jargon, pushy sales language
</pre>

<h3><b>When to Use Each Element (And When to Skip)</b></h3>

<p><b>Always Use:</b> Task, Format<br>
<b>Usually Use:</b> Context, Constraints<br>
<b>Sometimes Use:</b> Role (when expertise matters)</p>

<p><b>Simple Task (2 elements):</b> "Summarize this article in 5 bullet points."<br>
<b>Complex Task (5 elements):</b> Full master template above.</p>

<h3><b>Advanced: Tone, Style, and Audience</b></h3>

<h4><b>Tone Examples:</b></h4>
<ul>
<li>Professional, Casual, Friendly, Formal, Humorous, Serious, Inspirational, Cautionary</li>
</ul>

<h4><b>Style Examples:</b></h4>
<ul>
<li>"In the style of Malcolm Gladwell" (storytelling with data)</li>
<li>"Like a TED Talk" (inspiring, accessible)</li>
<li>"As a scientific paper" (formal, cited)</li>
<li>"Like Hemingway" (short sentences, simple words)</li>
</ul>

<h4><b>Audience Specification:</b></h4>
<ul>
<li>Age: "For teenagers" vs "For retirees"</li>
<li>Expertise: "For beginners" vs "For experts"</li>
<li>Role: "For CEOs" vs "For software engineers"</li>
</ul>

<h3><b>Conclusion: Precision is Power</b></h3>

<p>The 5-element framework gives you surgical control over AI outputs. Role sets expertise. Task defines action. Context provides information. Format structures output. Constraints set boundaries. Master these, and you''ll get exceptional results every time.</p>' as description,
    
    'The 5-Element Framework: Role (who AI acts as), Task (what to do), Context (background info), Format (output structure), Constraints (limitations). Always use Task + Format. Usually use Context + Constraints. Sometimes use Role (when expertise matters). Specify tone, style, audience for precision. Simple tasks need 2 elements; complex tasks need all 5. Precision is power.' as summary,
    
    '[
        "5-Element Framework: Role, Task, Context, Format, Constraints.",
        "Role: Who should AI act as? (e.g., \"Act as a senior copywriter\"). Changes tone, depth, vocabulary.",
        "Task: Specific action (Analyze, Write, Rewrite, Explain). Use precise action verbs.",
        "Context: Audience, Goal, Background. Provides necessary information for quality output.",
        "Constraints: Length, Tone, Style, Inclusions, Exclusions. Sets boundaries and requirements."
    ]'::jsonb as key_takeaways,
    
    '[
        {
            "title": "The $50,000 Proposal That Won the Contract",
            "scenario": "A consulting firm was bidding on a $500,000 contract. They used AI to draft the proposal: \"Write a business proposal.\" The result was generic, impersonal, and missed key client requirements. They didn''t win.",
            "analysis": "No role, no context about the client, no constraints. The AI produced a template that could apply to any business.",
            "outcome": "They used the 5-element framework: [ROLE] Act as a senior business consultant with 15 years in healthcare IT. [TASK] Write a proposal for implementing an AI-powered patient management system. [CONTEXT] Client: Regional hospital network (5 locations, 2,000 beds). Pain point: 30% of admin time wasted on scheduling. Goal: Reduce admin time by 50%, improve patient satisfaction. [FORMAT] Executive summary (1 page), problem statement (2 pages), solution (3 pages), timeline, pricing. [CONSTRAINTS] Tone: Professional, data-driven. Must include: 3 case studies from similar hospitals, ROI projection, risk mitigation plan. Result: They won the $500,000 contract."
        },
        {
            "title": "The Viral LinkedIn Post (1M Views)",
            "scenario": "Sarah wanted to grow her LinkedIn following. She asked AI: \"Write a LinkedIn post.\" It was boring. 20 views, 0 engagement.",
            "analysis": "No role, no context about her expertise or audience, no constraints on tone or style.",
            "outcome": "She refined: [ROLE] Act as a LinkedIn thought leader in AI and productivity. [TASK] Write a post about how AI saved me 10 hours this week. [CONTEXT] Audience: Busy professionals interested in AI tools. Goal: Inspire them to try AI. My background: Marketing director, skeptical of AI until recently. [FORMAT] Hook (1 sentence), story (3 short paragraphs), lesson (1 paragraph), CTA. Total: 150 words. [CONSTRAINTS] Tone: Authentic, conversational, not salesy. Must include: Specific tool names, exact time saved, one surprising insight. Result: 1 million views, 5,000 new followers, 200 DMs asking for advice."
        }
    ]'::jsonb as case_studies,
    
    '{
        "objective": "Practice the 5-element framework by building a master prompt for a real task.",
        "starter_prompt": "Choose a task you need to do this week (write an email, create a presentation, analyze data, etc.). Build a prompt using all 5 elements:\n\n[ROLE]\n[TASK]\n[CONTEXT]\n[FORMAT]\n[CONSTRAINTS]",
        "guided_steps": [
            "Step 1: Define ROLE - What expertise does the AI need? (e.g., ''Act as a data analyst'')",
            "Step 2: Define TASK - What specific action? (e.g., ''Analyze this sales data and identify trends'')",
            "Step 3: Define CONTEXT - Who is this for? What''s the goal? (e.g., ''For the CEO. Goal: Decide Q2 strategy'')",
            "Step 4: Define FORMAT - How should it be structured? (e.g., ''Executive summary + 3 key insights + recommendations'')",
            "Step 5: Define CONSTRAINTS - Tone? Length? Must include/avoid? (e.g., ''Professional tone. Under 500 words. Must include data visualizations.'')",
            "Step 6: Test your prompt. Is the output what you needed? If not, refine and try again."
        ],
        "advanced_challenge": "Create 3 versions of the same prompt with different ROLES (e.g., ''Act as a skeptical analyst'' vs ''Act as an optimistic strategist''). How does changing the role change the output?"
    }'::jsonb as playground,
    
    '[
        {"title": "Prompt Engineering Framework Guide", "url": "https://www.promptingguide.ai/techniques", "type": "guide"},
        {"title": "Role Prompting Research", "url": "https://arxiv.org/abs/2305.14688", "type": "paper"},
        {"title": "Advanced Prompt Techniques", "url": "https://learnprompting.org/docs/basics/roles", "type": "course"},
        {"title": "Prompt Template Library", "url": "https://github.com/dair-ai/Prompt-Engineering-Guide", "type": "github"}
    ]'::jsonb as extra_resources,
    
    '[
        {
            "question": "What are the 5 elements of the advanced prompt framework?",
            "options": [
                "Subject, Verb, Object, Adjective, Adverb",
                "Role, Task, Context, Format, Constraints",
                "Introduction, Body, Conclusion, Summary, References",
                "Question, Answer, Explanation, Example, Practice"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What does the ROLE element do?",
            "options": [
                "Nothing, it''s optional decoration",
                "Sets the expertise level and changes the AI''s vocabulary, tone, and approach",
                "Defines the output format",
                "Specifies the word count"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Which elements should you ALWAYS use in a prompt?",
            "options": [
                "All 5 elements every time",
                "Task and Format",
                "Only Role",
                "Only Constraints"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What type of constraint is ''Under 200 words''?",
            "options": [
                "Tone constraint",
                "Length constraint",
                "Style constraint",
                "Exclusion constraint"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Why is specifying FORMAT important?",
            "options": [
                "It''s not important, AI will figure it out",
                "It structures the output so you get exactly what you need (list, paragraphs, table, etc.)",
                "It makes the prompt longer",
                "It impresses the AI"
            ],
            "correctAnswer": 1
        }
    ]'::jsonb as quizzes,
    4 as order_index
FROM courses c
CROSS JOIN modules m
WHERE c.title ILIKE '%Prompt Engineering%'
AND m.title ILIKE '%Foundations%'
LIMIT 1;
