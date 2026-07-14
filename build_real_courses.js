const fs = require('fs');
const path = require('path');

const academyPath = "C:\\Users\\Akinola Olujobi\\Documents\\Trendtactics Academy";
const targetFile = "C:\\Users\\Akinola Olujobi\\Documents\\Trendtactics Academy\\lms-frontend\\src\\data\\realCourses.ts";

// 1. Process Vibe Coding
console.log("Loading Vibe Coding course...");
const vibeRaw = fs.readFileSync(path.join(academyPath, "vibe-coding-course.json"), 'utf8');
const vibeLessons = JSON.parse(vibeRaw);

vibeLessons.sort((a, b) => a.lesson_number - b.lesson_number);

const mappedVibeLessons = vibeLessons.map((item) => {
  // Extract videoUrl
  let videoUrl = "";
  if (item.resources && item.resources.video && item.resources.video.url) {
    videoUrl = item.resources.video.url;
  } else if (item.resources && item.resources.video_url) {
    videoUrl = item.resources.video_url;
  }
  
  // Extract duration
  let duration = 30;
  if (item.resources && item.resources.duration) {
    const match = item.resources.duration.match(/(\d+)/);
    if (match) duration = parseInt(match[1], 10);
  } else if (item.duration) {
    const match = item.duration.match(/(\d+)/);
    if (match) duration = parseInt(match[1], 10);
  }

  // Vibe Coding has open Q&A pairs (no MCQ options). We append them to the content markdown
  // instead of rendering a broken MCQ quiz, and set quiz to empty array.
  let knowledgeCheckMarkdown = "";
  if (item.quiz && item.quiz.questions && item.quiz.questions.length > 0) {
    knowledgeCheckMarkdown = "\n\n### 📝 Knowledge Check\n\nReview the following study questions to check your understanding of the concepts in this lesson:\n";
    item.quiz.questions.forEach((q, qidx) => {
      const correctAns = item.quiz.answers ? item.quiz.answers[qidx] : "";
      knowledgeCheckMarkdown += `\n**Q: ${q}**\n*Answer: ${correctAns}*\n`;
    });
  }

  // Content concatenation
  const content = `### Big Idea\n${item.big_idea || ''}\n\n### Example\n${item.example || ''}\n\n### Practical Application\n${item.playground_activity || ''}\n\n### Reflection\n${item.reflection_question || ''}${knowledgeCheckMarkdown}`;

  return {
    id: `vibe-lesson-${item.lesson_number}`,
    title: item.lesson_title,
    description: item.introduction || item.big_idea || '',
    videoUrl: videoUrl,
    content: content,
    duration: duration,
    order: item.lesson_number,
    quiz: [] // Genuinely has no MCQ options
  };
});

// 2. Process Facebook Ads
console.log("Loading Facebook Ads course...");
const fbRaw = fs.readFileSync(path.join(academyPath, "facebook-ads-course.json.bak"), 'utf8');
const fbLessons = JSON.parse(fbRaw);

fbLessons.sort((a, b) => a.lesson_number - b.lesson_number);

