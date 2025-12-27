// Vibe Coding Course Generation System
// This script generates the complete Vibe Coding course following the required structure

const fs = require('fs');
const path = require('path');

// Course structure as defined in the requirements
const courseStructure = [
  {
    module: "Understanding Vibe Coding",
    lessons: [
      "What Is Vibe Coding?",
      "Why Vibe Coding Exists",
      "How Vibe Coding Is Different from Traditional Coding"
    ]
  },
  {
    module: "Thinking Before Coding",
    lessons: [
      "Learning to Think in Ideas, Not Code",
      "Turning Simple Ideas into Digital Instructions",
      "Understanding Intent in Vibe Coding"
    ]
  },
  {
    module: "Working with AI as a Creative Partner",
    lessons: [
      "What AI Really Is (In Simple Terms)",
      "How AI Helps in Vibe Coding",
      "Talking to AI Clearly and Effectively"
    ]
  },
  {
    module: "Vibe Coding in Real Life",
    lessons: [
      "Real Examples of Vibe Coding",
      "Building Simple Things Without Fear",
      "Common Beginner Mistakes and How to Avoid Them"
    ]
  },
  {
    module: "Exploring and Building with Confidence",
    lessons: [
      "Using a Playground to Experiment Safely",
      "Improving Your Ideas Step by Step",
      "Your First Complete Vibe-Coded Project"
    ]
  }
];

