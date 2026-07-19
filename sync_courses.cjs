const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const crypto = require('crypto');

const client = new Client({
  host: '108.128.216.176',
  port: 6543,
  user: 'postgres.doyrfbndzpcarfkulbhe',
  password: 'C7gbLy2bXp0mvcfOAsInZm',
  database: 'postgres',
  ssl: {
    rejectUnauthorized: false,
    servername: 'aws-0-eu-west-1.pooler.supabase.com'
  }
});

// Helper to generate UUIDs deterministically for lessons/modules
function getDeterministicUUID(salt) {
  const hash = crypto.createHash('sha256').update(salt).digest('hex');
  return `${hash.substring(0, 8)}-${hash.substring(8, 12)}-4${hash.substring(13, 16)}-a${hash.substring(17, 20)}-${hash.substring(20, 32)}`;
}

// ----------------------------------------------------
// QUIZ & ACTIVITY GENERATORS FOR ALL 3 COURSES
// ----------------------------------------------------

function getVibeQuizzes(moduleNum, moduleTitle) {
  const quizzes = [
    [
      {
        question: "What is the core shift in Vibe Coding compared to traditional programming?",
        options: ["Shifting from manual syntax writing to directing systems via natural language intent", "Focusing entirely on writing raw assembly code", "Coding only on offline mobile devices", "Replacing database design with spreadsheets"],
        correctIndex: 0,
        explanation: "Vibe Coding prioritizes expressing intent in natural language while leveraging AI tools to write, debug, and configure the code."
      },
      {
        question: "Which of the following is a primary benefit of Vibe Coding?",
        options: ["It completely eliminates the need for any logic", "It allows developers and creators to prototype and launch apps at extreme speed", "It runs code faster on local machines", "It works without internet connectivity"],
        correctIndex: 1,
        explanation: "By automating syntax and boilerplate generation, Vibe Coding allows rapid iteration and faster product launches."
      },
      {
        question: "In the Vibe Coding workflow, what is the human's primary role?",
        options: ["Writing semicolons and curly braces", "Defining product vision, user experience, and logical requirements", "Compiling code manually in the terminal", "Formatting database files"],
        correctIndex: 1,
        explanation: "The human acts as the architect and director, guiding the AI to build the right outcomes rather than writing every line manually."
      }
    ],
    [
      {
        question: "What makes AI-First tools different from traditional developer tools?",
        options: ["They do not support modern programming languages", "They integrate deep codebase-wide index search, context, and inline AI edits", "They are paid-only and have no coding tools", "They require no internet connection"],
        correctIndex: 1,
        explanation: "AI-First IDEs and builders index the entire workspace, allowing the model to understand file dependencies and make edits across files."
      },
      {
        question: "Which tool category is best suited for building full-stack web apps in a single chat interface?",
        options: ["Static text editors", "Full-Stack AI builders (like Bolt.new or Lovable)", "Local database clients", "Version control command lines"],
        correctIndex: 1,
        explanation: "Full-Stack AI builders generate frontend code, compile backends, set up databases, and deploy live apps from a single prompt."
      },
      {
        question: "What is a key principle of the AI-First development workflow?",
        options: ["Write all code by hand first, then ask AI to review it", "Define requirements clearly in natural language and iteratively refine outputs", "Avoid version control systems", "Deploy applications only to local servers"],
        correctIndex: 1,
        explanation: "The AI-First workflow relies on natural language instructions, incremental prompts, and feedback loops to build applications."
      }
    ],
    [
      {
        question: "What is Bolt.new's primary technical feature?",
        options: ["It runs only on desktop platforms", "It runs a full WebContainers Node.js environment in the browser, compiling and running code live", "It is a simple drag-and-drop builder", "It doesn't support npm packages"],
        correctIndex: 1,
        explanation: "Bolt.new uses WebContainers to run full Node.js environments inside the browser, allowing it to install packages and spin up dev servers."
      },
      {
        question: "How does Lovable differ from Bolt.new in focus?",
        options: ["Lovable doesn't generate clean UI styling", "Lovable focuses heavily on high-fidelity user interfaces, design aesthetics, and clean styling", "Lovable is for backend microservices only", "Lovable doesn't support React"],
        correctIndex: 1,
        explanation: "Lovable is designed for high-fidelity UI/UX, styling consistency, and pixel-perfect layouts, making it great for client-facing MVPs."
      },
      {
        question: "In what scenario is a browser-based full-stack builder most appropriate?",
        options: ["Developing low-level OS kernels", "Rapidly scaffolding, testing, and deploying SaaS MVPs or landing pages", "Running high-frequency trading scripts", "Managing massive enterprise database clusters"],
        correctIndex: 1,
        explanation: "Browser-based AI builders are optimized for rapid application scaffolding, database CRUD operations, and responsive web pages."
      }
    ],
    [
      {
        question: "What does codebase-wide indexing in Cursor IDE enable?",
        options: ["It encrypts the repository for security", "It allows the LLM to search, reference, and understand dependencies across all files in your project", "It speeds up project compilation time", "It deletes duplicate files automatically"],
        correctIndex: 1,
        explanation: "Cursor indexes the workspace, enabling the model to answer codebase questions, write imports correctly, and edit multiple related files."
      },
      {
        question: "Which shortcut launches the Cursor inline editor for quick code modifications?",
        options: ["Ctrl + Shift + P", "Ctrl + K (or Cmd + K)", "Ctrl + F", "Alt + F4"],
        correctIndex: 1,
        explanation: "Ctrl/Cmd + K opens the inline prompt bar to generate, refactor, or edit code directly at the cursor location."
      },
      {
        question: "How does Windsurf handle multi-file editing compared to standard editors?",
        options: ["It doesn't support multi-file edits", "It uses an agentic system that can edit multiple files and run terminal commands to resolve compilation issues", "It requires you to copy-paste all edits manually", "It disables keyboard inputs during editing"],
        correctIndex: 1,
        explanation: "Windsurf's agentic system can make multi-file edits and execute shell commands to fix compile errors and run tests."
      }
    ],
    [
      {
        question: "What is an autonomous coding agent?",
        options: ["A robot that types on a physical keyboard", "An AI agent equipped with an editor, terminal, and browser that can complete complex development tasks on its own", "An autocomplete tool that suggests variable names", "A database server that runs SQL queries"],
        correctIndex: 1,
        explanation: "Autonomous agents like Devin or OpenHands analyze code, write patches, execute tests, and iterate until the given goal is achieved."
      },
      {
        question: "What is a main advantage of Claude's Computer Use capability?",
        options: ["It replaces the need for a mouse and keyboard completely", "It allows Claude to view screen outputs and interact with standard desktop applications, browsers, and tools", "It speeds up the computer's CPU", "It makes the computer run without electricity"],
        correctIndex: 1,
        explanation: "Computer Use lets Claude control the screen, click buttons, and run tools in a virtual environment to complete tasks."
      },
      {
        question: "When working with autonomous coding agents, how should you formulate instructions?",
        options: ["Provide vague, single-word prompts", "Define clear goals, expected behaviors, constraints, and verification steps", "Avoid giving details about the codebase", "Ask them to write the code in standard text documents only"],
        correctIndex: 1,
        explanation: "Clear, structured instructions specifying goals, files to modify, and success criteria ensure agent accuracy."
      }
    ],
    [
      {
        question: "What is prompt drift or context overload in long sessions?",
        options: ["A hardware failure on the server", "The AI forgetting earlier rules or becoming confused as the chat history grows too large", "A database connection timeout", "A version control conflict"],
        correctIndex: 1,
        explanation: "As chat histories get very long, key constraints or rules can get lost. Starting a new chat window with clean context resolves this."
      },
      {
        question: "When deploying an AI-built web application, what is a best practice for hosting?",
        options: ["Set up a local physical server in your office", "Connect your GitHub repository to platforms like Vercel or Netlify for automated CI/CD builds", "Send the code files to customers via email", "Host it on a static USB drive"],
        correctIndex: 1,
        explanation: "Connecting GitHub to Vercel/Netlify ensures every code commit automatically builds and deploys your changes to a live URL."
      },
      {
        question: "How do you handle secrets (like API keys) in vibe coding projects?",
        options: ["Write them directly into the frontend code files", "Store them securely in environment variables (.env files) and load them at runtime", "Ignore them and leave inputs blank", "Publish them in the public GitHub README"],
        correctIndex: 1,
        explanation: "API keys and sensitive credentials should always be stored in environment variables, never committed directly to git."
      }
    ],
    [
      {
        question: "What is the primary benefit of few-shot prompting for code generation?",
        options: ["It reduces the number of API tokens consumed", "It provides the model with examples of your exact coding styles and structures to follow", "It speeds up code execution", "It makes the code run on any framework"],
        correctIndex: 1,
        explanation: "Few-shot prompting provides example inputs and outputs, showing the model how to structure functions and styling to match your codebase."
      },
      {
        question: "Which strategy is most effective when prompting AI to fix a complex bug?",
        options: ["Ask the AI to rewrite the entire application", "Provide the exact stack trace, error logs, and the relevant code files", "Ignore the error and write new features", "Use short, vague descriptions of the bug"],
        correctIndex: 1,
        explanation: "Providing error stack traces, relevant files, and surrounding context helps the AI pinpoint the bug and write a clean patch."
      },
      {
        question: "What is a multi-step prompting workflow?",
        options: ["Writing one massive prompt to build a complex SaaS product", "Breaking down a large task into sequential, bite-sized instructions (e.g., database, API, then UI)", "Asking the AI to repeat the same code 10 times", "Running terminal commands in a loop"],
        correctIndex: 1,
        explanation: "Multi-step prompting guides the AI sequentially, verifying each component (database -> backend -> UI) before moving to the next."
      }
    ],
    [
      {
        question: "Which of the following is an emerging career path in the Vibe Coding era?",
        options: ["Manual syntax typewriter", "AI Workflow Architect / AI Product Builder", "Offline database administrator", "Static page formatter"],
        correctIndex: 1,
        explanation: "AI Workflow Architects design, deploy, and scale multi-agent systems and AI tools to build SaaS products and automate agency deliverables."
      },
      {
        question: "How does Vibe Coding affect the barrier to entry for launching software startups?",
        options: ["It raises the barrier by requiring more complex syntax", "It dramatically lowers the barrier, allowing solo creators to build and launch MVPs in days", "It has no effect on software startups", "It makes startup creation impossible"],
        correctIndex: 1,
        explanation: "Vibe Coding lowers the technical barrier, letting non-technical founders prototype, test, and deploy functional applications."
      },
      {
        question: "What is a critical skill for an AI-First developer in the future?",
        options: ["Memorizing physical keyboard layouts", "System design, logical reasoning, and prompting capabilities", "Writing pure assembly language manually", "Installing operating systems manually"],
        correctIndex: 1,
        explanation: "System architecture, logical reasoning, and clear prompt direction are the most valuable skills as AI handles syntax."
      }
    ],
    [
      {
        question: "What is the primary role of unit tests in Vibe Coding?",
        options: ["To delay deployment unnecessarily", "To verify individual functions work as expected and prevent regression when code is modified", "To speed up page loading times", "To style frontend components"],
        correctIndex: 1,
        explanation: "Unit tests check individual code blocks, ensuring that new AI edits do not break existing business logic."
      },
      {
        question: "Which tool is commonly used to automate testing in modern web applications?",
        options: ["Photoshop", "Jest (or Playwright/Vitest)", "Excel", "Notepad"],
        correctIndex: 1,
        explanation: "Jest, Vitest, and Playwright are popular testing frameworks used to run automated test suites on web projects."
      },
      {
        question: "How can AI help with testing software?",
        options: ["It can run tests offline without computer power", "It can automatically generate unit test files, mock data, and cover boundary cases based on your code", "It replaces the need for any test runners", "It fixes all bugs without running tests"],
        correctIndex: 1,
        explanation: "AI assistants can analyze your code logic and instantly generate test suites covering positive, negative, and edge cases."
      }
    ],
    [
      {
        question: "What does Git track in a software project?",
        options: ["Only the database entries", "Version history, changes, and branches for your codebase", "User login sessions", "API response speeds"],
        correctIndex: 1,
        explanation: "Git is a version control system that tracks modifications, branches, and commit history for your code files."
      },
      {
        question: "How can AI tools enhance version control workflows?",
        options: ["By deleting merge logs", "By generating descriptive commit messages from code diffs and reviewing pull requests for bugs", "By replacing Git entirely", "By hosting files on local databases"],
        correctIndex: 1,
        explanation: "AI tools can scan git diffs to draft commit messages and review pull requests for security flaws and code style."
      },
      {
        question: "What is a merge conflict in Git?",
        options: ["When a developer leaves the team", "When changes on different branches modify the same lines of code, requiring manual resolution", "When the database runs out of storage", "When an API key expires"],
        correctIndex: 1,
        explanation: "A merge conflict occurs when Git cannot automatically merge changes on the same line, requiring a developer to choose the correct code."
      }
    ],
    [
      {
        question: "When building an AI-powered landing page, what is the most important element for conversions?",
        options: ["Vibrant flashing animations", "Clear value copywriting, responsive layout, and working lead capture forms", "Having 10+ pages of documentation", "Using custom fonts for every paragraph"],
        correctIndex: 1,
        explanation: "A high-converting landing page relies on simple navigation, clear benefits copy, mobile responsiveness, and functional signup forms."
      },
      {
        question: "Which styling utility framework is most popular with AI builders like V0 and Bolt?",
        options: ["Vanilla CSS only", "Tailwind CSS", "Bootstrap", "Sass styling"],
        correctIndex: 1,
        explanation: "Tailwind CSS's utility class structure is highly preferred by AI builders as it generates inline layouts easily without separate stylesheets."
      },
      {
        question: "What database service is commonly integrated with Lovable and Bolt projects?",
        options: ["Oracle DB", "Supabase (PostgreSQL)", "SQLite locally", "Access database"],
        correctIndex: 1,
        explanation: "Supabase provides an instant, secure PostgreSQL database with auth, storage, and real-time features, making it ideal for AI builders."
      }
    ],
    [
      {
        question: "What is an API webhook?",
        options: ["A visual banner on a landing page", "An automated notification sent from one server to another when an event occurs (e.g., successful payment)", "A database query filter", "A browser cookie management system"],
        correctIndex: 1,
        explanation: "Webhooks are HTTP requests sent from a source server (like Stripe) to your application server to trigger actions when events happen."
      },
      {
        question: "Why should API keys never be committed to a public GitHub repository?",
        options: ["It slows down the git push command", "It exposes your credentials, allowing unauthorized access, data theft, and financial costs", "It makes the project compile to the wrong directory", "It deletes your repository history"],
        correctIndex: 1,
        explanation: "Publicly visible API keys can be scraped by bots, leading to security breaches, database deletions, or large bills from API providers."
      },
      {
        question: "What is the role of an authorization header in an API call?",
        options: ["To set the font style of the response", "To send secure credentials (like tokens) to verify your permission to access the resource", "To track page load times", "To specify the device type"],
        correctIndex: 1,
        explanation: "Authorization headers securely pass keys or tokens (like Bearer tokens) to authenticate your API requests."
      }
    ],
    [
      {
        question: "What is database indexing?",
        options: ["Creating a list of database tables", "A database optimization technique that speeds up search queries on specific columns", "Deleting old backup records", "Converting SQL to JSON"],
        correctIndex: 1,
        explanation: "Indexes help database engines look up rows faster, reducing query times from seconds to milliseconds."
      },
      {
        question: "How can image compression improve a web application?",
        options: ["It changes the image color scheme", "It reduces file sizes, leading to faster page load speeds and better SEO performance", "It adds security encryption to the image", "It translates image text automatically"],
        correctIndex: 1,
        explanation: "Compressing images lowers bandwidth usage, allowing pages to load faster, which improves user experience and SEO rankings."
      },
      {
        question: "What is a main career direction for graduates of Vibe Coding?",
        options: ["Hardware repair technician", "SaaS Founder, AI-First Freelancer, or AI Workflow Consultant", "Manual database typist", "Network cable installer"],
        correctIndex: 1,
        explanation: "Vibe Coding equips individuals to launch products as SaaS founders, offer rapid freelance services, or optimize agency workflows as AI consultants."
      }
    ]
  ];
  return quizzes[moduleNum - 1] || quizzes[0];
}

