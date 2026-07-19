import json
import os

# Create scratch directory if not exists
os.makedirs('C:/Users/Akinola Olujobi/.gemini/antigravity/brain/24a26cdb-ac7d-4c1d-bf20-857400faa4e8/scratch', exist_ok=True)

fb_lessons = [
    # MODULE 1: Foundations & Setup
    {
        "module": "Module 1: Facebook Ads Foundations",
        "title": "The Facebook Ads Auction System",
        "duration": "20:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/006V3t__xkc",
        "isPreview": True,
        "content": """## The Facebook Ads Auction System

### Core Concept
Every time someone scrolls through Facebook or Instagram, an invisible auction happens in milliseconds. Advertisers compete, but it is not just about who pays the most - it is about who delivers the most relevant ad to the right person.

Unlike a traditional auction where the highest monetary bid wins, Meta's auction is designed to balance two goals: creating value for advertisers (helping them reach interested buyers) and providing a positive experience for users (preventing spammy, irrelevant ads).

### The Total Value Formula
The winning ad is chosen based on this calculation:
**Total Value = Bid x Estimated Action Rate + User Value**

- **Bid**: How much you are willing to pay for a result (click, conversion, impression).
- **Estimated Action Rate (EAR)**: Meta's prediction of how likely a user is to take the desired action (click, buy, sign up).
- **User Value (Ad Quality & Relevance)**: A bonus score for ads that improve user experience. Ads with high engagement, positive feedback, and relevance score get boosted. Ads with negative feedback (misleading, low quality, high post-click bounce rate) get penalized."""
    },
    {
        "module": "Module 1: Facebook Ads Foundations",
        "title": "Setting up Business Manager & Pixels",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/CB0H7esOl68",
        "isPreview": False,
        "content": """## Setting up Business Manager & Pixels

### Core Concept
Your ad account is the foundation of your advertising success. If it is not set up correctly, you will face billing issues, tracking errors, and even account restrictions. A clean setup ensures smooth scaling later.

### Step-by-Step Setup
1. **Facebook Profile to Business Manager**: Separates your personal profile from your commercial activities. Business Manager controls security, team permissions, Pages, and ad accounts.
2. **Ad Account**: The financial container where your ad spend is recorded, billed, and tracked.
3. **Pixel**: A JavaScript code snippet installed on your website to track actions (page views, sign-ups, purchases).
4. **Events Manager**: The verification control room for your tracking data, measuring pixel health and Custom Conversions."""
    },
    {
        "module": "Module 1: Facebook Ads Foundations",
        "title": "The iOS 14+ Privacy Era & Conversions API",
        "duration": "30:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/kgBZhJnh-vk",
        "isPreview": False,
        "content": """## The iOS 14+ Privacy Era & Conversions API

### Core Concept
In 2021, Apple released iOS 14.5, allowing users to opt out of tracking. This degraded traditional browser pixels. Meta's solution is the Conversions API (CAPI), which sends event data directly from your server to Meta's servers, bypassing browser blockers.

### Bypassing Tracking Blocks
By implementing Conversions API alongside the browser Pixel, advertisers can stitch event data together using parameters like email, phone number, and IP address. This redundancy ensures Meta receives purchase and lead signals, helping optimize ad delivery.

---

### Module 1 Practical Activity
Set up your own Facebook Pixel Helper Chrome extension. Visit three major e-commerce websites, and list the standard events (such as ViewContent or AddToCart) being triggered on each page.

### Nigerian Business Example
Gbagada Cosmetics, a premium beauty store in Lagos, set up Meta Pixel and Conversions API. When customers browsed their website but left without buying, they retargeted them on Instagram. By resolving tracking data losses from iOS privacy updates, their sales increased by 40% in two months.""",
        "quizQuestions": [
            {
                "question": "What is the primary advantage of combining Meta Conversions API (CAPI) with the standard browser Pixel?",
                "options": [
                    "It bypasses the need for an ad budget",
                    "It sends event data directly from the server, preventing data loss from browser ad-blockers and iOS privacy restrictions",
                    "It automatically increases the relevancy score to 10/10",
                    "It makes ads load 2x faster on mobile devices"
                ],
                "correctIndex": 1,
                "explanation": "Conversions API sends data directly from your server to Meta's servers, ensuring tracking reliability even when browsers block cookies or user tracking."
            },
            {
                "question": "If Advertiser A bids N500 with high ad relevance, and Advertiser B bids N1000 with low ad relevance, who is more likely to win the auction?",
                "options": [
                    "Advertiser B, because bid size is the only metric that matters",
                    "Advertiser A, because Meta rewards high relevance with lower delivery costs and higher priority",
                    "Neither, Meta will show a third advertiser randomly",
                    "Advertiser B, because they pay double"
                ],
                "correctIndex": 1,
                "explanation": "Meta's auction calculates total value as Bid x Estimated Action Rate + User Value (Relevance). High relevance can easily beat a higher bid."
            },
            {
                "question": "Why is Two-Factor Authentication (2FA) critical in Facebook Business Manager?",
                "options": [
                    "To speed up the ad approval process",
                    "To protect the account from hacking and prevent unauthorized ad spend on linked payment methods",
                    "To allow targeting of younger demographics",
                    "To qualify for free ad credits"
                ],
                "correctIndex": 1,
                "explanation": "Enabling 2FA secures the ad account, preventing compromise of linked payment methods and protecting business assets."
            }
        ]
    },

    # MODULE 2: Targeting & Creative Strategy
    {
        "module": "Module 2: Targeting & Creative Strategy",
        "title": "Audience Targeting (Broad vs Interest vs Lookalike)",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/TBhRC4Dath4",
        "isPreview": False,
        "content": """## Audience Targeting (Broad vs Interest vs Lookalike)

### Core Concept
Not all audiences are created equal. Meta divides audiences by temperature: Cold (people who do not know your brand), Warm (engaged visitors), and Hot (cart abandoners).

### Targeting Options
- **Broad Targeting**: Relying entirely on Meta's algorithm by entering only location, age, and gender.
- **Interest Targeting**: Reaching people based on their interests, hobbies, and pages they like.
- **Lookalike Audiences**: Identifying common characteristics of your existing customers (like buyers) and finding similar prospects in a target country."""
    },
    {
        "module": "Module 2: Targeting & Creative Strategy",
        "title": "Ad Creatives That Convert (Hooks, Copy & Design)",
        "duration": "30:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/7M6CSCIMJ3k",
        "isPreview": False,
        "content": """## Ad Creatives That Convert (Hooks, Copy & Design)

### Core Concept
In modern Meta advertising, creative is the new targeting. Since broad targeting is standard, your ad creative does the work of filtering the right people.

### Ad Structure
- **The Hook (First 3 Seconds)**: Stops the scroll and grabs user attention.
- **The Body Copy**: Explains the benefit, addresses objections, and builds desire.
- **The Call-to-Action (CTA)**: Directs the user exactly what to do next (e.g. Shop Now, Learn More)."""
    },
    {
        "module": "Module 2: Targeting & Creative Strategy",
        "title": "The Modern Campaign Structure (CBO vs ABO)",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/ojtbHUqw1LA",
        "isPreview": False,
        "content": """## The Modern Campaign Structure (CBO vs ABO)

### Core Concept
Campaign structure defines how your budget is distributed. CBO (Campaign Budget Optimization) distributes budget at the campaign level dynamically, while ABO (Ad Set Budget Optimization) lets you specify budgets for individual ad sets.

### Testing vs Scaling
Best practices dictate using ABO for testing new creatives with small budgets, and CBO for consolidating proven winning ad sets under a larger scaling budget.

---

### Module 2 Practical Activity
Write 3 different hook variations (Question Hook, Statistic Hook, Story Hook) for a single product (such as a fast-delivery laundry service in Abuja). Keep each hook under 120 characters.

### Nigerian Business Example
YabaTech Hub, a coding school in Lagos, ran a CBO campaign targeting young graduates. They tested a testimonial video, a flyer, and a success screenshot. The algorithm automatically directed 80% of the budget to the successful testimonial video, bringing lead costs down from N2,000 to N750.""",
        "quizQuestions": [
            {
                "question": "What is the main difference between Advantage Campaign Budget (CBO) and Ad Set Budget Optimization (ABO)?",
                "options": [
                    "CBO distributes budget at the campaign level, while ABO allows setting specific budgets for each individual ad set",
                    "ABO is free while CBO requires paid credits",
                    "CBO only works for video ads while ABO is for image ads",
                    "CBO is deprecated in 2025"
                ],
                "correctIndex": 0,
                "explanation": "CBO manages budget across all ad sets dynamically, whereas ABO gives the advertiser absolute control over the budget allocated to each specific ad set."
            },
            {
                "question": "Which audience targeting option lets you find new people who resemble your existing paying customers?",
                "options": [
                    "Interest targeting",
                    "Detailed targeting expansion",
                    "Lookalike Audiences",
                    "Broad age targeting"
                ],
                "correctIndex": 2,
                "explanation": "Lookalike audiences identify common characteristics of people in a seed list (like buyers) and find similar prospects."
            },
            {
                "question": "Why is the 'Hook' (first 3 seconds of a video or first line of copy) considered the most important part of an ad creative?",
                "options": [
                    "It qualifies the advertiser for discounts",
                    "It stops the scroll and captures the user's attention in a crowded feed",
                    "It is required by Meta policy",
                    "It is the only part indexed by search engines"
                ],
                "correctIndex": 1,
                "explanation": "The hook is crucial because users scroll quickly; without stopping the scroll, the rest of your ad content is never consumed."
            }
        ]
    },

    # MODULE 3: Optimization & Scaling
    {
        "module": "Module 3: Optimization & Scaling",
        "title": "Tracking, Metrics & Attribution",
        "duration": "30:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/CB0H7esOl68",
        "isPreview": False,
        "content": """## Tracking, Metrics & Attribution

### Core Concept
To optimize campaigns, you must read metrics correctly. Key metrics include CPM (cost per 1,000 impressions), CTR (click-through rate), CPC (cost per click), CPA (cost per acquisition), and ROAS (return on ad spend).

### Troubleshooting Discrepancies
Attribution describes how Meta connects sales to ads. Note that browser settings and privacy blockers cause discrepancies between Meta's reports and your store's dashboard. Rely on blended ROAS for true scaling metrics."""
    },
    {
        "module": "Module 3: Optimization & Scaling",
        "title": "Budgeting, Testing & Troubleshooting Ads",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/kgBZhJnh-vk",
        "isPreview": False,
        "content": """## Budgeting, Testing & Troubleshooting Ads

### Core Concept
Ad fatigue occurs when an audience has seen your ad too many times, leading to a rise in CPA. To resolve this, maintain a structured testing pipeline where you continuously introduce new hooks and formats.

### Diagnosing High CPA
- If CTR is low: Your creative is not engaging.
- If CTR is high but conversion is low: Your landing page load speed or pricing is the issue.
- If CPM is extremely high: Your targeting is too narrow or relevance is poor."""
    },
    {
        "module": "Module 3: Optimization & Scaling",
        "title": "Advanced Scaling Strategies (Vertical & Horizontal)",
        "duration": "35:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/p8k2j9h6f5d",
        "isPreview": False,
        "content": """## Advanced Scaling Strategies (Vertical & Horizontal)

### Core Concept
Scaling is how you increase ad spend while maintaining profitability.
- **Vertical Scaling**: Increasing budget by 15-20% every 3 days.
- **Horizontal Scaling**: Duplicating winning ad sets to target lookalikes, broad targeting, or other geographical segments.

---

### Module 3 Practical Activity
Analyze a mock dashboard report. Calculate the ROAS (Return on Ad Spend) if Spend = N50,000 and Revenue = N250,000. Decide whether to scale up or kill the ad set based on a target ROAS of 3.0.

### Nigerian Business Example
Chukwudi Fashion, an Ankara luxury label in Enugu, horizontally scaled their winning creative. Duplicating their original ad set, they targeted lookalikes of website buyers in South-West and South-South Nigeria, raising daily sales from 10 packages to 45 packages while keeping CPA stable.""",
        "quizQuestions": [
            {
                "question": "How is Return on Ad Spend (ROAS) calculated?",
                "options": [
                    "ROAS = Total Ad Spend / Total Revenue",
                    "ROAS = Total Revenue / Total Ad Spend",
                    "ROAS = Click-Through Rate * Conversion Rate",
                    "ROAS = Total Leads / Cost Per Lead"
                ],
                "correctIndex": 1,
                "explanation": "ROAS is calculated by dividing the revenue generated from ads by the cost of running those ads."
            },
            {
                "question": "What is a common pitfall of scaling an ad set's budget vertically (e.g., doubling budget from N5,000 to N10,000 instantly)?",
                "options": [
                    "It deletes the campaign permanently",
                    "It resets the learning phase and can cause performance volatility or higher costs",
                    "It decreases the size of the target audience",
                    "It makes the ad run only on desktop devices"
                ],
                "correctIndex": 1,
                "explanation": "Vertical scaling by more than 20% at a time resets the algorithm's learning phase, causing performance fluctuation."
            },
            {
                "question": "If an ad has a high Click-Through Rate (CTR) but a very low Conversion Rate on the landing page, what should you troubleshoot?",
                "options": [
                    "The ad creative and copy",
                    "The target audience location",
                    "The landing page load speed, messaging alignment, and checkout process",
                    "The Facebook Business Manager security settings"
                ],
                "correctIndex": 2,
                "explanation": "High CTR means the ad is engaging, but low conversion means the post-click experience (landing page, offer, or load speed) is failing."
            }
        ]
    }
]

