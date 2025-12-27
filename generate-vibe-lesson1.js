// Vibe Coding Lesson Generator
// This script generates the first lesson for the Vibe Coding course

const lesson1 = {
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

// Save the lesson to a JSON file that can be used by the frontend
console.log('Vibe Coding Lesson 1 generated successfully!');
console.log('Lesson Title:', lesson1.lesson_title);
console.log('Module:', lesson1.module_title);
console.log('Course:', lesson1.course_title);

// Export the lesson for use in other modules
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { lesson1 };
}