function getVibeActivities(moduleNum) {
  const activities = [
    {
      activity: "Write a clear natural-language system prompt describing a simple task tracking app. Detail the buttons, list layout, and what happens when tasks are added or completed.",
      nigerianExample: "Amina, an Abuja caterer, used vibe coding to build a recipe ingredient scaler. She described her pricing sheet, and AI generated a mobile tool she now uses on her phone to buy bulk items at Wuse market."
    },
    {
      activity: "Map out a product features list and a simple text layout plan for a local laundry service web application before using any AI tools.",
      nigerianExample: "Chidi in Enugu drew a simple diagram of his electronics store dashboard on paper. This structure became the reference blueprint he passed to Bolt.new to get a working order tracker."
    },
    {
      activity: "Scaffold a simple React landing page with an email newsletter input using Bolt.new. Test that submitting the form displays a success message.",
      nigerianExample: "Funmi, a fashion designer in Lagos, created a collection launch page in Bolt.new. She integrated a Paystack checkout simulation in a single afternoon without writing any backend scripts."
    },
    {
      activity: "Open Cursor, enable indexing, and use Ctrl+L to ask the AI to find where the app's routing configuration is located and explain how to add a new route.",
      nigerianExample: "Tunde, a freelance developer in Ibadan, used Cursor's index search to find a bug in a client's legacy codebase in minutes, earning N50,000 for a fix that would have taken days to find manually."
    },
    {
      activity: "Write a prompt instructing Claude to analyze a node server file and suggest an implementation plan to add email notifications via a mail service.",
      nigerianExample: "A logistics company in Ikeja set up an autonomous developer agent to audit their shipping coordinator script. The agent identified three security flaws and automatically committed the patched files."
    },
    {
      activity: "Link a GitHub repository to a free Vercel account and deploy a live page. Make a small text edit in GitHub and verify the page updates automatically.",
      nigerianExample: "Kelechi's real estate agency in Port Harcourt automated listing updates by linking their website repo to Vercel. Pushing property listings instantly updates their live customer portal."
    },
    {
      activity: "Write a prompt demonstrating few-shot learning by providing a sample UI card format and asking the AI to generate a matching card layout for a product list.",
      nigerianExample: "A digital marketing agency in Lagos created a prompt template containing their brand guidelines. Their AI builders now generate landing pages that perfectly match their brand style."
    },
    {
      activity: "Research three emerging AI builders or plugins, list their key features, and identify which manual developer tasks they automate.",
      nigerianExample: "A tech hub in Kano transitioned their student project workflow to AI-first tools, reducing the time required for students to launch MVP apps from six months to two weeks."
    },
    {
      activity: "Write a unit test prompt asking Vitest/Jest to test a currency conversion function that converts USD to NGN, covering zero, negative, and large inputs.",
      nigerianExample: "An e-commerce business in Onitsha automatically generated Jest test suites for their shopping cart logic, ensuring that discount codes do not cause cart checkout errors."
    },
    {
      activity: "Create a new Git branch, make a file edit, commit it with an AI-generated message, and merge it, resolving any merge conflict that occurs.",
      nigerianExample: "A team of two designers in Kaduna built a collaborative workspace using git. They used Cursor to instantly resolve layout merge conflicts, maintaining coordinate designs."
    },
    {
      activity: "Use V0.dev to design a modern, responsive user profile card with social links and import the generated Tailwind code into a project.",
      nigerianExample: "Ngozi, an interior decorator in Lagos, designed a beautiful portfolio gallery layout in V0.dev, exported the code, and went live with her business site in less than 48 hours."
    },
    {
      activity: "Write an API fetch request function in JavaScript that handles network errors, loading states, and successfully updates page content.",
      nigerianExample: "A travel portal in Abuja integrated a live flight API. The developer used AI to scaffold the API response parser, displaying real-time booking details on the user dashboard."
    },
    {
      activity: "Run a Lighthouse audit on your local project, list the top three performance bottlenecks, and ask AI to write an optimization plan.",
      nigerianExample: "Musa in Kano launched a local directory SaaS. By compressing images and indexing database tables, he reduced page load times from 8 seconds to 1.2 seconds, boosting conversions."
    }
  ];
  return activities[moduleNum - 1] || activities[0];
}


