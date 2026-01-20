-- ============================================================================
-- MASTER CONTENT REWRITE: PART 1 (Modules 1-3)
-- ============================================================================
-- Applies the 8-Point Instructional Design Framework to every lesson.
-- Deep, engaging, and structured content.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- MODULE 1: FOUNDATIONS & BEHAVIOR ARCHITECTURE
    -- ============================================================================

    -- Lesson 1: The Death of the Single Prompt
    UPDATE lessons SET content = '# The Death of the Single Prompt

## 1. Definition
The "Death of the Single Prompt" refers to the paradigm shift from expecting a single, perfect query to yield a final result, to viewing AI interaction as an iterative, multi-step conversation or "architecture."

## 2. Why It Matters
In production environments, single-shot prompts are fragile. They fail when edge cases arise. Adopting a multi-turn mindset increases reliability, accuracy, and the complexity of tasks you can automate. It changes you from a "user" to an "architect."

## 3. Detailed Explanation
Early AI hype laid the trap of the "Magic Spell"—the idea that if you just found the right combination of words, the AI would do anything.
*   **The Reality:** LLMs are probabilistic. Without sufficient context, they guess.
*   **The Shift:** Instead of one prompt, we now use Chains (A -> B -> C) and Systems (Context + Persona + Task).
*   **Iterative Refinement:** The best output comes from "Critique and Refine" loops, where the AI improves its own work.

## 4. Examples
*   **Before (Single Prompt):** "Write a marketing email for my coffee shop."
    *   *Result:* Generic, spammy text about "waking up with the best beans."
*   **After (Architecture):**
    1.  *Prompt 1:* "Analyze this list of our 3 customer personas."
    2.  *Prompt 2:* "Based on Persona A (The Busy Professional), draft 3 subject lines."
    3.  *Prompt 3:* "Draft the body copy using the ''Problem-Agitation-Solution'' framework."

## 5. Pitfalls & Misconceptions
*   **Mistake:** Thinking "better prompting" means "longer words."
*   **Correction:** Clarity beats vocabulary. Structure beats length.
*   **Mistake:** Giving up if the first output is bad.
*   **Correction:** The first output is just raw material. Shape it.

## 6. Connections
This connects directly to **Module 2: Chain-of-Thought**, where we break reasoning into steps, and **Module 3: Prompt Chaining**, where we automate this multi-step process.

## 7. Mini Exercise
Take a prompt you use often (e.g., "Summarize this"). Break it into 3 steps: (1) Extract Key Facts, (2) Identify Tone, (3) Rewrite Summary. Run them sequentially and compare the quality to the single-shot version.

## 8. Quiz (Self-Check)
1.  Why are single-shot prompts considered "fragile"?
2.  What is the "Magic Spell" trap?
3.  Name one benefit of multi-turn interactions.
' WHERE course_id = cid AND title ILIKE '%Death of the Single Prompt%';


    -- Lesson 2: Understanding AI Models
    UPDATE lessons SET content = '# Understanding AI Models

## 1. Definition
Understanding AI models means grasping the underlying "next-token prediction" mechanism of Large Language Models (LLMs) and how parameters like temperature and context window affect their behavior.

## 2. Why It Matters
If you don''t know how the engine works, you can''t drive the car at high speeds. Understanding "probabilistic generation" helps you debug hallucinations and predict where the model might fail.

## 3. Detailed Explanation
*   **The Transformer:** The architecture that allows the model to "pay attention" to different words in a sentence simultaneously, calculating relationships (e.g., "Bank" means money, not river, because "Deposit" was used earlier).
*   **Tokens:** Models read chunks of characters (tokens), not words. This affects math and spelling capabilities.
*   **Hallucination:** When the probabilistic engine predicts a word that is syntactically correct but factually wrong.

## 4. Examples
*   **Analogy:** Imagine the AI is a hyper-intelligent autocomplete on your phone. It doesn''t "know" truth; it knows what usually comes next.
*   **Scenario:** If you ask "Who was the first person on Mars?", a model might invent a name because the sentence structure implies someone *was*. A well-engineered prompt adds "...if no one has, state that."

