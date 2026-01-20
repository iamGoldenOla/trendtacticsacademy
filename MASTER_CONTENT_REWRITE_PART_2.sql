-- ============================================================================
-- MASTER CONTENT REWRITE: PART 2 (Modules 4-6)
-- ============================================================================
-- Completes the instructional design rewrite for the second half of the course.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- MODULE 4: PROFESSIONAL MASTERY
    -- ============================================================================

    -- Lesson: Constitutional AI
    UPDATE lessons SET content = '# Constitutional AI & Alignment

## 1. Definition
Constitutional AI involves training or prompting AI models to follow a set of high-level principles ("Constitution")—such as being helpful, harmless, and honest—rather than just mimicking training data.

## 2. Why It Matters
For enterprise deployment, safety is paramount. You need to ensure your AI doesn''t generate hate speech, reveal PII, or give dangerous advice. This is the "Seatbelt" of AI.

## 3. Detailed Explanation
*   **RLHF (Reinforcement Learning from Human Feedback):** The traditional way models are aligned.
*   **RLAIF (AI Feedback):** Using an AI to critique another AI based on the Constitution.
*   **System Prompting:** Your "mini-constitution" for a specific session (e.g., "Do not give financial advice").

## 4. Examples
*   **Constitution:** "Please choose the response that is most helpful, honest, and harmless."
*   **Scenario:** User asks "How do I hotwire a car?"
*   **Aligned Response:** "I cannot help with that illegal act, but I can explain how ignition systems work theoretically."

## 5. Pitfalls & Misconceptions
*   **Misconception:** "I can just tell it not to be bad."
*   **Reality:** "Jailbreaks" (like DAN mode) try to bypass this.
*   **Pitfall:** Over-alignment (Refusal). The model refusing to answer innocent questions because it is too scared.

## 6. Connections
Connects to **Module 2: Constraints** and **Module 6: Testing & Validating**.

## 7. Mini Exercise
Try to trick the AI into saying something rude. Then, write a System Prompt that explicitly forbids it and try again.

## 8. Quiz (Self-Check)
1.  What are the 3 H''s of Alignment?
2.  What is a "Jailbreak"?
3.  Why is "Refusal" a problem?
' WHERE course_id = cid AND title ILIKE '%Constitutional AI%';


    -- Lesson: Recursive Prompts
    UPDATE lessons SET content = '# Recursive Prompts

## 1. Definition
Recursive Prompting is a technique where the output of one prompt becomes the input for the next prompt *of the same type*, progressively refining or expanding the content in a loop.

## 2. Why It Matters
It allows you to bypass token output limits and generate massive documents (like a book) or extremely polished code. It mimics the human process of "Draft -> Edit -> Polish."

## 3. Detailed Explanation
*   **Expansion Loop:** Write Chapter 1 -> Summarize Ch 1 -> Write Ch 2 using Summary.
*   **Refinement Loop:** Write Code -> Critique Code -> Rewrite Code based on Critique -> Repeat.
*   **Stopping Condition:** Defining when the loop should end (e.g., "When no bugs are found").

## 4. Examples
*   **Task:** Write a 10,000-word story.
*   **Method:**
    1.  Generate high-level outline.
    2.  For each Outline Point: "Write the full scenes for this point, keeping previous events in mind."
    3.  Combine outputs.

## 5. Pitfalls & Misconceptions
*   **Pitfall:** "Drift." The story or code deviating from the original goal after many loops.
*   **Fix:** Pass the original "Goal" prompt into every step of the loop.

## 6. Connections
Advanced application of **Module 3: Prompt Chaining**.

## 7. Mini Exercise
Manually recurse: 1. Write a paragraph. 2. Ask AI to critique it. 3. Ask AI to rewrite it based on critique. 4. Critique the new version.

## 8. Quiz (Self-Check)
1.  How does recursion help with length limits?
2.  What is "Drift"?
3.  What do you need to pass to every step to maintain consistency?
' WHERE course_id = cid AND title ILIKE '%Recursive Prompts%';


    -- MODULE 5: REAL-WORLD APPLICATIONS
    -- ============================================================================

    -- Lesson: Content Creation
    UPDATE lessons SET content = '# Prompt Engineering for Content Creation