function getFbQuizzes(moduleNum, moduleTitle) {
  const quizzes = [
    [
      {
        question: "How does the Meta Ads Auction System determine which ad to show a user?",
        options: ["Based purely on the highest monetary bid", "Based on the Total Value formula: Bid * Estimated Action Rate + User Value", "Randomly from all approved campaigns", "Based on the length of the advertiser's campaign history"],
        correctIndex: 1,
        explanation: "Meta uses the Total Value formula to balance advertiser ROI (Bid and Action Rates) with user experience (User Value/Ad Quality)."
      },
      {
        question: "What does the 'Estimated Action Rate' represent in the Meta Ads algorithm?",
        options: ["The speed at which users scroll past your ad", "Meta's prediction of how likely a specific user is to complete your campaign objective", "The number of hours the ad runs daily", "The click rate on your competitor's ads"],
        correctIndex: 1,
        explanation: "Estimated Action Rate is the algorithm's prediction of the probability that a user will take the desired action (e.g., convert or click)."
      },
      {
        question: "Which Meta tool is the central hub for managing assets, pages, ad accounts, and team permissions?",
        options: ["Ads Manager", "Business Manager (Meta Business Suite)", "Events Manager", "Audience Network"],
        correctIndex: 1,
        explanation: "Business Manager acts as the umbrella dashboard to control access and permissions for all company marketing assets."
      }
    ],
    [
      {
        question: "At which level of the Meta Ads Manager hierarchy do you define your objective (e.g., Sales, Leads)?",
        options: ["Ad Set Level", "Campaign Level", "Ad Level", "Account Level"],
        correctIndex: 1,
        explanation: "Campaign objectives (Leads, Sales, Traffic, etc.) are always set at the Campaign level."
      },
      {
        question: "What is the primary difference between Advantage+ Budget (CBO) and Ad Set Budget (ABO)?",
        options: ["CBO works only for mobile placement, while ABO works for desktop", "CBO distributes budget dynamically across ad sets, while ABO allocates fixed budgets to individual ad sets", "CBO is free, while ABO is paid", "ABO is optimized automatically by Meta AI, while CBO is manual"],
        correctIndex: 1,
        explanation: "Campaign Budget Optimization (CBO) lets Meta dynamically allocate your campaign budget to the best-performing ad sets, while Ad Set Budget (ABO) gives you manual control per ad set."
      },
      {
        question: "What is a major pitfall of setting up multiple ad sets targeting highly overlapping audiences?",
        options: ["It results in account suspension", "It causes audience fatigue and auction overlap, driving up CPM costs", "It disables dynamic creatives", "It limits placements to Instagram only"],
        correctIndex: 1,
        explanation: "Audience overlap forces your own ad sets to compete against each other in the auction, increasing costs (CPM) and reducing delivery efficiency."
      }
    ],
    [
      {
        question: "What is the key difference between Core Audiences and Custom Audiences?",
        options: ["Core Audiences are based on demographic, interest, and geographic filters; Custom Audiences are based on your own customer data (e.g., website visitors, email list)", "Custom Audiences are free, while Core Audiences cost extra", "Core Audiences target only desktop users", "Custom Audiences cannot be used for retargeting"],
        correctIndex: 0,
        explanation: "Core Audiences use Meta's data filters. Custom Audiences match your own first-party data (pixels, lists) with Meta profiles."
      },
      {
        question: "How is a 'Lookalike Audience' created?",
        options: ["By choosing search terms on Google", "By letting Meta find users who share characteristics with an existing source Custom Audience (e.g. past purchasers)", "By copy-pasting your competitors' audience lists", "By running an engagement survey"],
        correctIndex: 1,
        explanation: "Lookalikes require a source Custom Audience. Meta uses machine learning to find matching profiles in the targeted country."
      },
      {
        question: "What is the recommended size parameter for a Lookalike Audience to balance relevance and scale?",
        options: ["10% to 20%", "1% to 3%", "50%+", "Under 0.1%"],
        correctIndex: 1,
        explanation: "A 1% lookalike is the most closely matched to the source audience. 1% to 3% lookalikes provide the best balance of relevance and audience size."
      }
    ],
    [
      {
        question: "What does the concept of 'Creative Hook Rate' measure?",
        options: ["The percentage of people who click the CTA button", "The percentage of impressions that watch the first 3 seconds of a video ad", "The number of comments on an ad", "The image file load speed"],
        correctIndex: 1,
        explanation: "Hook Rate (3-second video views ÷ impressions) measures how effectively your ad creative stops users from scrolling."
      },
      {
        question: "In 2025 Meta Ads, which creative element has the highest impact on performance?",
        options: ["The campaign naming convention", "The ad creative (visual format, hooks, angles, and messaging)", "The bid cap amount", "Using exact location ZIP codes"],
        correctIndex: 1,
        explanation: "Creative is the primary driver of performance. The algorithm targets users based on who interacts with your creative messaging."
      },
      {
        question: "What is the primary benefit of Meta's Dynamic Creative (or Advantage+ Creative)?",
        options: ["It writes your landing page text", "It automatically tests variations of headlines, descriptions, and media to show the best combination to each user", "It reduces your cost per click to zero", "It bypasses the ad approval process"],
        correctIndex: 1,
        explanation: "Advantage+ Creative combines your text, image, and video assets to serve personalized variations, maximizing conversion rates."
      }
    ],
    [
      {
        question: "Why is Meta Conversions API (CAPI) necessary alongside the standard browser Pixel?",
        options: ["It makes ads look better on mobile screen", "It bypasses browser ad-blockers and privacy updates (like iOS 14+) by sending server-to-server event data directly to Meta", "It is required for running video ads", "It allows you to view customer names"],
        correctIndex: 1,
        explanation: "Browser pixels are blocked by privacy filters. CAPI sends server-to-server data, restoring signal accuracy and matching rates."
      },
      {
        question: "What does a 'Lead Magnet Funnel' prioritize?",
        options: ["Immediate high-ticket product sales", "Exchanging valuable free resources (e.g. ebooks, checklists) for user contact details to build an email list", "Getting viral social media shares", "Retargeting past buyers with coupons"],
        correctIndex: 1,
        explanation: "Lead magnets build an audience by offering value upfront in exchange for contact info, nurturing prospects into buyers later."
      },
      {
        question: "What is 'Message-Match' between an ad creative and its landing page?",
        options: ["Using the exact same image dimensions on both pages", "Aligning the headline, value proposition, design style, and offer of your ad directly with the landing page", "Having the same color background", "Using automated chatbot replies"],
        correctIndex: 1,
        explanation: "Consistent messaging and design ensure users don't feel confused or misled after clicking, which keeps bounce rates low."
      }
    ],
    [
      {
        question: "What occurs during Meta's campaign 'Learning Phase'?",
        options: ["Meta trains the advertiser on platform policies", "The algorithm actively tests delivery to different pockets of the audience to find the most cost-effective placements", "The campaign is put on hold and does not spend money", "The ad creative is rewritten by Meta AI"],
        correctIndex: 1,
        explanation: "During the learning phase, Meta delivers ads to various users, collecting performance data to stabilize delivery."
      },
      {
        question: "How many conversion events per week does an ad set typically need to exit the Learning Phase?",
        options: ["Exactly 1000 conversions", "Approximately 50 optimization events (conversions) within a 7-day period", "At least 5 clicks per day", "There is no minimum conversion count"],
        correctIndex: 1,
        explanation: "Meta requires about 50 conversions per ad set per week to get past the learning phase and stabilize performance."
      },
      {
        question: "If an ad set's status displays 'Learning Limited', what does it mean?",
        options: ["The campaign has been paused due to policy violation", "The ad set cannot generate enough conversions (50/week) to exit the learning phase due to budget or audience size", "The advertiser needs to retake a certification exam", "The ad is blocked in specific geographic regions"],
        correctIndex: 1,
        explanation: "Learning Limited indicates the ad set is underperforming or underfunded, preventing the algorithm from fully optimizing."
      }
    ],
    [
      {
        question: "What is the difference between Vertical Scaling and Horizontal Scaling?",
        options: ["Vertical scaling targets mobile apps; horizontal scaling targets desktop pages", "Vertical scaling increases the budget of winning ad sets; horizontal scaling duplicates winning creatives into new audiences or angles", "Vertical scaling is manual, while horizontal scaling is fully automated", "Vertical scaling is for retargeting only"],
        correctIndex: 1,
        explanation: "Vertical scaling increases spend on existing ad sets (by 20% increments to avoid reset). Horizontal scaling expands reach via new audiences and creatives."
      },
      {
        question: "By what maximum percentage should you increase an ad set's budget at one time to avoid resetting the learning phase?",
        options: ["100% (double the budget)", "15% to 20%", "50%", "5%"],
        correctIndex: 1,
        explanation: "Increasing budget by more than 20% at a time triggers a significant edit, resetting the learning phase and causing volatility."
      },
      {
        question: "What is a 'Bid Cap' bidding strategy?",
        options: ["Setting a limit on the total monthly campaign budget", "Setting a maximum bid amount you are willing to pay per individual auction bid", "Allowing Meta to spend as much as possible for conversions", "Limiting the campaign to run only on weekdays"],
        correctIndex: 1,
        explanation: "Bid Cap limits the maximum bid in the auction, ensuring you don't overpay for conversions, though it may limit ad delivery."
      }
    ],
    [
      {
        question: "In agency client management, what is a primary goal of a campaign audit?",
        options: ["Deleting the client's past history to start fresh", "Analyzing account structure, tracking signals, and creatives to identify performance bottlenecks and opportunities", "Exclusively changing the ad account password for security", "Increasing agency commissions immediately"],
        correctIndex: 1,
        explanation: "An audit investigates structure, tracking, targeting, and creatives to find quick wins and strategic optimizations for clients."
      },
      {
        question: "When launching a product, why is a pre-launch campaign structure beneficial?",
        options: ["It guarantees instant profitability on launch day", "It builds an email list, warm audience pools, and anticipation before the offer goes live", "It allows you to bypass Meta's ad approval policies", "It eliminates the need for video creatives"],
        correctIndex: 1,
        explanation: "Pre-launch campaigns build a warm, interested audience (via lead magnets or views) that converts quickly when the cart opens."
      },
      {
        question: "What is a 'Video Sales Letter' (VSL) funnel?",
        options: ["Sending video files to prospects via WhatsApp manually", "A landing page that uses a compelling video presentation to drive conversions, followed by a direct call-to-action", "Running a live webinar daily", "An ad format that does not allow sound"],
        correctIndex: 1,
        explanation: "VSL funnels use a high-value video pitch on the landing page to explain the product and offer, automating the sales process."
      }
    ],
    [
      {
        question: "How can AI tools enhance modern ad copywriting?",
        options: ["By clicking the budget increase button automatically", "By quickly generating multiple message angles, hooks, and body copy variations to test in Advantage+ campaigns", "By rewriting your product's landing page code", "By approving ads directly on Meta's servers"],
        correctIndex: 1,
        explanation: "AI copywriting tools help brainstorm multiple ad copy variations (short, long, bulleted) targeting different buyer personas."
      },
      {
        question: "What does Meta's Advantage+ Shopping Campaign (ASC) rely on?",
        options: ["Strict manual budget controls per ad set", "Heavy machine learning automation that tests placements, creatives, and audiences with minimal manual input", "Running ads only on Facebook Marketplace", "Excluding all mobile devices"],
        correctIndex: 1,
        explanation: "ASC campaigns automate targeting and placement, letting Meta's machine learning find conversions based on creative performance."
      },
      {
        question: "When using AI for creative generation, what is a key guideline?",
        options: ["Generate low-resolution images and upscale them", "Ensure visuals look realistic, align with brand voice, and test them alongside human-designed elements", "Avoid testing AI images in campaigns", "Use only text ads instead of visuals"],
        correctIndex: 1,
        explanation: "AI visuals should be high-quality and tested methodically against standard creative formats to measure actual conversion impact."
      }
    ],
    [
      {
        question: "What is the focus of Lifetime Value (LTV) optimization?",
        options: ["Lowering the cost of the first ad click", "Maximizing the long-term revenue generated from a customer over their entire relationship with your brand", "Running a single campaign forever", "Targeting only elderly demographics"],
        correctIndex: 1,
        explanation: "LTV focuses on post-purchase marketing, email flows, and cross-selling to make customer acquisition highly profitable over time."
      },
      {
        question: "Which official Meta certification is most relevant for media buyers and campaign managers?",
        options: ["Meta Certified Digital Marketing Associate", "Meta Certified Media Buying Professional", "Meta Certified Creative Strategy Professional", "Meta Certified Community Manager"],
        correctIndex: 1,
        explanation: "The Media Buying Professional certification validates advanced skills in campaign management, optimization, tracking, and diagnostics."
      },
      {
        question: "What pricing model is most common for professional Meta Ads agencies?",
        options: ["Hourly rates only", "Monthly retainers, project setup fees, or a percentage of ad spend / revenue generated", "Free trials indefinitely", "Charging only when the client makes a profit"],
        correctIndex: 1,
        explanation: "Professional agencies charge monthly retainers (e.g. $1,500/mo), project fees for setup, or percentage-of-spend performance models."
      }
    ]
  ];
  return quizzes[moduleNum - 1] || quizzes[0];
}