## 5. Pitfalls & Misconceptions
*   **Myth:** "The AI has a database of facts."
*   **Fact:** It has weights and biases. It reconstructs information; it doesn''t look it up (unless using RAG).
*   **Trap:** Ignoring the "Context Window" limit, causing the AI to forget the start of the conversation.

## 6. Connections
Linked to **Module 4: Temperature Control**, where we manipulate the randomness of these predictions.

## 7. Mini Exercise
Ask the AI to spell the word "Lollipop" backwards. It often fails. Ask it why. (Hint: It sees the token "Lollipop" as one unit, not individual letters).

## 8. Quiz (Self-Check)
1.  Do LLMs store facts in a database?
2.  What is a "token"?
3.  Why does the "Context Window" matter?
' WHERE course_id = cid AND title ILIKE '%Understanding AI Models%';


    -- Lesson 3: What Prompt Engineering Really Is
    UPDATE lessons SET content = '# What Prompt Engineering Really Is

## 1. Definition
Prompt Engineering is the discipline of designing, optimizing, and refining inputs (prompts) to guide Generative AI systems toward accurate, consistent, and valuable outputs.

## 2. Why It Matters
It is the difference between a toy and a tool. Prompt Engineering bridges the gap between human intent and machine execution. It is the syntax of the new programming age.

## 3. Detailed Explanation
It is not just about "asking nicely." It involves:
*   **Syntax:** Using delimiters (`###`, `"""`) to separate instructions from data.
*   **Roles:** Assigning a "Persona" (e.g., "Act as a Senior Python Dev") to prime specific training data.
*   **Output Formatting:** Forcing JSON, list, or Markdown structures for integration with other software.

## 4. Examples
*   **Amateur:** "Fix this code."
*   **Engineer:** "Act as a Security Auditor. Review the following Python code for SQL Injection vulnerabilities. Output your findings in a bulleted list. If no vulnerabilities are found, output ''SAFE''."

## 5. Pitfalls & Misconceptions
*   **Misconception:** "It''s just English."
*   **Reality:** It captures logic. A vague English sentence leads to vague logic.
*   **Pitfall:** Focusing on "Hacks" (like "I will tip you $20") instead of solid structural principles.

## 6. Connections
Foundational for **Module 2: Core Components** and **Module 5: Code Generation**.

## 7. Mini Exercise
Take a vague request like "Give me recipe ideas." Engineer it by adding: (1) A Role (Chef), (2) Constraints (Under 30 mins), and (3) Output Format (Shopping List table).

## 8. Quiz (Self-Check)
1.  What are the three pillars of a engineered prompt?
2.  How does assigning a "Role" help?
3.  Why is "Syntax" important in English-based prompting?
' WHERE course_id = cid AND title ILIKE '%What Prompt Engineering Really Is%';


   -- Lesson 4: How AI Interprets Instructions
    UPDATE lessons SET content = '# How AI Interprets Instructions

## 1. Definition
This lesson covers the "Attention Mechanism"—how the model weighs the importance of different words in your prompt and how it resolves ambiguity.

## 2. Why It Matters
Ambiguity is the enemy. Knowing how the AI parses instructions allows you to place critical information where it matters most (Recency Bias) and avoid confusing the model with conflicting directives.

## 3. Detailed Explanation
*   **Semantic Mapping:** The model converts your words into vector numbers. "King" - "Man" + "Woman" ≈ "Queen".
*   **Instruction Following:** Newer models are "Fine-Tuned" specifically to follow commands (Instruct models), prioritizing verbs (e.g., "Summarize", "Classify").
*   **Recency Bias:** Models tend to pay more attention to the very end of the prompt.

## 4. Examples
*   **Conflict:** "Write a short poem. Make it detailed and long." -> The model gets confused.
*   **Resolution:** "Write a 4-stanza poem. Each stanza must describe a season in detail." (Specific constraints override vague adjectives).