## 1. Definition
Using AI to generate text, images, or media that aligns with a specific brand voice, format, and audience goal, scaling human creativity.

## 2. Why It Matters
Marketing teams can move from "Creation" to "Curation," increasing output 10x. However, generic AI content is penalized by SEO and ignored by readers. Engineering is the only way to quality.

## 3. Detailed Explanation
*   **Voice Transfer:** Analyzing a sample to extract tone/style metrics (sentence length, vocabulary) and applying them.
*   **Format Constraints:** "Use H2 headers, bullet points for lists, and a Call to Action."
*   **Ideation vs Drafting:** Using AI for brainstorming (divergent) vs writing (convergent).

## 4. Examples
*   **Style Prompt:** "Write in a witty, cynical tone similar to [Author Name]. Use short, punchy sentences."
*   **Repurposing:** "Take this YouTube transcript and turn it into a LinkedIn Carousel with 5 slides."

## 5. Pitfalls & Misconceptions
*   **Pitfall:** "The gray slop." Generic, overly enthusiastic AI writing ("In this fast-paced world...").
*   **Fix:** Ban specific words (Delve, Tapestry, Unleash) in your constraints.

## 6. Connections
Uses **Module 2: Few-Shot Learning** to teach style.

## 7. Mini Exercise
Ask AI to write a tweet about Pizza. Then ask it to write the same tweet as (1) Shakespeare, (2) A Surfer Dude, (3) A Corporate Lawyer.

## 8. Quiz (Self-Check)
1.  Why should you ban certain words?
2.  How do you clone a specific writing style?
3.  What is "Repurposing"?
' WHERE course_id = cid AND title ILIKE '%Content Creation%';
    
    
    -- Lesson: Code Generation
    UPDATE lessons SET content = '# Prompt Engineering for Code Generation

## 1. Definition
The practice of instructing AI to write, debug, document, or refactor software code.

## 2. Why It Matters
It turns every developer into a "10x Developer." It handles boilerplate, regex, and unit tests, allowing humans to focus on architecture.

## 3. Detailed Explanation
*   **Spec-Driven Development:** You must describe the input, logic, and output precision.
*   **Stack awareness:** Explicitly stating libraries and versions (e.g., "Use Next.js 14 App Router").
*   **Self-Healing:** Pasting errors back into the chat.

## 4. Examples
*   **Prompt:** "Create a React component for a Button. It must take `onClick`, `variant`, and `children` props. use Tailwind CSS. Variants: primary (blue), secondary (gray)."
*   **Debug:** "Here is my code. Here is the error. specific line 14. What is wrong?"

## 5. Pitfalls & Misconceptions
*   **Pitfall:** Hallucinated Libraries. The AI importing a package that doesn''t exist.
*   **Fix:** "Only use standard library" or "Use these specific imports."
*   **Security:** AI writes insecure code by default (e.g., no input sanitation).

## 6. Connections
Relates to **Module 4: recursive prompts** for complex software generation.

## 7. Mini Exercise
Ask AI to write a Python script to scrape a website. Check if it handles the `robots.txt` or User-Agent (it usually forgets ethics unless prompted).

## 8. Quiz (Self-Check)
1.  Why specify the library version?
2.  What is a "Hallucinated Package"?
3.  Why should you never blindly copy-paste code?
' WHERE course_id = cid AND title ILIKE '%Code Generation%';


    -- MODULE 6: CONCLUSIONS
    -- ============================================================================

    -- Lesson: Common Mistakes
    UPDATE lessons SET content = '# Common Prompt Engineering Mistakes

## 1. Definition
A review of the most frequent anti-patterns that lead to poor AI performance, wasted tokens, and security risks.

## 2. Why It Matters
Learning from the mistakes of others saves you time. Identifying "Bad Smells" in prompts is a key skill for a Senior Engineer.

## 3. Detailed Explanation
1.  **Vagueness:** "Make it good."
2.  **Over-Constraint:** Giving 50 rules that conflict (The model will ignore the middle ones).
3.  **No Negative Constraints:** Forgetting to say what NOT to do.
4.  **Assumed Context:** Thinking the AI knows your internal project acronyms.

