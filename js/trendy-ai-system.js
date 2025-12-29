/**
 * Trendtactics Digital Academy - AI System Configuration
 * 
 * This is the core AI system powering the academy.
 * Two strictly separated modes: MODE A (Locked Course Runtime) and MODE B (Course Creation Engine)
 */

const TrendtacticsAI = {
    // System identification
    name: "Trendy",
    version: "1.0.0",
    platform: "Trendtactics Digital Academy",

    // Current active mode
    currentMode: "A",

    // Locked Course Structure (Vibe Coding)
    lockedCourses: {
        "vibe-coding": {
            title: "Vibe Coding",
            description: "A beginner-friendly approach to creating digital products by focusing on ideas, intention, creativity, and guidance with AI assistance.",
            modules: [
                {
                    id: 1,
                    title: "Understanding Vibe Coding",
                    lessons: [
                        { number: 1, title: "What Is Vibe Coding?" },
                        { number: 2, title: "Why Vibe Coding Exists" },
                        { number: 3, title: "How Vibe Coding Is Different from Traditional Coding" }
                    ]
                },
                {
                    id: 2,
                    title: "Thinking Before Coding",
                    lessons: [
                        { number: 4, title: "Learning to Think in Ideas, Not Code" },
                        { number: 5, title: "Turning Simple Ideas into Digital Instructions" },
                        { number: 6, title: "Understanding Intent in Vibe Coding" }
                    ]
                },
                {
                    id: 3,
                    title: "Working with AI as a Creative Partner",
                    lessons: [
                        { number: 7, title: "What AI Really Is (In Simple Terms)" },
                        { number: 8, title: "How AI Helps in Vibe Coding" },
                        { number: 9, title: "Talking to AI Clearly and Effectively" }
                    ]
                },
                {
                    id: 4,
                    title: "Vibe Coding in Real Life",
                    lessons: [
                        { number: 10, title: "Real Examples of Vibe Coding" },
                        { number: 11, title: "Everyday Applications of Vibe Coding" }
                    ]
                },
                {
                    id: 5,
                    title: "Your First Project",
                    lessons: [
                        { number: 12, title: "Choosing Your First Project" },
                        { number: 13, title: "Describing What You Want" },
                        { number: 14, title: "Building and Iterating" }
                    ]
                },
                {
                    id: 6,
                    title: "Moving Forward",
                    lessons: [
                        { number: 15, title: "Your Vibe Coding Journey" }
                    ]
                }
            ]
        }
    },

    // System Prompt for Mode A
    modeAPrompt: `You are Trendy, the AI tutor for Trendtactics Digital Academy.

MODE A: LOCKED COURSE RUNTIME (ACTIVE)

You are an expert educator, curriculum implementer, and beginner-first teacher.

RESPONSIBILITIES:
- Generate lesson content inside the fixed course structure
- Deliver lessons one at a time, sequentially
- Enhance lessons with explanations, visuals, quizzes, and resources
- Ensure students never feel stuck, confused, or overwhelmed

COURSE STRUCTURE IS LOCKED - DO NOT MODIFY:
- Do NOT add, remove, rename, or reorder lessons
- The provided structure is authoritative and final

TEACHING RULES:
- Start simple, then gently deepen understanding
- Explain why before how
- Never assume prior knowledge
- Avoid jargon (or explain it clearly)
- Encourage curiosity, not perfection
- Never overwhelm the learner

TONE:
- Friendly, calm, supportive, conversational
- No emojis in lesson content

LESSON STRUCTURE (Follow this exact order):
1. Lesson Introduction
2. Big Idea
3. Visual Explanation
4. Step-by-Step Breakdown
5. Practical Example
6. Try It Yourself (Playground Activity)
7. Reflection Question
8. Quick Quiz
9. Quiz Answers
10. Extra Resources
11. Summary`,

    // System Prompt for Mode B
    modeBPrompt: `You are Trendy, the AI curriculum architect for Trendtactics Digital Academy.

MODE B: COURSE CREATION ENGINE (ADMIN-ONLY)

You are an expert curriculum architect and learning designer.

RESPONSIBILITIES:
- Generate complete course structures
- Follow proven global ed-tech standards
- Design for absolute beginners
- Create clear, calm, progressive learning paths

COURSE DESIGN RULES:
- Courses must be modular
- Each module must have 3-4 lessons
- Titles must be clear, friendly, and non-technical
- Learning progression must feel natural
- Avoid complexity spikes
- Avoid unnecessary theory

AUTO-LOCK RULE:
- Once a course structure is generated, it becomes FINAL
- It is automatically treated as MODE A
- No further structural changes are allowed`,

    // Lesson JSON Schema
    lessonSchema: {
        course_title: "",
        module_title: "",
        lesson_number: 0,
        lesson_title: "",
        introduction: "",
        big_idea: "",
        visuals: "",
        steps: [],
        example: "",
        playground_activity: "",
        reflection_question: "",
        quiz: {
            questions: [],
            answers: []
        },
        resources: {
            video: {
                title: "",
                creator: "",
                embed: true,
                reason: ""
            },
            extra_reading: []
        },
        summary: ""
    },

    // Course Creation Schema
    courseCreationSchema: {
        mode: "course_creation",
        course_goal: "",
        target_audience: "",
        skill_level: ""
    },

    // Get the system prompt based on current mode
    getSystemPrompt: function(mode = "A") {
        return mode === "B" ? this.modeBPrompt : this.modeAPrompt;
    },

    // Get course structure
    getCourseStructure: function(courseId) {
        return this.lockedCourses[courseId] || null;
    },

    // Get lesson info
    getLessonInfo: function(courseId, lessonNumber) {
        const course = this.lockedCourses[courseId];
        if (!course) return null;

        for (const module of course.modules) {
            const lesson = module.lessons.find(l => l.number === lessonNumber);
            if (lesson) {
                return {
                    course_title: course.title,
                    module_title: module.title,
                    lesson_number: lesson.number,
                    lesson_title: lesson.title
                };
            }
        }
        return null;
    },

    // Get next lesson
    getNextLesson: function(courseId, currentLessonNumber) {
        return this.getLessonInfo(courseId, currentLessonNumber + 1);
    },

    // Validate mode from input
    validateMode: function(input) {
        if (typeof input === 'object' && input.mode === 'course_creation') {
            return "B";
        }
        return "A";
    },

    // Generate lesson generation prompt
    generateLessonPrompt: function(courseId, lessonNumber) {
        const lessonInfo = this.getLessonInfo(courseId, lessonNumber);
        if (!lessonInfo) return null;

        return `Generate lesson content for:
Course: ${lessonInfo.course_title}
Module: ${lessonInfo.module_title}
Lesson ${lessonInfo.lesson_number}: ${lessonInfo.lesson_title}

Return ONLY structured JSON following the lesson schema.
No markdown. No commentary. No explanations outside JSON.`;
    }
};

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
    module.exports = TrendtacticsAI;
}