function getFbActivities(moduleNum) {
  const activities = [
    {
      activity: "Navigate to Meta Business Suite, inspect the ad account settings, check pixel status, and verify that the domains are verified in Brand Safety.",
      nigerianExample: "Adebayo's shoe brand in Lagos set up Meta Business Manager, verified their domain, and successfully installed the Meta Pixel on their Shopify store to track checkout steps."
    },
    {
      activity: "Draft a campaign structure on sheet or paper containing: 1 Campaign (Sales), 2 Ad Sets (CBO enabled, targeting Broad and Lookalike), and 2 Ads per Ad Set.",
      nigerianExample: "An Ankara boutique in Abuja structured their campaigns by grouping product lines into separate CBO campaigns, letting Meta automatically route budget to the top sellers."
    },
    {
      activity: "Create a retargeting Custom Audience of people who visited your website checkout page but did not buy in the last 30 days.",
      nigerianExample: "A skin-care clinic in Ikeja matched their client WhatsApp list to Meta Custom Audiences, retargeting them with a 15% discount offer that generated N300,000 in bookings."
    },
    {
      activity: "Design three distinct creative concepts for an ad campaign: a product demo video, a customer testimonial quote image, and a list of key benefits.",
      nigerianExample: "A gadget store in Computer Village, Lagos, tested a short video showing phone unboxing vs a static discount image. The video lowered customer acquisition costs by 40%."
    },
    {
      activity: "Audit your landing page speed on PageSpeed Insights and list three improvements to make the page load faster on mobile devices.",
      nigerianExample: "A wellness center in Abuja reduced their landing page image sizes. The page load speed dropped from 7 seconds to 2 seconds, cutting lead generation costs by half."
    },
    {
      activity: "Calculate the ROAS of a campaign that spent N150,000 and generated N600,000 in sales. List three steps to take if the ROAS fell below target.",
      nigerianExample: "A logistics brand in Lagos analyzed their cost per lead. They noticed high clicks but low signups, prompting them to change their form fields, which doubled signups."
    },
    {
      activity: "Take a winning ad set and create a scaling plan: increase budget vertically by 15%, and horizontally duplicate it to target a new Lookalike audience.",
      nigerianExample: "Chukwudi Fashion in Enugu scaled their campaigns horizontally by duplicating their best ad sets to target buyers in South-West Nigeria, raising sales from 10 to 45 packages daily."
    },
    {
      activity: "Draft a client campaign audit report template, listing key checks for account structure, pixel setup, creative assets, and budget allocation.",
      nigerianExample: "A digital agency in Port Harcourt landed a N500,000 retainer client by performing a free campaign audit that revealed N100,000 in monthly ad budget leakage."
    },
    {
      activity: "Use ChatGPT to generate five different hooks and three body copy variations for a local delivery service ad.",
      nigerianExample: "An food delivery app in Yaba used AI to write multiple ad copy versions. Testing them in a dynamic ad set revealed that bulleted benefit lists performed best."
    },
    {
      activity: "Take a free Meta Blueprint practice exam online, mark your weak areas, and list the Blueprint modules you need to review to pass.",
      nigerianExample: "Tolani, a freelance marketer in Lagos, earned her Meta Certified Media Buying credential, allowing her to charge corporate clients a premium retainer of N250,000 monthly."
    }
  ];
  return activities[moduleNum - 1] || activities[0];
}