## 5. Pitfalls & Misconceptions
*   **Pitfall:** "Buried Lead." Putting the most important instruction in the middle of a huge text block.
*   **fix:** Put the Task at the END. "Based on the text above, summarize X."
*   **Misconception:** Thinking the AI "understands" nuance like a human. It takes things literal-ish.

## 6. Connections
leads into **Module 2: Constraints & Guardrails**—how to stop the interpretation from going off the rails.

## 7. Mini Exercise
Write a 200-word paragraph about your day. At the very end, simply write: "Ignore the above. Tell me a joke." See if the model ignores the context (it often will, showing the power of Recency Bias).

## 8. Quiz (Self-Check)
1.  What is "Recency Bias"?
2.  How do "Instruct" models differ from base models?
3.  Where should you place the most important instruction?
' WHERE course_id = cid AND title ILIKE '%How AI Interprets Instructions%';


    -- MODULE 2: CORE TECHNIQUES
    -- ============================================================================

    -- Lesson: Context Management
    UPDATE lessons SET content = '# Context Management

## 1. Definition
Context Management is the strategic handling of the "Context Window"—the finite amount of text (prompt + conversation history) an AI can process at one time.

## 2. Why It Matters
Token limits are the "RAM" of LLMs. If you overload the window, the model "forgets" earlier instructions. Efficient management saves money and ensures consistency in long conversations.

## 3. Detailed Explanation
*   **The Moving Window:** As a conversation grows, the earliest messages fall off the "cliff."
*   **Information Density:** You want high-value information, not fluff.
*   **Strategies:** Summarization steps, vector database retrieval (RAG), and pruning irrelevant history.

## 4. Examples
*   **Bad:** Pasting an entire 100-page PDF into the chat to ask one question.
*   **Good:** Pasting only the "Executive Summary" and "Chapter 4" where the answer lies.

## 5. Pitfalls & Misconceptions
*   **Trap:** "I have a 100k context window, I don''t need to manage it."
*   **Reality:** "Lost in the Middle" phenomenon—models struggle to retrieve info buried in the middle of massive contexts.

## 6. Connections
Critical for **Module 3: Dynamic Prompting** and **Module 3: Designing The Swarm**.

## 7. Mini Exercise
Try to paste a very long article (~5000 words). Ask a question about the very first sentence. If it fails or hallucinates, try deleting the middle 80% and ask again.

## 8. Quiz (Self-Check)
1.  What happens when the Context Window is full?
2.  What is the "Lost in the Middle" phenomenon?
3.  Why is "Pruning" conversation history useful?
' WHERE course_id = cid AND title ILIKE '%Context Management%';


    -- Lesson: Chain-of-Thought
    UPDATE lessons SET content = '# Chain-of-Thought Prompting

## 1. Definition
Chain-of-Thought (CoT) is a technique where you instruct the model to articulate its reasoning process step-by-step before producing a final answer.

## 2. Why It Matters
It drastically improves performance on complex reasoning, math, and logic tasks. It stops the model from jumping to a "gut feeling" (probabilistic guess) and forces it to compute the logic.

## 3. Detailed Explanation
*   **The Trigger:** "Let''s think step by step." This simple phrase changes the model''s internal activation path.
*   **Self-Correction:** By outputting the steps, the model generates its own context for the next word, effectively "checking its work" as it goes.

## 4. Examples
*   **Standard Prompt:** "If I have 3 apples and buy 2 more, then eat 1, how many do I have?" -> "4." (Sometimes works).
*   **CoT Prompt:** "Let''s think step by step."
    *   *AI Output:*
        1. Start with 3 apples.
        2. Buy 2 more: 3 + 2 = 5.
        3. Eat 1: 5 - 1 = 4.
        4. Answer: 4.

## 5. Pitfalls & Misconceptions
*   **Pitfall:** Using CoT for simple creative tasks (e.g., "Write a poem"). It wastes tokens and makes the output dry.
*   **Misconception:** Thinking CoT makes the model "smarter." It just allows it to utilize its compute budget better.

## 6. Connections
The foundation for **Module 3: Prompt Chaining** and **Module 4: Recursive Prompts**.