const mappedFbLessons = fbLessons.map((item) => {
  let videoUrl = "";
  if (item.resources && item.resources.video && item.resources.video.url) {
    videoUrl = item.resources.video.url;
  } else if (item.resources && item.resources.video_url) {
    videoUrl = item.resources.video_url;
  }

  let duration = 30;
  if (item.resources && item.resources.duration) {
    const match = item.resources.duration.match(/(\d+)/);
    if (match) duration = parseInt(match[1], 10);
  }

  // Map Facebook Ads MCQ Quizzes properly
  let quizQuestions = [];
  if (item.quiz && item.quiz.questions) {
    quizQuestions = item.quiz.questions.map((q, qidx) => {
      const correctAns = item.quiz.answers ? item.quiz.answers[qidx] : "";
      const opts = item.quiz.options && item.quiz.options[qidx] ? item.quiz.options[qidx] : [correctAns];
      
      const trimmedOpts = opts.map(o => o.trim());
      const trimmedAnswer = correctAns.trim();
      
      let correctIdx = trimmedOpts.indexOf(trimmedAnswer);
      if (correctIdx === -1) {
        correctIdx = trimmedOpts.findIndex(o => o.toLowerCase() === trimmedAnswer.toLowerCase());
        if (correctIdx === -1) {
          correctIdx = 0;
          opts[0] = correctAns;
        }
      }
      
      return {
        question: q,
        options: opts,
        correctAnswer: correctIdx,
        explanation: correctAns
      };
    });
  }

  const content = `### Core Concept\n${item.core_concept || ''}\n\n### Why It Matters\n${item.why_it_matters || ''}\n\n### Practical Examples\n${item.practical_examples || ''}\n\n### Actionable Takeaway\n${item.actionable_takeaway || ''}\n\n### Common Mistakes\n${item.common_mistakes || ''}`;

  return {
    id: `fb-lesson-${item.lesson_number}`,
    title: item.lesson_title,
    description: item.introduction || item.core_concept || '',
    videoUrl: videoUrl,
    content: content,
    duration: duration,
    order: item.lesson_number,
    quiz: quizQuestions
  };
});

// 3. Process Prompt Engineering
console.log("Loading Prompt Engineering course...");
const peDataPath = path.join(academyPath, "src", "data");
const peFiles = fs.readdirSync(peDataPath).filter(f => f.startsWith("prompt-eng-lesson-") && f.endsWith(".json"));
const peLessons = [];

peFiles.forEach(file => {
  const content = fs.readFileSync(path.join(peDataPath, file), 'utf8');
  peLessons.push(JSON.parse(content));
});

peLessons.sort((a, b) => a.lesson_number - b.lesson_number);

const mappedPeLessons = peLessons.map((item) => {
  let videoUrl = "";
  if (item.resources && item.resources.video && item.resources.video.url) {
    videoUrl = item.resources.video.url;
  }

  let duration = 30;
  if (item.resources && item.resources.duration) {
    const match = item.resources.duration.match(/(\d+)/);
    if (match) duration = parseInt(match[1], 10);
  }

  // Map Prompt Engineering MCQ Quizzes properly
  let quizQuestions = [];
  if (item.quiz && item.quiz.questions) {
    quizQuestions = item.quiz.questions.map((q, qidx) => {
      const correctAns = item.quiz.answers ? item.quiz.answers[qidx] : "";
      const opts = item.quiz.options && item.quiz.options[qidx] ? item.quiz.options[qidx] : [correctAns];
      
      const trimmedOpts = opts.map(o => o.trim());
      const trimmedAnswer = correctAns.trim();
      
      let correctIdx = trimmedOpts.indexOf(trimmedAnswer);
      if (correctIdx === -1) {
        correctIdx = trimmedOpts.findIndex(o => o.toLowerCase() === trimmedAnswer.toLowerCase());
        if (correctIdx === -1) {
          correctIdx = 0;
          opts[0] = correctAns;
        }
      }
      
      return {
        question: q,
        options: opts,
        correctAnswer: correctIdx,
        explanation: correctAns
      };
    });
  }

  const content = `### Core Concept\n${item.core_concepts || ''}\n\n### Why It Matters\n${item.why_it_matters || ''}\n\n### Real-World Example\n${item.real_world_example || ''}\n\n### Key Takeaways\n${item.key_takeaways || ''}`;

  return {
    id: `pe-lesson-${item.lesson_number}`,
    title: item.lesson_title,
    description: item.introduction || item.big_idea || '',
    videoUrl: videoUrl,
    content: content,
    duration: duration,
    order: item.lesson_number,
    quiz: quizQuestions
  };
});