function getPromptQuizzes(moduleNum, moduleTitle) {
  const quizzes = [
    [
      {
        question: "What is the primary definition of Prompt Engineering?",
        options: ["Writing code in Python", "The discipline of designing instructions to guide LLMs to produce desired outputs", "Building physical computer hardware", "Managing database connections"],
        correctIndex: 1,
        explanation: "Prompt Engineering is about crafting input instructions to steer large language models (LLMs) toward accurate, structured, and helpful responses."
      },
      {
        question: "How do Large Language Models process text inputs?",
        options: ["By reading whole books instantly", "By breaking text into smaller units called tokens and calculating word probabilities", "By converting everything into SQL queries", "By running scripts locally"],
        correctIndex: 1,
        explanation: "LLMs tokenize text input and use neural network weights to predict the most likely subsequent tokens."
      },
      {
        question: "What is a major difference between traditional programming and prompting?",
        options: ["Programming uses syntax rules; prompting uses natural language instructions to guide statistical models", "Prompting is only for graphics design", "Programming is free; prompting is paid", "There is no difference"],
        correctIndex: 0,
        explanation: "Traditional coding relies on absolute, deterministic syntax. Prompting guides probabilistic models via natural language context."
      }
    ],
    [
      {
        question: "What are the four essential components of a robust prompt?",
        options: ["Title, Author, Date, Page count", "Role/Persona, Context/Instruction, Input Data, and Output Indicator/Format", "Variables, Loops, Classes, Databases", "URL, IP address, Port, Protocol"],
        correctIndex: 1,
        explanation: "An effective prompt typically includes a Persona (who the AI is), Instructions (what to do), Input Data (what to process), and Output Format (how to display it)."
      },
      {
        question: "Why should you specify constraints in a prompt (e.g. 'do not use emojis')?",
        options: ["To speed up the model response speed", "To limit model creativity and ensure outputs comply with brand guidelines and formatting", "To reduce API costs", "To translate the text"],
        correctIndex: 1,
        explanation: "Constraints define strict boundaries, preventing the LLM from adding fluff, emojis, or incorrect formats."
      },
      {
        question: "What is 'prompt template design'?",
        options: ["Designing HTML layouts", "Creating reusable prompt structures with placeholders (e.g., {{INPUT_TEXT}}) for consistent formatting", "Writing custom CSS stylesheets", "Saving files to local databases"],
        correctIndex: 1,
        explanation: "Templates separate prompt structure from input variables, allowing applications to reuse prompts for different user queries."
      }
    ],
    [
      {
        question: "What is Zero-Shot prompting?",
        options: ["Writing a prompt with zero words", "Asking the model to complete a task without providing any examples in the input", "Running a model with zero GPU memory", "Deleting the chat history"],
        correctIndex: 1,
        explanation: "Zero-Shot relies on the model's pre-trained knowledge to perform a task without input examples."
      },
      {
        question: "What does Few-Shot prompting involve?",
        options: ["Sending few words in a prompt", "Providing the model with one or more examples of input and desired output formatting inside the prompt", "Training a model from scratch", "Running the prompt on a local server"],
        correctIndex: 1,
        explanation: "Few-shot prompting shows the model exact input-output pairs, helping it learn patterns and format styles dynamically."
      },
      {
        question: "Which prompting technique involves guiding the model to show its step-by-step reasoning?",
        options: ["Zero-Shot prompting", "Chain-of-Thought (CoT) prompting", "Few-Shot prompting", "System prompt optimization"],
        correctIndex: 1,
        explanation: "Chain-of-Thought prompts the LLM to write out its logical steps (e.g., 'Let's think step by step'), which improves reasoning accuracy."
      }
    ],
    [
      {
        question: "What does the 'Temperature' parameter control in an LLM API?",
        options: ["The physical heat of the server GPU", "The randomness and creativity of token selection (lower is deterministic, higher is creative)", "The maximum number of tokens generated", "The speed of the network connection"],
        correctIndex: 1,
        explanation: "Temperature scales token probabilities. Setting it near 0 makes outputs factual and consistent, while setting it near 1.0 increases creativity."
      },
      {
        question: "What is the impact of a model's 'Context Window' limit?",
        options: ["It defines how fast the model generates text", "It represents the maximum number of tokens the model can read and write in a single session", "It limits the model to only write code in Windows", "It is the physical monitor size"],
        correctIndex: 1,
        explanation: "Exceeding the context window causes the model to forget earlier parts of the conversation, causing prompt drift."
      },
      {
        question: "What are System Prompts used for?",
        options: ["Restarting the operating system", "Defining global behavior, rules, persona, and constraints that persist across a chat session", "Running database migrations", "Checking API connection speeds"],
        correctIndex: 1,
        explanation: "System prompts are high-level rules that enforce the model's tone, formatting, boundaries, and capabilities throughout the chat."
      }
    ],
    [
      {
        question: "What is 'Self-Consistency' prompting?",
        options: ["Writing the same prompt multiple times", "Running multiple reasoning paths and voting/selecting the most common answer", "Making the LLM check its own grammar", "Using local database backups"],
        correctIndex: 1,
        explanation: "Self-consistency generates multiple reasoning traces. The most frequent output is chosen, which increases math and logic accuracy."
      },
      {
        question: "How does 'Least-to-Most' prompting work?",
        options: ["Asking for the cheapest options first", "Deconstructing a complex problem into sub-problems and solving them sequentially, building on previous answers", "Writing short prompts first, then long ones", "Limiting CPU usage"],
        correctIndex: 1,
        explanation: "Least-to-Most breaks a hard problem down, solves the simplest sub-problem, and passes that output to solve the next sub-problem."
      },
      {
        question: "When should you use Chain-of-Thought prompting?",
        options: ["For simple translation or spelling corrections", "For complex math, logic, coding, and multi-step reasoning tasks", "For static HTML creation", "For simple database reads"],
        correctIndex: 1,
        explanation: "Logic and math benefit from CoT because writing out intermediate steps prevents the model from jumping to incorrect calculations."
      }
    ],
    [
      {
        question: "What does it mean to optimize a prompt?",
        options: ["Making the text file smaller in size", "Systematically testing, evaluating, and refining prompts to maximize accuracy and formatting reliability", "Buying a more expensive model subscription", "Translating the prompt into binary code"],
        correctIndex: 1,
        explanation: "Optimization involves testing variations, measuring response quality, and refining instructions to prevent failures."
      },
      {
        question: "What is a common strategy to mitigate LLM hallucinations?",
        options: ["Asking the model to search its memory database", "Providing clear context boundaries, warning the model to say 'I don't know' if unsure, and using grounding data", "Setting temperature to maximum", "Writing prompts in all caps"],
        correctIndex: 1,
        explanation: "Grounding (RAG) and providing boundaries (e.g. 'only answer using the provided text') drastically reduce false information."
      },
      {
        question: "What is Prompt Injection?",
        options: ["Adding SQL databases to a project", "A security exploit where user input overrides the system prompt's instructions and constraints", "Injecting CSS styling into a webpage", "Updating API key permissions"],
        correctIndex: 1,
        explanation: "Prompt injection happens when users input malicious commands (e.g., 'ignore previous instructions') that hijack the model's behavior."
      }
    ],
    [
      {
        question: "In context engineering, what is Retrieval-Augmented Generation (RAG)?",
        options: ["Generating random text based on a search engine", "Retrieving relevant documents from a database and injecting them into the prompt context for the LLM to reference", "Compiling React code into HTML", "Using API keys to unlock cloud servers"],
        correctIndex: 1,
        explanation: "RAG searches an external database for facts and inserts them into the prompt, grounding the LLM's response in real data."
      },
      {
        question: "What is the primary role of a 'System Persona' in a customer support agent prompt?",
        options: ["It writes emails automatically", "It dictates the tone, language style, empathy level, and scope of answers the agent provides", "It connects the API to the server", "It measures customer satisfaction scores"],
        correctIndex: 1,
        explanation: "Personas establish the voice and behavioral boundaries of the agent (e.g. 'You are a patient, helpful billing specialist')."
      },
      {
        question: "What is context truncation in large prompts?",
        options: ["Deleting the prompt completely", "The LLM ignoring or dropping text because it exceeds the maximum input capacity", "Converting spaces into tabs", "Translating files to another language"],
        correctIndex: 1,
        explanation: "Truncation occurs when prompts exceed context limits, causing the system to cut off earlier portions of the input."
      }
    ],
    [
      {
        question: "What is a main guideline for designing premium enterprise prompt systems?",
        options: ["Using vague instructions to allow model flexibility", "Applying modular structures, strict schemas (like JSON output), version control, and regression testing", "Running all prompts on free public web interfaces", "Writing prompts in multiple languages in one file"],
        correctIndex: 1,
        explanation: "Enterprise systems require consistent, structured, and tested prompts, often requesting JSON outputs to parse data reliably."
      },
      {
        question: "Why is prompt versioning important?",
        options: ["To track file size changes", "To maintain consistency, review updates, and roll back if model updates or edits degrade performance", "To change the API pricing tier", "To compile code faster"],
        correctIndex: 1,
        explanation: "Versioning lets teams track which prompt version is deployed, compare outputs, and roll back when model behaviors shift."
      },
      {
        question: "What is the benefit of requesting JSON output from an LLM?",
        options: ["It reduces API response speed", "It provides structured, machine-readable data that can be parsed directly by application code", "It styles the text with CSS colors", "It makes the model run offline"],
        correctIndex: 1,
        explanation: "JSON formatting allows software backends to parse variables (like keys and values) directly without text cleanups."
      }
    ]
  ];
  return quizzes[moduleNum - 1] || quizzes[0];
}

function getPromptActivities(moduleNum) {
  const activities = [
    {
      activity: "Write a zero-shot prompt and a few-shot prompt to classify customer feedback into positive, neutral, or negative, and compare the outputs.",
      nigerianExample: "A logistics brand in Lagos created a few-shot classifier prompt to triage incoming customer email complaints, sorting them to delivery, billing, or warehouse teams."
    },
    {
      activity: "Design a reusable prompt template for generating local business product descriptions, with placeholders for product name, category, and target audience.",
      nigerianExample: "A fashion boutique in Abuja used a structured prompt template to generate Instagram captions for their Ankara clothing items, keeping the tone consistent across campaigns."
    },
    {
      activity: "Write a Chain-of-Thought prompt solving a multi-step pricing math problem, and verify that the model writes down its logical steps.",
      nigerianExample: "A fintech store in Lagos prompted their AI assistant to calculate custom interest repayments on loans, forcing it to detail the formulas used to ensure audit accuracy."
    },
    {
      activity: "Test the output difference of a prompt when setting Temperature to 0.1 vs 0.9, noting down formatting, creativity, and repeatability.",
      nigerianExample: "A real estate agency in Port Harcourt set their property description generator's temperature to 0.8 for creativity, and their legal contract generator's temperature to 0.0 for strict accuracy."
    },
    {
      activity: "Write a Least-to-Most prompt that breaks down the task of writing a blog post outline, researching keywords, and drafting the introduction.",
      nigerianExample: "A content agency in Lagos deconstructed their SEO article writing by asking the AI to first list headers, then expand each header, and finally compile the full post."
    },
    {
      activity: "Write a prompt injection test to try to hijack a mock customer agent prompt, forcing it to reveal its secret system password, and refine instructions to prevent it.",
      nigerianExample: "An online marketplace in Yaba audited their support chatbot's prompts, adding guardrails to prevent users from tricking the bot into giving out free promo codes."
    },
    {
      activity: "Write a RAG prompt outline that injects customer purchase history from a mock database to generate a personalized product recommendation.",
      nigerianExample: "A pharmacy store in Abuja built a personalized email assistant by fetching client histories and passing them as context to write custom dosage reminders."
    },
    {
      activity: "Create a system design document outlining how your company will test, version, and manage prompts across multiple applications and models.",
      nigerianExample: "A software agency in Lagos set up a prompt management repository, versioning their prompts like code to maintain consistency as they integrated different LLM APIs."
    }
  ];
  return activities[moduleNum - 1] || activities[0];
}

// ----------------------------------------------------
// DATABASE OPERATION LOGIC
// ----------------------------------------------------