// Generate lesson template
function generateLesson(courseTitle, moduleTitle, lessonNumber, lessonTitle) {
  // Template for lessons after the first one
  if (lessonNumber === 1) {
    // This is the first lesson which was already created
    return {
      "course_title": "Vibe Coding",
      "module_title": "Understanding Vibe Coding",
      "lesson_number": 1,
      "lesson_title": "What Is Vibe Coding?",
      "introduction": "Welcome to your first lesson in Vibe Coding! Don't worry if you've never coded before - this is completely normal. In this lesson, we'll explore what Vibe Coding is and why it's different from traditional approaches. By the end of this lesson, you'll have a clear understanding of what makes Vibe Coding special and why it's perfect for beginners.",
      "big_idea": "Vibe Coding is a beginner-friendly way of creating digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing syntax or complex technical rules. It's about understanding concepts first, then building with confidence.",
      "visuals": "Create a large, friendly card with a light blue background showing a person having an idea (lightbulb icon) next to a computer screen with simple, colorful shapes being created. Include a connecting arrow showing the idea flowing into the digital creation. Add a smaller card below with two columns: one labeled 'Traditional Coding' (showing complex code symbols and a stressed face) and another labeled 'Vibe Coding' (showing simple icons and a smiling face).",
      "steps": [
        "Step 1: Understand that coding is simply a way to tell computers what to do",
        "Step 2: Recognize that Vibe Coding focuses on ideas before technical details",
        "Step 3: Learn that Vibe Coding uses AI and guidance to make creation easier",
        "Step 4: See that Vibe Coding avoids complex syntax and technical rules initially",
        "Step 5: Appreciate that Vibe Coding builds confidence before complexity"
      ],
      "example": "Think of Vibe Coding like cooking with a recipe app that guides you step by step. Instead of memorizing all the cooking techniques first, the app tells you exactly what to do at each moment. Similarly, Vibe Coding uses AI and guidance to help you create digital products without needing to memorize all the technical rules upfront.",
      "playground_activity": "In the playground section, create a simple drag-and-drop activity where students can move idea cards (like 'I want a website to show my photos' or 'I need an app to track my tasks') to a 'Digital Creation' box. As they move each idea, a simple visual representation appears showing how that idea could become a real digital product. No code required - just visual representation of the connection between ideas and digital creation.",
      "reflection_question": "Think about a digital product you use every day (like a weather app, social media, or a game). How might someone have created this using Vibe Coding principles - focusing on the main idea first rather than complex technical details?",
      "quiz": {
        "questions": [
          "What does Vibe Coding focus on first?",
          "Is Vibe Coding designed for beginners?",
          "Does Vibe Coding emphasize memorizing syntax first?",
          "What does Vibe Coding use to make creation easier?",
          "What is the main goal of Vibe Coding?"
        ],
        "answers": [
          "Ideas, intention, creativity, and guidance",
          "Yes, it's specifically designed for beginners",
          "No, it avoids complex syntax initially",
          "AI and guidance",
          "To make digital creation accessible and confidence-building for beginners"
        ]
      },
      "resources": {
        "video": {
          "title": "What is Creative Coding? (Beginner Friendly)",
          "creator": "CodeNewbie",
          "embed": true,
          "reason": "Simple explanation of creative approaches to coding that aligns with Vibe Coding principles"
        },
        "extra_reading": [
          "https://example.com/creative-coding-intro - Introduction to Creative Approaches to Programming",
          "https://example.com/beginner-programming-mindset - Building Confidence in Programming"
        ]
      },
      "summary": "In this lesson, you learned that Vibe Coding is a beginner-friendly approach that focuses on ideas and creativity before technical details. You now understand that Vibe Coding uses AI and guidance to make digital creation accessible, and that it builds confidence before complexity. You're ready to continue exploring how Vibe Coding works in the next lesson."
    };
  }

  // Generate templates for other lessons
  return {
    "course_title": courseTitle,
    "module_title": moduleTitle,
    "lesson_number": lessonNumber,
    "lesson_title": lessonTitle,
    "introduction": `Welcome to "${lessonTitle}" in the Vibe Coding course! In this lesson, we'll explore this important concept in a beginner-friendly way. Remember, there's no need to feel anxious - we'll take this step by step with plenty of guidance and support.`,
    "big_idea": getBigIdeaForLesson(lessonTitle),
    "visuals": getVisualsForLesson(lessonTitle),
    "steps": getStepsForLesson(lessonTitle),
    "example": getExampleForLesson(lessonTitle),
    "playground_activity": getPlaygroundActivityForLesson(lessonTitle),
    "reflection_question": getReflectionQuestionForLesson(lessonTitle),
    "quiz": {
      "questions": getQuizQuestionsForLesson(lessonTitle),
      "answers": getQuizAnswersForLesson(lessonTitle)
    },
    "resources": {
      "video": {
        "title": getVideoTitleForLesson(lessonTitle),
        "creator": "Vibe Coding Tutorials",
        "embed": true,
        "reason": "Relevant video content for this lesson topic"
      },
      "extra_reading": [
        "https://example.com/extra-resource-1 - Additional reading for this topic",
        "https://example.com/extra-resource-2 - More resources for curious learners"
      ]
    },
    "summary": `In this lesson on "${lessonTitle}", you've learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You're building a strong foundation for your journey in Vibe Coding.`
  };
}

