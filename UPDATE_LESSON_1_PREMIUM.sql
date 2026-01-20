
-- UPDATE Vibe Coding Lesson 1 (What is Vibe Coding?) to Premium Standards

UPDATE public.lessons
SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Understand the Shift:</b> Move from manual syntax writing to AI orchestration.</li>
    <li><b>Master the "Conductor" Mindset:</b> Learn how to lead the AI rather than correcting its spelling.</li>
    <li><b>Define Vibe Coding:</b> Grasp the official definition coined by Andrej Karpathy.</li>
</ul>

<h3>📘 What is Vibe Coding?</h3>
<p>Vibe Coding is not just "using AI to write code." It is a fundamental paradigm shift in software development where the human developer''s role evolves from a bricklayer to an architect. Instead of typing every character of syntax, you focus on the <b>intent</b>, <b>design</b>, and <b>"vibe"</b> of the application, while AI agents handle the implementation details.</p>
<blockquote>"I fully give in to the vibes, embrace exponentials, and forget that the code even exists." - Andrej Karpathy</blockquote>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Intent Over Syntax</h4>
    <p>In traditional coding, 90% of your brain power is spent on syntax (semi-colons, brackets, memory management). In Vibe Coding, you shift that energy to <b>Intent</b>: describing <i>what</i> you want the software to do. If you can describe it precisely, the AI can build it.</p>
</div>

<div class="concept-block">
    <h4>2. The Conductor Mindset</h4>
    <p>Think of an orchestra. The conductor doesn''t play the violin; they direct the musicians. Similarly, you don''t write the loops; you direct the LLMs. Your job is to ensure the output matches your vision, intervening only when the "music" sounds off.</p>
</div>

<div class="concept-block">
    <h4>3. Value Migration</h4>
    <p>The value of a developer is no longer in their ability to remember standard library functions. It has migrated to <b>Problem Definition</b> and <b>System Design</b>. The bottleneck is now your ability to articulate a problem, not your ability to solve it with code.</p>
</div>

<h3>📉 Case Study: The 48-Hour SaaS</h3>
<p><b>The Challenge:</b> Marcus, a marketing professional with zero coding experience, identified a need for a niche customer feedback tool but couldn''t afford a dev team.</p>
<p><b>The Vibe Coding Approach:</b> Instead of learning React from scratch, Marcus used Cursor and Claude 3.5. He focused entirely on the user journey ("The user clicks here, and sees this...") rather than the code structure.</p>
<p><b>The Outcome:</b> Marcus launched a fully functional SaaS MVP in 48 hours. He wrote less than 50 lines of code manually, yet orchestrated over 5,000 lines of production-ready code.</p>

<h3>📝 Summary</h3>
<p>Vibe Coding represents the future of software creation. It is the transition from writing instructions for a machine to collaborating with an intelligent agent. By mastering this mindset, you unlock the ability to build software at the speed of thought, limited only by your imagination and not your typing speed.</p>
'
WHERE title = 'What Is Vibe Coding (Deep)' OR title = 'What Is Vibe Coding?';