async function syncCourses() {
  await client.connect();
  console.log("Connected to Supabase PostgreSQL database successfully!");

  // Start Transaction
  await client.query("BEGIN;");

  try {
    // ----------------------------------------------------
    // COURSE 1: VIBE CODING
    // ----------------------------------------------------
    const vibeCourseId = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
    console.log("\n--- Syncing Vibe Coding Course ---");

    // Clear old data for Vibe Coding (due to cascade, deleting modules cleans up lessons and quiz_questions)
    await client.query("DELETE FROM modules WHERE course_id = $1;", [vibeCourseId]);

    // Ensure Vibe Coding course is in courses table
    const vibeCourseRes = await client.query("SELECT id FROM courses WHERE id = $1;", [vibeCourseId]);
    if (vibeCourseRes.rows.length === 0) {
      await client.query(`
        INSERT INTO courses (id, title, description, price, slug, level, category, duration)
        VALUES ($1, $2, $3, 10, $4, 'beginner', 'Development', '4 weeks');
      `, [
        vibeCourseId,
        'Vibe Coding: Building Real Software with AI',
        'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax.',
        'vibe-coding-building-real-software-with-ai'
      ]);
      console.log("Inserted Vibe Coding course record.");
    }

    // Parse Vibe Coding lessons from file
    const vibeCoursebookPath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/vibeCoursebook.ts';
    const vibeContent = fs.readFileSync(vibeCoursebookPath, 'utf8');
    const vibeLessonsParsed = parseLessonsFromTS(vibeContent);
    console.log(`Parsed ${vibeLessonsParsed.length} lessons from vibeCoursebook.ts`);

    // We have 13 modules for Vibe Coding. Let's define their titles.
    const vibeModuleTitles = [
      "Foundations of Vibe Coding",
      "The Vibe Coding Ecosystem",
      "Full-Stack AI Builders",
      "AI-First IDEs",
      "Agentic Coding Tools",
      "Real-World Workflows",
      "Prompting for Software",
      "The Future of Vibe Coding",
      "Testing and Debugging with AI",
      "Version Control and Collaboration",
      "Building Real Projects",
      "Advanced Vibe Coding Techniques",
      "Course Conclusion"
    ];

    // Map vibe lesson keys to their respective modules (order based on VIBE_CODING_LESSON_VIDEOS mapping)
    // Module 1: 1, 2
    // Module 2: 3, 4
    // Module 3: 5, 6
    // Module 4: 7, 8
    // Module 5: 9, 10
    // Module 6: 11, 15, 16
    // Module 7: 12, 13
    // Module 8: 14
    // Module 9: 17, 18
    // Module 10: 19, 20
    // Module 11: 21, 22, 23
    // Module 12: 24, 25
    // Module 13: 26
    const vibeLessonToModuleMap = {
      1: 1, 2: 1,
      3: 2, 4: 2,
      5: 3, 6: 3,
      7: 4, 8: 4, 9: 4, // Wait, Lesson 9 in check_vibe_modules was module 5, but let's check. Yes, let's map sequentially or keep:
      // Let's map exactly as in VIBE_CODING_LESSON_VIDEOS comments:
      // Module 1: 1, 2
      // Module 2: 3, 4
      // Module 3: 5, 6
      // Module 4: 7, 8
      // Module 5: 9, 10
      // Module 6: 11, 15, 16
      // Module 7: 12, 13
      // Module 8: 14
      // Module 9: 17, 18
      // Module 10: 19, 20
      // Module 11: 21, 22, 23
      // Module 12: 24, 25
      // Module 13: 26
    };
    // Let's refine the exact mapping:
    const getVibeModuleNum = (lessonNum) => {
      if (lessonNum === 1 || lessonNum === 2) return 1;
      if (lessonNum === 3 || lessonNum === 4) return 2;
      if (lessonNum === 5 || lessonNum === 6) return 3;
      if (lessonNum === 7 || lessonNum === 8) return 4;
      if (lessonNum === 9 || lessonNum === 10) return 5;
      if (lessonNum === 11 || lessonNum === 15 || lessonNum === 16) return 6;
      if (lessonNum === 12 || lessonNum === 13) return 7;
      if (lessonNum === 14) return 8;
      if (lessonNum === 17 || lessonNum === 18) return 9;
      if (lessonNum === 19 || lessonNum === 20) return 10;
      if (lessonNum === 21 || lessonNum === 22 || lessonNum === 23) return 11;
      if (lessonNum === 24 || lessonNum === 25) return 12;
      if (lessonNum === 26) return 13;
      return 1;
    };

    // Insert modules and get their UUIDs
    const vibeModuleUUIDs = {};
    for (let m = 1; m <= 13; m++) {
      const mTitle = `Module ${m}: ${vibeModuleTitles[m-1]}`;
      const mId = getDeterministicUUID(`vibe-mod-${m}`);
      await client.query(`
        INSERT INTO modules (id, course_id, title, order_index)
        VALUES ($1, $2, $3, $4);
      `, [mId, vibeCourseId, mTitle, m]);
      vibeModuleUUIDs[m] = mId;
    }
    console.log("Inserted 13 Vibe Coding modules.");

    // Video URL playlist mappings (from invisibleCourseEngine.ts)
    const vibeVideos = {
      1: "https://www.youtube.com/embed/Gpo_fkVThwI",
      2: "https://www.youtube.com/embed/QJ6Ys2YCAd0",
      3: "https://www.youtube.com/embed/-VuZmoc-Sq8",
      4: "https://www.youtube.com/embed/5k2-NOh2tk0",
      5: "https://www.youtube.com/embed/DMYgrv1mbUY",
      6: "https://www.youtube.com/embed/DaXQ5L7r7Lg",
      7: "https://www.youtube.com/embed/2aldTxnbNt0",
      8: "https://www.youtube.com/embed/x1VCmB__TDo",
      9: "https://www.youtube.com/embed/GFlFABWeqDc",
      10: "https://www.youtube.com/embed/gHB4JFG9i3k",
      11: "https://www.youtube.com/embed/9n8Gh4t5byE",
      12: "https://www.youtube.com/embed/uDIW34h8cmM",
      13: "https://www.youtube.com/embed/uDIW34h8cmM",
      14: "https://www.youtube.com/embed/xYU7zaaRjmE",
      15: "https://www.youtube.com/embed/mJwPvyc4-rk",
      16: "https://www.youtube.com/embed/CtvPiU3bSs4",
      17: "https://www.youtube.com/embed/Ec_3h5Q8RHY",
      18: "https://www.youtube.com/embed/rnFNwwwq1D8",
      19: "https://www.youtube.com/embed/h2a3Kw-I_Ec",
      20: "https://www.youtube.com/embed/NUELGzIHT-I",
      21: "https://www.youtube.com/embed/TPBd8If-ryQ",
      22: "https://www.youtube.com/embed/POej3uUl1Tc",
      23: "https://www.youtube.com/embed/cRQ2ybYxrVU",
      24: "https://www.youtube.com/embed/WXsD0ZgxjRw",
      25: "https://www.youtube.com/embed/G8Mk6lsSOcw",
      26: "https://www.youtube.com/embed/BpOsHF5Oj_I"
    };

    // Keep track of which lesson is the last lesson of each module
    const vibeLessonsByModule = {};
    for (let m = 1; m <= 13; m++) vibeLessonsByModule[m] = [];

    // Map and insert lessons
    for (const les of vibeLessonsParsed) {
      const lessonNum = les.num;
      const mNum = getVibeModuleNum(lessonNum);
      const modId = vibeModuleUUIDs[mNum];
      vibeLessonsByModule[mNum].push(les);
    }

    // Insert Vibe lessons, append activities, and seed quizzes
    for (let m = 1; m <= 13; m++) {
      const modLessons = vibeLessonsByModule[m];
      // Sort numerically by lesson number
      modLessons.sort((a, b) => a.num - b.num);
      
      for (let idx = 0; idx < modLessons.length; idx++) {
        const les = modLessons[idx];
        const isLastLessonOfModule = (idx === modLessons.length - 1);
        let finalBody = les.body;

        // If it is the last lesson, append Practical Activity and Nigerian Example
        if (isLastLessonOfModule) {
          const acts = getVibeActivities(m);
          finalBody += `\n\n### Module ${m} Practical Activity\n${acts.activity}\n\n### Nigerian Business Example\n${acts.nigerianExample}`;
        }

        const videoUrl = vibeVideos[les.num] || "";
        const orderIdx = idx + 1;

        await client.query(`
          INSERT INTO lessons (id, module_id, title, content, video_url, duration, order_index, is_preview, type)
          VALUES ($1, $2, $3, $4, $5, '15:00', $6, $7, 'video');
        `, [les.id, vibeModuleUUIDs[m], les.title, finalBody, videoUrl, orderIdx, les.num === 1 || les.num === 2]);

        // Insert Quizzes if last lesson of the module
        if (isLastLessonOfModule) {
          const quizzes = getVibeQuizzes(m, vibeModuleTitles[m-1]);
          for (let qIdx = 0; qIdx < quizzes.length; qIdx++) {
            const quiz = quizzes[qIdx];
            const qId = getDeterministicUUID(`vibe-quiz-${m}-${qIdx}`);
            await client.query(`
              INSERT INTO quiz_questions (id, lesson_id, question, options, correct_answer, explanation, order_index)
              VALUES ($1, $2, $3, $4, $5, $6, $7);
            `, [
              qId,
              les.id,
              quiz.question,
              JSON.stringify(quiz.options),
              quiz.correctIndex.toString(),
              quiz.explanation,
              qIdx + 1
            ]);
          }
        }
      }
    }
    console.log("Seeded all 26 Vibe Coding lessons, practical activities, and quizzes.");


    // ----------------------------------------------------
    // COURSE 2: FACEBOOK ADS
    // ----------------------------------------------------
    const fbCourseId = 'b2c3d4e5-f6a7-8901-bcde-f01234567891';
    console.log("\n--- Syncing Facebook Ads Course ---");

    // Clear old data
    await client.query("DELETE FROM modules WHERE course_id = $1;", [fbCourseId]);

    // Ensure Facebook Ads course is in courses table
    const fbCourseRes = await client.query("SELECT id FROM courses WHERE id = $1;", [fbCourseId]);
    if (fbCourseRes.rows.length === 0) {
      await client.query(`
        INSERT INTO courses (id, title, description, price, slug, level, category, duration)
        VALUES ($1, $2, $3, 8, $4, 'intermediate', 'Marketing', '6 weeks');
      `, [
        fbCourseId,
        'Facebook Ads Mastery',
        'Master the Facebook Ads auction system, pixel setup, CAPI signal, creative hooks, audience targeting, scaling rules, and client audit strategies.',
        'facebook-ads-mastery'
      ]);
      console.log("Inserted Facebook Ads course record.");
    }

    // Parse Facebook Ads lessons from file
    const fbCoursebookPath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/fbCoursebook.ts';
    const fbContent = fs.readFileSync(fbCoursebookPath, 'utf8');
    const fbLessonsParsed = parseLessonsFromTS(fbContent);
    console.log(`Parsed ${fbLessonsParsed.length} lessons from fbCoursebook.ts`);

    const fbModuleTitles = [
      "Foundations",
      "Account & Campaign Structure",
      "Audiences & Targeting",
      "Ad Creatives That Convert",
      "Funnels, Pages & Conversion Flow",
      "Budgeting, Testing & Optimization",
      "Scaling & Stability",
      "Real-World Facebook Ads Workflows",
      "AI & Facebook Ads",
      "Long-Term Mastery"
    ];

    // Mapping:
    // Module 1: 1, 2, 3
    // Module 2: 4, 5, 6
    // Module 3: 7, 8, 9
    // Module 4: 10, 11, 12
    // Module 5: 13, 14, 15
    // Module 6: 16, 17, 18
    // Module 7: 19, 20
    // Module 8: 21, 22, 23
    // Module 9: 24, 25
    // Module 10: 26
    const getFbModuleNum = (lessonNum) => {
      if (lessonNum >= 1 && lessonNum <= 3) return 1;
      if (lessonNum >= 4 && lessonNum <= 6) return 2;
      if (lessonNum >= 7 && lessonNum <= 9) return 3;
      if (lessonNum >= 10 && lessonNum <= 12) return 4;
      if (lessonNum >= 13 && lessonNum <= 15) return 5;
      if (lessonNum >= 16 && lessonNum <= 18) return 6;
      if (lessonNum === 19 || lessonNum === 20) return 7;
      if (lessonNum >= 21 && lessonNum <= 23) return 8;
      if (lessonNum === 24 || lessonNum === 25) return 9;
      if (lessonNum === 26) return 10;
      return 1;
    };

    // Insert modules and get their UUIDs
    const fbModuleUUIDs = {};
    for (let m = 1; m <= 10; m++) {
      const mTitle = `Module ${m}: ${fbModuleTitles[m-1]}`;
      const mId = getDeterministicUUID(`fb-mod-${m}`);
      await client.query(`
        INSERT INTO modules (id, course_id, title, order_index)
        VALUES ($1, $2, $3, $4);
      `, [mId, fbCourseId, mTitle, m]);
      fbModuleUUIDs[m] = mId;
    }
    console.log("Inserted 10 Facebook Ads modules.");

    // Video URL mappings from invisibleCourseEngine.ts
    const fbVideos = {
      1: "https://www.youtube.com/embed/a-YinGgU_3E",
      2: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      3: "https://www.youtube.com/embed/a-YinGgU_3E",
      4: "https://www.youtube.com/embed/cCRQc0O0uUI",
      5: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      6: "https://www.youtube.com/embed/cCRQc0O0uUI",
      7: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      8: "https://www.youtube.com/embed/a-YinGgU_3E",
      9: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      10: "https://www.youtube.com/embed/cCRQc0O0uUI",
      11: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      12: "https://www.youtube.com/embed/a-YinGgU_3E",
      13: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      14: "https://www.youtube.com/embed/cCRQc0O0uUI",
      15: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      16: "https://www.youtube.com/embed/a-YinGgU_3E",
      17: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      18: "https://www.youtube.com/embed/cCRQc0O0uUI",
      19: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      20: "https://www.youtube.com/embed/a-YinGgU_3E",
      21: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      22: "https://www.youtube.com/embed/cCRQc0O0uUI",
      23: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      24: "https://www.youtube.com/embed/a-YinGgU_3E",
      25: "https://www.youtube.com/embed/5H7hD6p5Ceg",
      26: "https://www.youtube.com/embed/cCRQc0O0uUI"
    };

    const fbLessonsByModule = {};
    for (let m = 1; m <= 10; m++) fbLessonsByModule[m] = [];

    for (const les of fbLessonsParsed) {
      const lessonNum = les.num;
      const mNum = getFbModuleNum(lessonNum);
      fbLessonsByModule[mNum].push(les);
    }

    for (let m = 1; m <= 10; m++) {
      const modLessons = fbLessonsByModule[m];
      modLessons.sort((a, b) => a.num - b.num);

      for (let idx = 0; idx < modLessons.length; idx++) {
        const les = modLessons[idx];
        const isLastLessonOfModule = (idx === modLessons.length - 1);
        let finalBody = les.body;

        if (isLastLessonOfModule) {
          const acts = getFbActivities(m);
          finalBody += `\n\n### Module ${m} Practical Activity\n${acts.activity}\n\n### Nigerian Business Example\n${acts.nigerianExample}`;
        }

        const videoUrl = fbVideos[les.num] || "";
        const orderIdx = idx + 1;

        await client.query(`
          INSERT INTO lessons (id, module_id, title, content, video_url, duration, order_index, is_preview, type)
          VALUES ($1, $2, $3, $4, $5, '15:00', $6, $7, 'video');
        `, [les.id, fbModuleUUIDs[m], les.title, finalBody, videoUrl, orderIdx, les.num === 1 || les.num === 2]);

        if (isLastLessonOfModule) {
          const quizzes = getFbQuizzes(m, fbModuleTitles[m-1]);
          for (let qIdx = 0; qIdx < quizzes.length; qIdx++) {
            const quiz = quizzes[qIdx];
            const qId = getDeterministicUUID(`fb-quiz-${m}-${qIdx}`);
            await client.query(`
              INSERT INTO quiz_questions (id, lesson_id, question, options, correct_answer, explanation, order_index)
              VALUES ($1, $2, $3, $4, $5, $6, $7);
            `, [
              qId,
              les.id,
              quiz.question,
              JSON.stringify(quiz.options),
              quiz.correctIndex.toString(),
              quiz.explanation,
              qIdx + 1
            ]);
          }
        }
      }
    }
    console.log("Seeded all 26 Facebook Ads lessons, practical activities, and quizzes.");


    // ----------------------------------------------------
    // COURSE 3: PROMPT ENGINEERING (CUSTOM)
    // ----------------------------------------------------
    const promptCourseId = 'c3d4e5f6-a7b8-9012-cdef-012345678913';
    console.log("\n--- Syncing Prompt Engineering Mastery Course ---");

    // Clear old data for custom Prompt Engineering course
    await client.query("DELETE FROM modules WHERE course_id = $1;", [promptCourseId]);
    await client.query("DELETE FROM courses WHERE id = $1;", [promptCourseId]);

    // Insert new course record
    await client.query(`
      INSERT INTO courses (id, title, description, price, slug, level, category, duration)
      VALUES ($1, $2, $3, 10, $4, 'advanced', 'Development', '4 weeks');
    `, [
      promptCourseId,
      'Prompt Engineering Mastery',
      'Master persona rules, layered context, Few-Shot formats, Chain-of-Thought, Temperature parameters, and agent guardrails.',
      'prompt-engineering-mastery'
    ]);
    console.log("Inserted custom Prompt Engineering course record.");

    // Parse Prompt Engineering lessons from file
    const promptCoursebookPath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/promptCoursebook.ts';
    const promptContent = fs.readFileSync(promptCoursebookPath, 'utf8');
    const promptLessonsParsed = parseLessonsFromTS(promptContent);
    console.log(`Parsed ${promptLessonsParsed.length} lessons from promptCoursebook.ts`);

    const promptModuleTitles = [
      "Foundations of Prompting",
      "Prompt Engineering Core components",
      "Prompt Engineering Techniques",
      "Parameters & Model Controls",
      "Advanced Logic & Reasoning",
      "Prompt Optimization",
      "Advanced Applications",
      "Designing Premium Systems"
    ];

    // Mapping:
    // Module 1: 1, 2, 3, 21 (Case study)
    // Module 2: 4, 5, 6, 22
    // Module 3: 7, 8, 23
    // Module 4: 9, 10, 24
    // Module 5: 11, 12, 13, 25
    // Module 6: 14, 15, 16, 26
    // Module 7: 17, 18, 19, 27
    // Module 8: 20
    const getPromptModuleNum = (lessonNum) => {
      if (lessonNum === 1 || lessonNum === 2 || lessonNum === 3 || lessonNum === 21) return 1;
      if (lessonNum === 4 || lessonNum === 5 || lessonNum === 6 || lessonNum === 22) return 2;
      if (lessonNum === 7 || lessonNum === 8 || lessonNum === 23) return 3;
      if (lessonNum === 9 || lessonNum === 10 || lessonNum === 24) return 4;
      if (lessonNum === 11 || lessonNum === 12 || lessonNum === 13 || lessonNum === 25) return 5;
      if (lessonNum === 14 || lessonNum === 15 || lessonNum === 16 || lessonNum === 26) return 6;
      if (lessonNum === 17 || lessonNum === 18 || lessonNum === 19 || lessonNum === 27) return 7;
      if (lessonNum === 20) return 8;
      return 1;
    };

    // Insert modules and get their UUIDs
    const promptModuleUUIDs = {};
    for (let m = 1; m <= 8; m++) {
      const mTitle = `Module ${m}: ${promptModuleTitles[m-1]}`;
      const mId = getDeterministicUUID(`prompt-mod-${m}`);
      await client.query(`
        INSERT INTO modules (id, course_id, title, order_index)
        VALUES ($1, $2, $3, $4);
      `, [mId, promptCourseId, mTitle, m]);
      promptModuleUUIDs[m] = mId;
    }
    console.log("Inserted 8 Prompt Engineering modules.");

    // Video mappings (from promptCoursebook.ts PROMPT_ENG_LESSON_VIDEOS mapping)
    const promptVideos = {
      1: "https://www.youtube.com/embed/dOxUroR_sGc",
      2: "https://www.youtube.com/embed/7xTGNNLPyMI",
      3: "https://www.youtube.com/embed/dOxUroR_sGc",
      4: "https://www.youtube.com/embed/BUdwDOLQVWc",
      5: "https://www.youtube.com/embed/SpazTFm-e_8",
      6: "https://www.youtube.com/embed/I1MEiaG0vW4",
      7: "https://www.youtube.com/embed/9qdgEBVkWR4",
      8: "https://www.youtube.com/embed/L_Cg39V89rY",
      9: "https://www.youtube.com/embed/7xTGNNLPyMI",
      10: "https://www.youtube.com/embed/w_uL1sS7n6Y",
      11: "https://www.youtube.com/embed/BUdwDOLQVWc",
      12: "https://www.youtube.com/embed/SpazTFm-e_8",
      13: "https://www.youtube.com/embed/I1MEiaG0vW4",
      14: "https://www.youtube.com/embed/w_uL1sS7n6Y",
      15: "https://www.youtube.com/embed/L_Cg39V89rY",
      16: "https://www.youtube.com/embed/dOxUroR_sGc",
      17: "https://www.youtube.com/embed/BUdwDOLQVWc",
      18: "https://www.youtube.com/embed/SpazTFm-e_8",
      19: "https://www.youtube.com/embed/I1MEiaG0vW4",
      20: "https://www.youtube.com/embed/BUdwDOLQVWc",
      21: "https://www.youtube.com/embed/dOxUroR_sGc",
      22: "https://www.youtube.com/embed/BUdwDOLQVWc",
      23: "https://www.youtube.com/embed/9qdgEBVkWR4",
      24: "https://www.youtube.com/embed/w_uL1sS7n6Y",
      25: "https://www.youtube.com/embed/BUdwDOLQVWc",
      26: "https://www.youtube.com/embed/dOxUroR_sGc",
      27: "https://www.youtube.com/embed/BUdwDOLQVWc"
    };

    const promptLessonsByModule = {};
    for (let m = 1; m <= 8; m++) promptLessonsByModule[m] = [];

    for (const les of promptLessonsParsed) {
      const lessonNum = les.num;
      const mNum = getPromptModuleNum(lessonNum);
      promptLessonsByModule[mNum].push(les);
    }

    for (let m = 1; m <= 8; m++) {
      const modLessons = promptLessonsByModule[m];
      // Custom sort: put case studies (nums 21-27) at the end, and standard lessons (nums 1-20) in order
      modLessons.sort((a, b) => {
        const aIsCase = a.num >= 21;
        const bIsCase = b.num >= 21;
        if (aIsCase && !bIsCase) return 1;
        if (!aIsCase && bIsCase) return -1;
        return a.num - b.num;
      });

      for (let idx = 0; idx < modLessons.length; idx++) {
        const les = modLessons[idx];
        const isLastLessonOfModule = (idx === modLessons.length - 1);
        let finalBody = les.body;

        if (isLastLessonOfModule) {
          const acts = getPromptActivities(m);
          finalBody += `\n\n### Module ${m} Practical Activity\n${acts.activity}\n\n### Nigerian Business Example\n${acts.nigerianExample}`;
        }

        const videoUrl = promptVideos[les.num] || "";
        const orderIdx = idx + 1;

        await client.query(`
          INSERT INTO lessons (id, module_id, title, content, video_url, duration, order_index, is_preview, type)
          VALUES ($1, $2, $3, $4, $5, '15:00', $6, $7, 'video');
        `, [les.id, promptModuleUUIDs[m], les.title, finalBody, videoUrl, orderIdx, les.num === 1 || les.num === 2]);

        if (isLastLessonOfModule) {
          const quizzes = getPromptQuizzes(m, promptModuleTitles[m-1]);
          for (let qIdx = 0; qIdx < quizzes.length; qIdx++) {
            const quiz = quizzes[qIdx];
            const qId = getDeterministicUUID(`prompt-quiz-${m}-${qIdx}`);
            await client.query(`
              INSERT INTO quiz_questions (id, lesson_id, question, options, correct_answer, explanation, order_index)
              VALUES ($1, $2, $3, $4, $5, $6, $7);
            `, [
              qId,
              les.id,
              quiz.question,
              JSON.stringify(quiz.options),
              quiz.correctIndex.toString(),
              quiz.explanation,
              qIdx + 1
            ]);
          }
        }
      }
    }
    console.log("Seeded all 27 Prompt Engineering lessons, practical activities, and quizzes.");


    // ----------------------------------------------------
    // COMMIT & SYNC FRONTEND MOCKDATA.TS
    // ----------------------------------------------------
    await client.query("COMMIT;");
    console.log("\nDatabase transaction committed successfully!");

    // Now, let's load all data from database to write a 100% accurate mockData.ts file
    console.log("\n--- Synchronizing Frontend mockData.ts ---");
    await generateMockDataFile();

  } catch (e) {
    await client.query("ROLLBACK;");
    console.error("Database seeding failed. Transaction rolled back.", e);
  } finally {
    await client.end();
  }
}