// Helper functions to generate content for different lessons
function getBigIdeaForLesson(title) {
  switch(title) {
    case "Why Vibe Coding Exists":
      return "Vibe Coding exists because traditional coding approaches often overwhelm beginners with complex syntax and technical rules before they understand the core concepts. Vibe Coding flips this approach by focusing on ideas and creativity first, making digital creation accessible to everyone.";
    case "How Vibe Coding Is Different from Traditional Coding":
      return "Traditional coding starts with technical details and syntax, which can be intimidating for beginners. Vibe Coding starts with your ideas and intentions, using AI and guidance to help you create without getting bogged down in technical complexity.";
    case "Learning to Think in Ideas, Not Code":
      return "In Vibe Coding, you learn to think about what you want to create first, then use tools and guidance to make it happen. This approach builds confidence and helps you understand the purpose behind your digital creations.";
    case "Turning Simple Ideas into Digital Instructions":
      return "Vibe Coding teaches you to break down your ideas into simple steps that can be translated into digital form. This process helps you see how your creative ideas can become real digital products.";
    case "Understanding Intent in Vibe Coding":
      return "Intent is the 'why' behind your digital creation. In Vibe Coding, understanding your intent helps you make better decisions about your project and communicate more effectively with AI tools.";
    case "What AI Really Is (In Simple Terms)":
      return "AI (Artificial Intelligence) is like a very helpful assistant that can process information and help you with tasks. In Vibe Coding, AI serves as a tool to help you create digital products more efficiently.";
    case "How AI Helps in Vibe Coding":
      return "AI in Vibe Coding acts as a guide and helper, suggesting approaches, catching errors, and helping you implement your ideas without needing to know complex technical details.";
    case "Talking to AI Clearly and Effectively":
      return "Effective communication with AI involves being clear about what you want to achieve. In Vibe Coding, you'll learn simple techniques to get the best results from AI assistance.";
    case "Real Examples of Vibe Coding":
      return "Real examples show how Vibe Coding principles have been applied to create actual digital products. These examples demonstrate the power of focusing on ideas and using guidance tools.";
    case "Building Simple Things Without Fear":
      return "Vibe Coding creates a safe environment for experimentation where mistakes are learning opportunities. This approach helps you build confidence while creating real digital products.";
    case "Common Beginner Mistakes and How to Avoid Them":
      return "Understanding common beginner challenges helps you navigate your learning journey more effectively. Vibe Coding provides guidance to avoid these pitfalls.";
    case "Using a Playground to Experiment Safely":
      return "A playground environment allows you to experiment with ideas without consequences. In Vibe Coding, playgrounds provide safe spaces to test and refine your concepts.";
    case "Improving Your Ideas Step by Step":
      return "Iterative improvement is a key principle in Vibe Coding. You'll learn to start with simple ideas and gradually enhance them based on feedback and testing.";
    case "Your First Complete Vibe-Coded Project":
      return "Your first complete project brings together all the Vibe Coding principles you've learned. It demonstrates how to create a functional digital product while maintaining focus on ideas and creativity.";
    default:
      return "This lesson covers an important concept in Vibe Coding that helps you understand how to create digital products with confidence and creativity.";
  }
}

function getVisualsForLesson(title) {
  switch(title) {
    case "Why Vibe Coding Exists":
      return "Create a comparison diagram showing two paths: one with a person looking overwhelmed by complex code symbols, and another with the same person smiling while creating with simple, intuitive tools. Include a bridge showing how Vibe Coding connects these experiences.";
    case "How Vibe Coding Is Different from Traditional Coding":
      return "Design a split-screen visual showing 'Traditional Approach' (left side: complex code, frustrated learner) versus 'Vibe Approach' (right side: idea-focused creation, happy learner). Include arrows showing the learning journey in each approach.";
    case "Learning to Think in Ideas, Not Code":
      return "Show a lightbulb icon transforming into a simple digital product (like a website or app icon) with a thinking person in the background. Include a flow arrow from the lightbulb to the digital product.";
    case "Turning Simple Ideas into Digital Instructions":
      return "Create a step-by-step visual showing an idea (like 'I want to track my expenses') flowing through a simple process that results in a digital solution. Include friendly icons and clear arrows.";
    case "Understanding Intent in Vibe Coding":
      return "Design a visual showing a person with a clear goal (like 'I want to connect with friends') and how this intent guides the creation of a digital solution. Include a compass or roadmap metaphor.";
    default:
      return "Create a friendly, approachable visual that represents the main concept of this lesson. Use soft colors, simple icons, and clear visual flow to represent the lesson's key ideas.";
  }
}