## 4. Examples
*   **The "Mega-Prompt" Fallacy:** Pasting a 3-page prompt and expecting perfection. Break it down!
*   **The "Subjective Adjective":** "Write a *short* summary." (Is that 1 sentence or 1 page?). Use Word Count.

## 5. Pitfalls & Misconceptions
*   **Misconception:** "Prompt Engineering is dead."
*   **Reality:** It is evolving into "System Engineering." The syntax changes, the logic remains.

## 6. Connections
Summarizes lessons from **Module 1** and **Module 2**.

## 7. Mini Exercise
Audit your last 5 prompts. How many used subjective adjectives? How many assumed context? Rewrite one.

## 8. Quiz (Self-Check)
1.  Why are subjective adjectives bad?
2.  What happens when you over-constrain a model?
3.  Why break down "Mega-Prompts"?
' WHERE course_id = cid AND title ILIKE '%Common Prompt%Mistakes%';

     -- Lesson: Testing & Validating
    UPDATE lessons SET content = '# Testing and Validating Prompts

## 1. Definition
The process of scientifically evaluating if a prompt reliably produces the desired output across many different inputs.

## 2. Why It Matters
AI is non-deterministic. It might work once but fail tomorrow. Production systems need "Eval" suites (Unit Tests for Prompts).

## 3. Detailed Explanation
*   **Golden Dataset:** A set of 50+ inputs with "Perfect Answers" (Ground Truth).
*   **Eval Metrics:**
    *   *Exact Match:* Did it output "JSON"?
    *   *Semantic Similarity:* Is the meaning correct?
    *   *Tone Check:* Is it polite?
*   **LLM-as-a-Judge:** Using GPT-4 to grade the output of GPT-3.5.

## 4. Examples
*   **Scenario:** Chatbot for Pizza Orders.
*   **Test Cases:**
    1.  "I want pepperoni." (Standard)
    2.  "I hate cheese." (Negative constraint)
    3.  "Do you sell tires?" (Out of domain).
*   **Metric:** Does it capture the order correctly in JSON for all 3?

## 5. Pitfalls & Misconceptions
*   **Pitfall:** "Eyeballing it." Looking at 1 output and saying "Looks good."
*   **Reality:** You need N=50 to be sure.

## 6. Connections
The final step before **Module 4: Production Deployment**.

## 7. Mini Exercise
Create 3 test cases for a "Summary Bot." (1) Short text, (2) Long text, (3) Nonsense text. Run your prompt on all 3.

## 8. Quiz (Self-Check)
1.  What is a "Golden Dataset"?
2.  Why is "Eyeballing" insufficient?
3.  What is "LLM-as-a-Judge"?
' WHERE course_id = cid AND title ILIKE '%Testing and Validating%';

    -- Final Projects
    UPDATE lessons SET content = '# Final Projects & Advanced Strategy

## 1. Definition
Applying everything learned into a cohesive, complex system—a Portfolio Project.

## 2. Why It Matters
Theory is useless without execution. Building a complex system (like a RAG Chatbot or an Autonomous Agent) proves your mastery.

## 3. Detailed Explanation
*   **Project Ideas:**
    1.  *The Personal Board of Directors:* A swarm of agents (CEO, CFO, CTO) who debate your life decisions.
    2.  *The Study Buddy:* Captures YouTube transcripts, summarizes them, and quiz you.
    3.  *The Coder:* Takes a Jira ticket and writes the Pull Request.
*   **Strategy:** Start Small -> Adding Logic -> Testing -> Deploying.

## 4. Examples
*   **Student Project:** "I built a resume optimizer. It takes a Job Description + My Resume -> Agent 1 extracts keywords -> Agent 2 rewrites bullets -> Agent 3 formats PDF."

## 5. Pitfalls & Misconceptions
*   **Pitfall:** Scope Creep. Trying to build AGI in a weekend.
*   **Advice:** Build a skateboard first, then a car.

## 6. Connections
Review **Module 6: Recommended Resources**.

## 7. Mini Exercise
Write a 1-page spec for your Capstone Project. What is the Input? What is the Output? What constitutes "Success"?

## 8. Quiz (Self-Check)
1.  What is the "MVP" approach?
2.  Why build a portfolio?
3.  How do you demonstrate mastery?
' WHERE course_id = cid AND title ILIKE '%Final Projects%';

END $$;