vibe_lessons = [
    # MODULE 1: The Vibe Coding Revolution
    {
        "module": "Module 1: The Vibe Coding Revolution",
        "title": "Introduction to Vibe Coding (What and Why)",
        "duration": "15:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/S9jgR2eR5ys",
        "isPreview": True,
        "content": """## Introduction to Vibe Coding (What and Why)

### Core Concept
Vibe Coding is a new approach to software development where you describe your intent in natural language, and AI tools generate, debug, and refine the codebase. Instead of focusing on syntax, frameworks, or boilerplate code, you focus on product vision.

### Core Principles
- **Intent-Driven Development**: You define the 'what' and let AI figure out the 'how'.
- **Outcome-First Thinking**: Start with the final user experience and work backward.
- **Human-AI Collaboration**: You act as the director and architect, and AI is the execution engine."""
    },
    {
        "module": "Module 1: The Vibe Coding Revolution",
        "title": "Full-Stack AI Builders (Bolt.new & Lovable)",
        "duration": "20:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/CB0H7esOl68",
        "isPreview": False,
        "content": """## Full-Stack AI Builders (Bolt.new & Lovable)

### Core Concept
Full-Stack AI builders generate complete, interactive web applications inside the browser.
- **Bolt.new**: Runs full Node.js environments. It compiles code, installs npm packages, and configures databases.
- **Lovable**: Focuses on high-fidelity user interfaces, Tailwind CSS styling, and clean visual layouts. Both builders allow creators to build SaaS MVPs in hours."""
    },
    {
        "module": "Module 1: The Vibe Coding Revolution",
        "title": "AI-First IDEs (Cursor & Windsurf)",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/kgBZhJnh-vk",
        "isPreview": False,
        "content": """## AI-First IDEs (Cursor & Windsurf)

### Core Concept
AI-First IDEs index your entire workspace, allowing models to understand file dependencies. Unlike standard editors, they support codebase-wide search, inline AI code insertions, and multi-file debugging.

---

### Module 1 Practical Activity
Write a detailed system prompt for a new recipe web application. Specify the design aesthetics, interactive filter components, and state management rules without writing any code.

### Nigerian Business Example
Amina's Buka, a restaurant in Abuja, wanted a digital food ordering system. Amina, having no coding background, used Bolt.new to mock up a responsive food catalog. Using natural language instructions, she added a shopping cart and a Paystack checkout simulation within an afternoon.""",
        "quizQuestions": [
            {
                "question": "What is the core philosophy of 'Vibe Coding'?",
                "options": [
                    "Writing assembly code by hand",
                    "Focusing on product vision, user experience, and logical instructions while letting AI handle syntax and boilerplate",
                    "Coding without internet access",
                    "Using visual page builders that do not generate code"
                ],
                "correctIndex": 1,
                "explanation": "Vibe Coding shifts the developer's role from syntax memorization to strategic guidance, product design, and architectural intent."
            },
            {
                "question": "In which scenario is a Full-Stack AI Builder (like Bolt.new or Lovable) most appropriate?",
                "options": [
                    "Building a high-frequency trading engine",
                    "Rapidly prototyping a web application with standard databases, components, and responsive pages",
                    "Developing a new operating system kernel",
                    "Writing low-level hardware device drivers"
                ],
                "correctIndex": 1,
                "explanation": "Full-Stack AI builders excel at rapid scaffolding, UI creation, and building standard web application workflows."
            },
            {
                "question": "What makes AI-First IDEs (like Cursor or Windsurf) different from standard code editors?",
                "options": [
                    "They are paid-only and have no coding tools",
                    "They integrate deep codebase-wide index search, context referencing, and inline AI edits into the editor",
                    "They do not support JavaScript or Python",
                    "They replace the monitor screen completely"
                ],
                "correctIndex": 1,
                "explanation": "AI-First IDEs index the entire workspace, allowing the LLM to understand project relationships, imports, and make edits across multiple files."
            }
        ]
    },

    # MODULE 2: Advanced Vibe Coding & Agentic Workflows
    {
        "module": "Module 2: Advanced Vibe Coding & Agentic Workflows",
        "title": "Autonomous Coding Agents (Devin & Claude Computer Use)",
        "duration": "25:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/TBhRC4Dath4",
        "isPreview": False,
        "content": """## Autonomous Coding Agents (Devin & Claude Computer Use)

### Core Concept
Autonomous agents go beyond simple autocomplete. They are equipped with a terminal, browser, and editor, enabling them to complete complex tasks autonomously, run unit tests, and fix compilation errors.

### The Agent Loop
1. Receive goal and analyze repository.
2. Formulate step-by-step implementation plan.
3. Write code, execute terminal commands, and observe failures.
4. Iterate and fix bugs until the task passes verification."""
    },
    {
        "module": "Module 2: Advanced Vibe Coding & Agentic Workflows",
        "title": "Prompting for Code, Debugging, and Testing",
        "duration": "30:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/7M6CSCIMJ3k",
        "isPreview": False,
        "content": """## Prompting for Code, Debugging, and Testing

### Core Concept
Coding prompts must be specific. To debug effectively, pass the stack trace or error log alongside the failing code. Ask the AI to write unit tests to ensure that changes do not break existing functionality.

### Prompting Strategy
- Be direct and specify the target language and framework.
- Avoid vague statements. Use 'Write a function that...' instead of 'Help me code...'.
- Provide mock input and expected output data structure."""
    },
    {
        "module": "Module 2: Advanced Vibe Coding & Agentic Workflows",
        "title": "Real-World Workflows & Launching Your Apps",
        "duration": "35:00",
        "type": "video",
        "videoUrl": "https://www.youtube.com/embed/p8k2j9h6f5d",
        "isPreview": False,
        "content": """## Real-World Workflows & Launching Your Apps

### Core Concept
A successful Vibe Coding project requires managing context limits and prompt drift. If a chat history becomes too long, start a new chat window and pass a summary of the codebase structure. Deploy your apps using automatic hosting platforms (such as Netlify or Vercel) linked to GitHub.

---

### Module 2 Practical Activity
Draft an error-handling prompt. Take a broken piece of code or error log, explain the error, and write an instruction that tells the AI how to fix the bug while maintaining the existing features.

### Nigerian Business Example
Olu's Logistics, a delivery service in Ikeja, needed to automate booking notifications. Olu used Cursor to build a Node.js server. When a payment webhook error occurred, he copied the stack trace into the AI panel, which immediately diagnosed a missing environment variable and refactored the connection timeout to be robust.""",
        "quizQuestions": [
            {
                "question": "What defines an 'Autonomous Coding Agent' like Devin?",
                "options": [
                    "It operates entirely in a terminal and cannot run code",
                    "It can search the web, write code, run command lines, test programs, and debug errors autonomously to complete a goal",
                    "It is a physical robot that types on keyboard",
                    "It is a template builder for static HTML"
                ],
                "correctIndex": 1,
                "explanation": "Agentic coders can read logs, run commands, view browser outputs, and iteratively fix their own errors until the user's request is met."
            },
            {
                "question": "When debugging code with AI, what is the best practice?",
                "options": [
                    "Ask the AI to rewrite the entire application from scratch",
                    "Provide the exact error message or stack trace, along with the relevant code block and context",
                    "Ignore the error and write new features",
                    "Manually search online forums instead of asking the AI"
                ],
                "correctIndex": 1,
                "explanation": "Providing the specific error trace, relevant files, and recent changes helps the AI pinpoint the bug and write a targeted patch."
            },
            {
                "question": "What is 'prompt drift' or 'context overload' in long vibe coding sessions?",
                "options": [
                    "The AI getting disconnected from the internet",
                    "The AI forgetting earlier project rules or becoming confused as the chat history grows too large",
                    "A database crash caused by slow queries",
                    "The code compiling to the wrong directory"
                ],
                "correctIndex": 1,
                "explanation": "As the conversation transcript gets longer, key instructions can get lost or diluted. Restarting the session or summarizing context helps keep the AI accurate."
            }
        ]
    }
]

# Write files
with open('C:/Users/Akinola Olujobi/.gemini/antigravity/brain/24a26cdb-ac7d-4c1d-bf20-857400faa4e8/scratch/facebook_ads_lessons.json', 'w', encoding='utf-8') as f:
    json.dump(fb_lessons, f, indent=2)

with open('C:/Users/Akinola Olujobi/.gemini/antigravity/brain/24a26cdb-ac7d-4c1d-bf20-857400faa4e8/scratch/vibe_coding_lessons.json', 'w', encoding='utf-8') as f:
    json.dump(vibe_lessons, f, indent=2)

print("Saved JSON files successfully!")
