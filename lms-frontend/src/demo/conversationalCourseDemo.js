// Demo script for conversational course creation
// This script demonstrates how the conversation flow works

const conversationalCourseDemo = {
  // Sample conversation flow
  sampleConversation: [
    {
      speaker: "User",
      message: "I want to create a course about social media marketing"
    },
    {
      speaker: "Trendy",
      message: "Great topic! I'd love to help you create a social media marketing course. To get started, could you tell me a bit about your target audience? Are you teaching beginners, intermediate marketers, or experts?"
    },
    {
      speaker: "User",
      message: "Mostly beginners who want to learn how to grow their business on social media"
    },
    {
      speaker: "Trendy",
      message: "Perfect! For beginner entrepreneurs, I recommend we focus on practical, actionable content. What specific social media platforms are you most interested in covering? For example: Instagram, Facebook, TikTok, LinkedIn, or Twitter?"
    },
    {
      speaker: "User",
      message: "Instagram and TikTok mainly, since they're great for visual content"
    },
    {
      speaker: "Trendy",
      message: "Excellent choices! Visual platforms are perfect for business growth. How long would you like this course to be? For example: a quick 1-week intensive, a 4-week foundational course, or an 8-week comprehensive program?"
    },
    {
      speaker: "User",
      message: "Let's go with a 4-week foundational course"
    },
    {
      speaker: "Trendy",
      message: "Perfect! Here's a draft outline for your 4-week Social Media Marketing for Beginners course:\n\nWeek 1: Foundations of Social Media Marketing\n- Understanding your audience\n- Setting SMART goals\n- Platform selection strategy\n\nWeek 2: Content Creation Basics\n- Visual storytelling principles\n- Creating engaging captions\n- Hashtag strategies\n\nWeek 3: Growing Your Audience\n- Algorithm basics\n- Engagement techniques\n- Collaborations and partnerships\n\nWeek 4: Measuring Success\n- Analytics and metrics\n- Adjusting your strategy\n- Building a content calendar\n\nDoes this structure work for you, or would you like to adjust anything?"
    }
  ],

  // Sample course content generated
  sampleCourseContent: `
Course Title: Social Media Marketing for Beginners

Description: 
Learn how to effectively grow your business on Instagram and TikTok with this comprehensive 4-week course designed specifically for beginners.

Learning Objectives:
• Understand the fundamentals of social media marketing
• Create engaging content that resonates with your target audience
• Grow your following organically on Instagram and TikTok
• Measure and optimize your social media performance

Modules:
1. Foundations of Social Media Marketing
   - Identifying your target audience
   - Setting measurable goals
   - Choosing the right platforms

2. Content Creation Basics
   - Visual storytelling principles
   - Writing engaging captions
   - Hashtag research and usage

3. Growing Your Audience
   - Understanding platform algorithms
   - Engagement strategies that work
   - Building partnerships

4. Measuring Success
   - Key metrics to track
   - Analyzing your performance
   - Creating a content calendar

Projects/Assignments:
• Week 1: Create a brand persona worksheet
• Week 2: Design a week's worth of content
• Week 3: Engage with 10 accounts in your niche
• Week 4: Present a 30-day content calendar

Estimated Duration: 4 weeks (2-3 hours per week)
`,

  // Demo functions
  simulateConversation: function() {
    console.log("=== Conversational Course Creation Demo ===");
    console.log("Starting conversation simulation...\n");
    
    this.sampleConversation.forEach((turn, index) => {
      console.log(`${turn.speaker}: ${turn.message}\n`);
    });
    
    console.log("=== Generated Course Content ===");
    console.log(this.sampleCourseContent);
  },

  getSamplePrompts: function() {
    return [
      "Create a course about web development for beginners",
      "I want to teach people how to start a podcast",
      "Help me make a course on personal finance management",
      "Design a photography course for social media content",
      "Create a course about email marketing automation"
    ];
  }
};

// Export for use in other files
export default conversationalCourseDemo;

// Run demo if called directly
if (typeof window !== 'undefined' && window.conversationalCourseDemo) {
  window.conversationalCourseDemo = conversationalCourseDemo;
}