function getStepsForLesson(title) {
  switch(title) {
    case "Why Vibe Coding Exists":
      return [
        "Step 1: Recognize the challenges beginners face with traditional coding",
        "Step 2: Understand how focusing on ideas first reduces anxiety",
        "Step 3: Learn about the benefits of guided learning approaches",
        "Step 4: See how Vibe Coding addresses these challenges",
        "Step 5: Appreciate the importance of confidence-building in learning"
      ];
    case "How Vibe Coding Is Different from Traditional Coding":
      return [
        "Step 1: Examine traditional coding's focus on syntax and rules",
        "Step 2: Compare with Vibe Coding's focus on ideas and creativity",
        "Step 3: Identify the key differences in learning approaches",
        "Step 4: Understand how these differences benefit beginners",
        "Step 5: Recognize the value of guided, supportive learning"
      ];
    default:
      return [
        "Step 1: Understand the main concept of this lesson",
        "Step 2: Learn how this concept applies to Vibe Coding",
        "Step 3: See practical examples of this concept in action",
        "Step 4: Practice applying this concept in the playground",
        "Step 5: Reflect on how this fits into your learning journey"
      ];
  }
}

function getExampleForLesson(title) {
  switch(title) {
    case "Why Vibe Coding Exists":
      return "Think about learning to drive. Would you start by memorizing every technical detail about the engine, transmission, and electronics? No! You start with the basic goal of getting from point A to point B safely. Vibe Coding works the same way - it focuses on your goals and intentions first, then provides the tools to achieve them.";
    case "How Vibe Coding Is Different from Traditional Coding":
      return "Traditional coding is like learning to cook by memorizing the chemical composition of every ingredient before making a sandwich. Vibe Coding is like learning to cook by starting with simple recipes that produce satisfying results, with understanding of the chemistry coming naturally through experience.";
    case "Learning to Think in Ideas, Not Code":
      return "Instead of thinking 'I need to create a for loop to iterate through an array', in Vibe Coding you think 'I want to show a list of items on my webpage'. The tools and guidance help translate your idea into the necessary code.";
    default:
      return `Consider how this concept applies to a real-world scenario. Think of a digital product you use regularly and how this lesson's concept might apply to its creation. This helps solidify your understanding of the principle.`;
  }
}

function getPlaygroundActivityForLesson(title) {
  return `In the playground section, create an interactive activity related to "${title}". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson's main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.`;
}

function getReflectionQuestionForLesson(title) {
  return `How does the concept of "${title}" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?`;
}

function getQuizQuestionsForLesson(title) {
  return [
    `What is the main focus of ${title}?`,
    "How does this concept benefit beginners?",
    "Is this concept part of Vibe Coding's core principles?",
    "What is one practical application of this concept?",
    "How does this concept build confidence in learners?"
  ];
}

function getQuizAnswersForLesson(title) {
  return [
    "The specific concept covered in this lesson",
    "It reduces anxiety and makes learning accessible",
    "Yes, it's a core principle of Vibe Coding",
    "Applying this concept in digital creation projects",
    "By focusing on ideas and providing guidance rather than complexity"
  ];
}

function getVideoTitleForLesson(title) {
  return `Understanding ${title} - Vibe Coding Fundamentals`;
}

// Generate all lessons
function generateAllLessons() {
  const allLessons = [];
  let lessonId = 1;

  courseStructure.forEach(module => {
    module.lessons.forEach(lessonTitle => {
      const lesson = generateLesson("Vibe Coding", module.module, lessonId, lessonTitle);
      allLessons.push(lesson);
      lessonId++;
    });
  });

  return allLessons;
}

// Generate the complete course
const allLessons = generateAllLessons();

// Save each lesson as a separate JSON file
allLessons.forEach((lesson, index) => {
  const fileName = `vibe-lesson-${index + 1}.json`;
  fs.writeFileSync(fileName, JSON.stringify(lesson, null, 2));
  console.log(`Generated: ${fileName}`);
});

// Save all lessons as a single course file
fs.writeFileSync('vibe-coding-course.json', JSON.stringify(allLessons, null, 2));
console.log('\nVibe Coding course generated successfully!');
console.log(`Total lessons: ${allLessons.length}`);
console.log('Course structure:');
courseStructure.forEach((module, index) => {
  console.log(`${index + 1}. ${module.module} (${module.lessons.length} lessons)`);
  module.lessons.forEach(lesson => {
    console.log(`   - ${lesson}`);
  });
});

// Export for use in other modules
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { allLessons, courseStructure };
}