// Pre-generated fallback lesson content for Trendtactics Academy
// This provides offline AI solutions that don't require authentication

const LessonFallbackContent = {
    // Generic lesson templates
    getTemplate: function(lessonTitle, courseTitle, moduleTitle) {
        const topic = lessonTitle.toLowerCase().replace('what is ', '').replace('?', '').trim();
        
        return {
            course_id: 'fallback',
            course_title: courseTitle,
            module_title: moduleTitle,
            lesson_title: lessonTitle,
            introduction: {
                title: `Introduction to ${lessonTitle}`,
                description: `In this lesson, you'll learn about ${topic}. This topic is fundamental to the ${courseTitle} course and will provide you with practical skills you can apply immediately.`,
                importance: `Understanding ${topic} is crucial because it forms the foundation for advanced concepts in ${courseTitle} and provides real-world applications that will enhance your knowledge in this field.`,
                learningOutcomes: [
                    `Understand the core principles of ${topic}`,
                    `Apply ${courseTitle} techniques in practical scenarios`,
                    `Recognize when and how to use ${topic} effectively`
                ]
            },
            core_concepts: `The core concept of ${topic} in the context of ${moduleTitle} and ${courseTitle} is unique and specific to this lesson. This concept involves several key components that work together to create powerful and efficient solutions.

First, it's important to understand that ${topic} is not just a single technique, but rather a comprehensive approach that combines multiple methodologies to achieve optimal results. The foundational principle behind ${topic} is to streamline processes, reduce complexity, and enhance productivity through systematic approaches.

For beginners, think of ${topic} as a framework that helps you organize and execute tasks more efficiently. The core idea is to break down complex problems into manageable components that can be addressed systematically. This approach has several key benefits:

1. **Simplicity**: Complex tasks are simplified into understandable steps
2. **Efficiency**: Time and resources are optimized through structured approaches
3. **Scalability**: Solutions can grow and adapt as needs change
4. **Reliability**: Consistent methods lead to predictable and dependable outcomes

The practical application of ${topic} in ${moduleTitle} involves understanding how different elements interact with each other. For example, in the context of ${courseTitle}, ${topic} serves as a bridge between theoretical knowledge and practical implementation. It connects abstract concepts to real-world applications, making it easier for practitioners to implement effective solutions.

The underlying mechanics involve several interconnected processes that work together seamlessly. These processes have been refined over time to maximize effectiveness while minimizing complexity. Understanding these mechanics is crucial for anyone looking to master ${courseTitle} concepts.

Best practices for implementing ${topic} include starting with simple applications and gradually building complexity, maintaining clear documentation of processes, and continuously evaluating and refining approaches based on results. These practices ensure that ${topic} remains effective and relevant in various contexts.

In real-world scenarios, ${topic} has proven to be invaluable across multiple industries and applications. Its versatility and adaptability make it a cornerstone of modern ${courseTitle} methodologies.`,
            unique_aspect: `In this specific lesson about "${lessonTitle}", we'll explore the distinctive characteristics that differentiate it from other concepts in the ${courseTitle} curriculum. This lesson builds upon previous knowledge while introducing specialized applications and nuanced understanding that are unique to ${topic}.`,
            visual_explanations: [
                `Visual representations help clarify the ${topic} concepts`,
                `Diagrams showing the relationship between different ${topic} components`,
                `Interactive diagrams that show how ${topic} works step-by-step`,
                `Flowcharts demonstrating the ${topic} process`,
                `Comparative visuals showing ${topic} vs traditional approaches`
            ],
            step_by_step: [
                {
                    title: 'Getting Started',
                    description: `Begin by understanding the basics of ${topic}`
                },
                {
                    title: 'Implementation',
                    description: `Apply ${topic} in a practical context`
                },
                {
                    title: 'Advanced Applications',
                    description: `Explore advanced uses of ${topic} in ${courseTitle}`
                }
            ],
            practical_examples: [
                {
                    title: `Example 1: Basic ${topic} Usage`,
                    scenario: `A beginner scenario demonstrating ${topic}`,
                    implementation: `Simple implementation showing core concepts`,
                    outcome: `Understanding of basic ${topic} principles`
                },
                {
                    title: `Example 2: Advanced ${topic} Application`,
                    scenario: `A complex scenario showcasing advanced ${topic} usage`,
                    implementation: `Sophisticated implementation with best practices`,
                    outcome: `Mastery of advanced ${topic} concepts`
                }
            ],
            case_study: {
                title: `Case Study: Implementing ${topic} in Real Projects`,
                scenario: `A real-world scenario demonstrating ${topic} in action`,
                challenges: `Initial challenges in implementing ${topic}`,
                solution: `Effective solution using ${topic} principles`,
                results: `Successful implementation with measurable outcomes`,
                lessonsLearned: `Key insights about ${topic} best practices`
            },
            resources: {
                youtube_videos: [
                    {
                        title: `${topic} Explained in Detail`,
                        url: this.getRelevantVideoUrl(topic),
                        embeddable: true,
                        why_relevant: `Provides comprehensive overview of ${topic} concepts suitable for ${courseTitle}`
                    }
                ],
                images: [],
                downloads: []
            },
            summary: {
                keyTakeaways: [
                    `${topic} enhances your ${courseTitle} workflow through systematic approaches`,
                    `The approach emphasizes practical application and continuous learning`,
                    `${topic} should be integrated thoughtfully with your existing knowledge`,
                    `Critical thinking remains essential even with structured approaches`
                ],
                nextSteps: [
                    `Practice applying ${topic} in different contexts`,
                    `Explore advanced features of ${courseTitle} methodologies`,
                    `Share experiences with the ${courseTitle} community`,
                    `Build a personal toolkit of ${courseTitle} strategies`
                ],
                confidenceBuilder: `You now have a solid understanding of ${topic}. With practice, you will become proficient at leveraging these concepts in your work.`
            },
            quiz: {
                title: `${topic} Fundamentals Quiz`,
                questions: [
                    {
                        question: `What is the primary principle of ${topic}?`,
                        options: [
                            'Fundamental concepts and systematic approach',
                            'Random trial and error',
                            'Following outdated methods',
                            'Complete automation of all tasks'
                        ],
                        correctAnswer: 0,
                        explanation: `${topic} emphasizes fundamental concepts and systematic approaches to problem-solving.`
                    },
                    {
                        question: 'Which of the following is a best practice in this area?',
                        options: [
                            'Over-relying on shortcuts without understanding',
                            'Starting with clear foundational knowledge',
                            'Ignoring basic principles',
                            'Avoiding structured learning'
                        ],
                        correctAnswer: 1,
                        explanation: 'Starting with clear foundational knowledge helps build stronger understanding.'
                    },
                    {
                        question: 'What should you do after learning the basics?',
                        options: [
                            'Stop learning and apply only basic techniques',
                            'Verify and practice the concepts thoroughly',
                            'Assume you know everything',
                            'Ignore further development'
                        ],
                        correctAnswer: 1,
                        explanation: 'It\'s essential to verify and practice concepts thoroughly before advancing.'
                    }
                ]
            }
        };
    },

    // Get relevant video URL based on topic
    getRelevantVideoUrl: function(topic) {
        // Map topics to relevant educational YouTube videos
        const topicMap = {
            'vibe coding': '5OWurmg41tI',
            'ai automation': 'jwG_OzHVoqo',
            'prompt engineering': 'Z6VZYyGFco4',
            'digital marketing': 'mIxwUbZSf_Q',
            'facebook ads': 'uKj01Hy24A0',
            'automation': 'P5g3ujZCp8M',
            'development': 'PkZNo7MFNFg',
            'coding': 'DLX62G4lc44'
        };

        // Check for matching topic
        for (const [key, videoId] of Object.entries(topicMap)) {
            if (topic.toLowerCase().includes(key)) {
                return `https://www.youtube.com/embed/${videoId}`;
            }
        }

        // Default to a general educational video if no match
        return 'https://www.youtube.com/embed/dQw4w9WgXcQ';
    },

    // Get specific fallback content for known lessons
    getSpecificContent: function(lessonTitle, courseTitle, moduleTitle) {
        // You can add specific content for known lesson titles here
        const specificContent = {
            'What is Vibe Coding?': {
                core_concepts: 'Vibe Coding is a revolutionary approach to programming that focuses on ideas, intention, creativity, and guidance rather than syntax. It\'s about creating digital products by thinking in concepts first, then letting tools translate that to code.',
                unique_aspect: 'Vibe Coding uniquely combines creative thinking with technical implementation, making programming accessible to everyone regardless of their coding background.',
                practical_examples: [
                    {
                        title: 'Example 1: Simple Web Page',
                        scenario: 'Creating a personal website using Vibe Coding principles',
                        implementation: 'Describe the desired outcome in natural language, then use AI tools to generate the code',
                        outcome: 'A functional web page without writing traditional code'
                    }
                ]
            },
            'Why Vibe Coding Exists': {
                core_concepts: 'Traditional coding focuses on syntax and implementation details, which can be a barrier for creative people. Vibe Coding removes this barrier by focusing on the creative aspects first.',
                unique_aspect: 'This approach recognizes that not everyone thinks in syntax, but everyone can think in ideas and concepts.',
            }
        };

        const content = specificContent[lessonTitle];
        if (content) {
            const template = this.getTemplate(lessonTitle, courseTitle, moduleTitle);
            // Merge specific content with template
            Object.assign(template, content);
            return template;
        }

        // Return generic template if no specific content found
        return this.getTemplate(lessonTitle, courseTitle, moduleTitle);
    }
};