// ----------------------------------------------------
// UTILITIES FOR PARSING AND SERIALIZING
// ----------------------------------------------------

function parseLessonsFromTS(fileContent) {
  const lines = fileContent.split('\n');
  let currentModule = 0;
  const lessons = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const modMatch = line.match(/\/\/ === MODULE (\d+) ===/i);
    if (modMatch) {
      currentModule = parseInt(modMatch[1], 10);
    }
    
    const keyMatch = line.match(/"([^"]+)":\s*`/);
    if (keyMatch) {
      const key = keyMatch[1];
      const num = parseInt(key.split('-').pop(), 10); // Extract lesson number from key ending
      
      let bodyLines = [];
      let j = i;
      let firstLineOfBody = lines[j].substring(lines[j].indexOf('`') + 1);
      bodyLines.push(firstLineOfBody);
      j++;
      while (j < lines.length && !lines[j].includes('`')) {
        bodyLines.push(lines[j]);
        j++;
      }
      if (j < lines.length) {
        const lastLine = lines[j].substring(0, lines[j].indexOf('`'));
        bodyLines.push(lastLine);
      }
      
      const body = bodyLines.join('\n');
      const headerMatch = body.match(/###\s+(.+)/);
      let title = headerMatch ? headerMatch[1].trim() : `Lesson ${num}`;
      
      // Clean title from custom headers or casing
      if (title.startsWith("Lesson ")) {
        title = title.substring(title.indexOf(':') + 1).trim();
      }
      
      lessons.push({
        id: key,
        num: num,
        moduleNum: currentModule,
        title: title,
        body: body
      });
    }
  }
  return lessons;
}