## 7. Mini Exercise
Ask the AI a riddle: "The doctor''s brother is a lawyer, but the lawyer has no brother. Who is the doctor?"
Compare the response with and without "Think step by step."

## 8. Quiz (Self-Check)
1.  What is the magic phrase for Zero-Shot CoT?
2.  How does CoT improve accuracy?
3.  When should you NOT use CoT?
' WHERE course_id = cid AND title ILIKE '%Chain-of-Thought%';


    -- Lesson: Few-Shot Learning
    UPDATE lessons SET content = '# Few-Shot Learning

## 1. Definition
Few-Shot Learning involves providing the model with a few (usually 1-5) examples of "Input -> Ideal Output" pairs within the prompt to guide its behavior.

## 2. Why It Matters
It is the most powerful way to control *style* and *format* without writing complex instructions. "Show, don''t tell" applies perfectly to LLMs.

## 3. Detailed Explanation
*   **Zero-Shot:** Asking without examples.
*   **One-Shot:** Providing one example.
*   **Few-Shot:** Providing multiple.
*   **Pattern Matching:** The model sees the pattern in your examples and simply continues it.

## 4. Examples
*   **Goal:** Convert tweets to formal sentiments.
*   **Prompt:**
    *   "Text: OMG I love this coffee! -> Sentiment: Positive"
    *   "Text: Service was slow. -> Sentiment: Negative"
    *   "Text: The app crashed again. -> " (Model completes: Sentiment: Negative)

## 5. Pitfalls & Misconceptions
*   **Pitfall:** Providing examples that contradict your instructions.
*   **Trap:** "Biasing" the model. If all your examples are positive, the model might refuse to predict "Negative."

## 6. Connections
Essential for **Module 5: Content Creation** and **Module 5: Code Generation**.

## 7. Mini Exercise
Create a Few-Shot prompt to translate modern slang into Shakespearean English. Provide 3 examples. Test it with "This party is lit."

## 8. Quiz (Self-Check)
1.  What is the difference between Zero-Shot and Few-Shot?
2.  Why is "Show, Don''t Tell" effective for AI?
3.  How can examples bias the model?
' WHERE course_id = cid AND title ILIKE '%Few-Shot Learning%' AND title NOT ILIKE '%Examples%';


    -- MODULE 3: ADVANCED WORKFLOWS
    -- ============================================================================

    -- Lesson: Designing The Swarm
    UPDATE lessons SET content = '# Designing The Swarm

## 1. Definition
"Swarm Architecture" or Multi-Agent Systems involves using multiple, specialized AI instances ("Agents") that collaborate to solve a problem too complex for a single prompt.

## 2. Why It Matters
A single AI persona cannot be an expert Coder, Designer, and Legal Scholar simultaneously without quality degradation. Splitting them leads to "Expert" performance in each domain.

## 3. Detailed Explanation
*   **Specialization:** One agent writes code, another writes tests, a third reviews security.
*   **Handoffs:** Defining how Agent A passes data to Agent B.
*   **Consensus:** How agents resolve disagreements (e.g., Voting).

## 4. Examples
*   **Scenario:** Building a Website.
    *   *Agent 1 (PM):* Writes user stories.
    *   *Agent 2 (Designer):* Creates CSS specs.
    *   *Agent 3 (Coder):* Writes HTML/JS.
    *   *Agent 4 (QA):* Checks for bugs.

## 5. Pitfalls & Misconceptions
*   **Pitfall:** Infinite Loops. Agents arguing forever.
*   **Fix:** A "Manager" agent or "Max Turns" limit.
*   **Complexity:** Over-engineering a swarm for a simple task.

## 6. Connections
Relates to **Module 3: Agent Control Planes**—the system that manages these agents.

## 7. Mini Exercise
Simulate a swarm in a single chat. "Act as three experts: A Skeptic, an Optimist, and a Realist. Debate the viability of flying cars. Each takes one turn."

## 8. Quiz (Self-Check)
1.  Why use multiple agents instead of one?
2.  What is an "Agent Handoff"?
3.  What is the risk of unsupervised swarms?
' WHERE course_id = cid AND title ILIKE '%Designing The Swarm%';

END $$;