// Construct the 3 Course objects (using 0 enrolled students and 0 rating)
console.log("Constructing Course objects...");
const realCourses = [
  {
    id: 'vibe-coding',
    title: 'Vibe Coding: Building Real Software with AI',
    description: 'Learn the revolutionary approach of creating digital products by focusing on ideas, creativity, and direction using AI, without traditional syntax barriers.',
    instructor: {
      _id: 'inst-1',
      name: 'Akinola Olujobi',
      email: 'akinola@trendtacticsdigital.com',
      role: 'instructor',
      createdAt: '2026-01-10T12:00:00Z',
      updatedAt: '2026-01-10T12:00:00Z'
    },
    thumbnail: 'https://images.unsplash.com/photo-1618401471353-b98aedd07871?w=800&auto=format&fit=crop&q=60',
    price: 10,
    duration: '8 weeks',
    level: 'beginner',
    category: 'AI & Software Development',
    lessons: mappedVibeLessons,
    enrolledStudents: 0, 
    rating: 0.0, 
    createdAt: '2026-01-10T12:00:00Z',
    topics: ['AI Software Builders', 'Cursor & Windsurf', 'Bolt.new & Lovable', 'Autonomous Agents', 'Prompting for Code', 'Product Deployment']
  },
  {
    id: 'facebook-ads',
    title: 'Facebook Ads: Building Profitable, Predictable Ad Systems',
    description: 'Master the mechanics of Facebook advertising, campaign structure, pixel setups, scaling budgets, and building high-converting ad funnels.',
    instructor: {
      _id: 'inst-1',
      name: 'Akinola Olujobi',
      email: 'akinola@trendtacticsdigital.com',
      role: 'instructor',
      createdAt: '2026-01-10T12:00:00Z',
      updatedAt: '2026-01-10T12:00:00Z'
    },
    thumbnail: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800&auto=format&fit=crop&q=60',
    price: 8,
    duration: '6 weeks',
    level: 'intermediate',
    category: 'Digital Marketing',
    lessons: mappedFbLessons,
    enrolledStudents: 0, 
    rating: 0.0, 
    createdAt: '2026-01-10T12:00:00Z',
    topics: ['Ad Auction Mechanics', 'Account Architecture', 'Campaign Objective Alignment', 'Audience Targeting', 'Budget Optimization', 'Scale Strategy']
  },
  {
    id: 'prompt-engineering',
    title: 'Prompt Engineering: Designing Instructions That Control AI Systems',
    description: 'Become an expert in instructing large language models. Learn core prompt structures, context layering, constraints, guardrails, and advanced workflow controls.',
    instructor: {
      _id: 'inst-1',
      name: 'Akinola Olujobi',
      email: 'akinola@trendtacticsdigital.com',
      role: 'instructor',
      createdAt: '2026-01-10T12:00:00Z',
      updatedAt: '2026-01-10T12:00:00Z'
    },
    thumbnail: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=800&auto=format&fit=crop&q=60',
    price: 10,
    duration: '6 weeks',
    level: 'beginner',
    category: 'AI & Machine Learning',
    lessons: mappedPeLessons,
    enrolledStudents: 0, 
    rating: 0.0, 
    createdAt: '2026-01-10T12:00:00Z',
    topics: ['Prompt Structures', 'Context Layering', 'Constraints & Guardrails', 'System Instructions', 'Few-shot Prompting', 'Chain of Thought']
  }
];

// Write to realCourses.ts file
console.log("Writing to realCourses.ts...");

const fileHeader = `import { Course } from '../types';

`;

// Convert structure to JSON
let jsonString = JSON.stringify(realCourses, null, 2);

// ONLY replace Course-level createdAt (which has 4 spaces of indentation)
// e.g.     "createdAt": "2026-01-10T12:00:00Z" -> "createdAt": new Date("2026-01-10T12:00:00Z")
jsonString = jsonString.replace(/\n    "createdAt": "([^"]+)"/g, '\n    "createdAt": new Date("$1")');

const tsContent = `${fileHeader}export const realCourses: Course[] = ${jsonString};
`;

fs.writeFileSync(targetFile, tsContent, 'utf8');
console.log("File written successfully!");