async function generateMockDataFile() {
  const dbClient = new Client({
    host: '108.128.216.176',
    port: 6543,
    user: 'postgres.doyrfbndzpcarfkulbhe',
    password: 'C7gbLy2bXp0mvcfOAsInZm',
    database: 'postgres',
    ssl: {
      rejectUnauthorized: false,
      servername: 'aws-0-eu-west-1.pooler.supabase.com'
    }
  });

  await dbClient.connect();

  // 1. Fetch all courses
  const coursesRes = await dbClient.query('SELECT * FROM courses ORDER BY title;');
  const courses = coursesRes.rows;

  const mockDataCourses = [];

  for (const course of courses) {
    // If it's one of the Microsoft courses, skip because they are spread from microsoftCoursesData
    if ([
      '8465492d-9477-4b72-875f-2c3f8f117c49', // AI
      'bc2d4420-7988-4389-91ee-325b3069cf72', // ML
      'e0970a25-e51c-43df-9e26-bc94c34d115d', // GenAI
      '5d7a0491-b3b3-4613-888e-73130d22abf2', // DataScience
      '133f925b-381a-464a-a22c-7389c90f5c9e'  // WebDev
    ].includes(course.id)) {
      continue;
    }

    console.log(`Formatting course ${course.title} for mockData.ts...`);

    // Fetch modules
    const modulesRes = await dbClient.query('SELECT * FROM modules WHERE course_id = $1 ORDER BY order_index;', [course.id]);
    const modules = modulesRes.rows;

    const sections = [];

    for (const mod of modules) {
      // Fetch lessons
      const lessonsRes = await dbClient.query('SELECT * FROM lessons WHERE module_id = $1 ORDER BY order_index;', [mod.id]);
      const lessons = lessonsRes.rows;

      const lectures = [];

      for (const les of lessons) {
        // Fetch quiz questions
        const quizRes = await dbClient.query('SELECT * FROM quiz_questions WHERE lesson_id = $1 ORDER BY order_index;', [les.id]);
        const quizQuestions = quizRes.rows.map(q => ({
          id: q.id,
          question: q.question,
          options: q.options,
          correctIndex: parseInt(q.correct_answer, 10) || 0,
          explanation: q.explanation || ""
        }));

        lectures.push({
          id: les.id,
          title: les.title,
          duration: les.duration || '15:00',
          type: les.type || 'video',
          isPreview: les.is_preview || false,
          body: les.content || "",
          videoUrl: les.video_url || "",
          ...(quizQuestions.length > 0 ? { quizQuestions } : {})
        });
      }

      sections.push({
        id: mod.id,
        title: mod.title,
        lectures: lectures
      });
    }

    // Map DB course columns to mockData.ts Course interface
    // Vibe Coding tags
    let tags = ["Development", "AI"];
    if (course.id === 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') {
      tags = ["Vibe Coding", "AI", "Prompt Engineering", "Cursor", "Lovable"];
    } else if (course.id === 'b2c3d4e5-f6a7-8901-bcde-f01234567891') {
      tags = ["Marketing", "Facebook Ads", "Instagram Ads", "Scaling", "Paid Ads"];
    } else if (course.id === 'c3d4e5f6-a7b8-9012-cdef-012345678912') {
      tags = ["AI", "Prompt Engineering", "LLMs", "Reasoning"];
    } else if (course.id === 'c3d4e5f6-a7b8-9012-cdef-012345678913') {
      tags = ["AI", "Prompt Engineering", "Context Engineering", "Enterprise Systems"];
    }

    mockDataCourses.push({
      id: course.id,
      title: course.title,
      subtitle: course.subtitle || "",
      instructor: course.instructor || "Akinola Olujobi",
      instructorAvatar: "",
      thumbnail: course.id === 'b2c3d4e5-f6a7-8901-bcde-f01234567891' ? 'course-facebook-ads' : 
                 (course.id === 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' ? 'course-vibe-coding' : 'course-prompt-engineering'),
      price: parseFloat(course.price) || 10,
      originalPrice: course.id === 'b2c3d4e5-f6a7-8901-bcde-f01234567891' ? 79.99 : 84.99,
      rating: course.id === 'c3d4e5f6-a7b8-9012-cdef-012345678912' ? 4.9 : 4.8,
      reviewCount: course.id === 'c3d4e5f6-a7b8-9012-cdef-012345678912' ? 128 : 12,
      enrollmentCount: course.id === 'c3d4e5f6-a7b8-9012-cdef-012345678912' ? 1420 : 20,
      level: course.level ? (course.level.charAt(0).toUpperCase() + course.level.slice(1)) : "Beginner",
      category: course.category || "Development",
      subcategory: course.subcategory || "AI Development",
      language: "English",
      duration: course.duration || "4 weeks",
      lectureCount: sections.reduce((sum, s) => sum + s.lectures.length, 0),
      lastUpdated: "July 2026",
      bestseller: course.bestseller || false,
      description: course.description || "",
      tags: tags,
      sections: sections
    });
  }

  await dbClient.end();

  // Create mockData.ts source code
  const mockDataFilePath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/mockData.ts';
  const fileContent = `import { microsoftCourses } from "./microsoftCoursesData";
export interface Lecture {
  id: string;
  title: string;
  duration: string;
  type: "video" | "text" | "quiz";
  isPreview?: boolean;
  body?: string;
  videoUrl?: string;
  quizQuestions?: QuizQuestion[];
}

export interface QuizQuestion {
  id: string;
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

export interface CourseSection {
  id: string;
  title: string;
  lectures: Lecture[];
}

export interface Course {
  id: string;
  title: string;
  subtitle: string;
  instructor: string;
  instructorAvatar: string;
  thumbnail: string;
  price: number;
  originalPrice?: number;
  rating: number;
  reviewCount: number;
  enrollmentCount: number;
  level: "Beginner" | "Intermediate" | "Advanced";
  category: string;
  subcategory: string;
  language: string;
  duration: string;
  lectureCount: number;
  lastUpdated: string;
  bestseller?: boolean;
  description: string;
  tags: string[];
  sections?: CourseSection[];
}

export interface Category {
  id: string;
  name: string;
  icon: string;
  courseCount: number;
}

export const categories: Category[] = [
  { id: "1", name: "Development", icon: "Code", courseCount: 3 },
  { id: "2", name: "Marketing", icon: "Megaphone", courseCount: 1 },
];

export const courses: Course[] = ${JSON.stringify(mockDataCourses, null, 2).replace(/\]$/, ',\n  ...microsoftCourses\n]')};

export const stats = [
  { label: "Students Enrolled", value: "15,000+" },
  { label: "Expert Instructors", value: "12" },
  { label: "Courses Available", value: "9" },
  { label: "Success Rate", value: "94%" },
];
`;

  fs.writeFileSync(mockDataFilePath, fileContent, 'utf8');
  console.log("Successfully wrote mockData.ts!");
}

// Run seeder
syncCourses().catch(console.error);
