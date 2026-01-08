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
                ],
                resources: {
                    youtube_videos: [
                        {
                            title: 'What is Vibe Coding?',
                            url: 'https://www.youtube.com/embed/5OWurmg41tI',
                            embeddable: true,
                            why_relevant: 'Explains the core concepts of Vibe Coding approach and its benefits for creative developers.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Why Vibe Coding Exists': {
                core_concepts: 'Traditional coding focuses on syntax and implementation details, which can be a barrier for creative people. Vibe Coding removes this barrier by focusing on the creative aspects first.',
                unique_aspect: 'This approach recognizes that not everyone thinks in syntax, but everyone can think in ideas and concepts.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'The Problem with Traditional Coding',
                            url: 'https://www.youtube.com/embed/PkZNo7MFNFg',
                            embeddable: true,
                            why_relevant: 'Discusses the challenges with traditional syntax-focused coding and why a concept-first approach is better.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Vibe Coding vs Traditional Coding': {
                core_concepts: 'Vibe Coding differs from traditional coding in its approach to problem-solving. Instead of focusing on syntax and implementation details, it starts with the desired outcome and uses AI tools to generate the necessary code.',
                unique_aspect: 'The key difference is in the thinking process: Vibe Coding starts with "what do I want?" while traditional coding starts with "how do I build it?".',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Vibe Coding vs Traditional Coding Comparison',
                            url: 'https://www.youtube.com/embed/DLX62G4lc44',
                            embeddable: true,
                            why_relevant: 'Visual comparison of the two approaches with practical examples.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Core Principles of Vibe Coding': {
                core_concepts: 'The core principles of Vibe Coding include focusing on ideas first, using AI tools as creative partners, and thinking in concepts rather than syntax.',
                unique_aspect: 'These principles allow for faster prototyping and development without getting bogged down in implementation details.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Core Principles of Vibe Coding',
                            url: 'https://www.youtube.com/embed/mIxwUbZsF_Q',
                            embeddable: true,
                            why_relevant: 'Detailed explanation of the fundamental principles that make Vibe Coding effective.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Vibe Coding Workflow': {
                core_concepts: 'The Vibe Coding workflow involves describing what you want to build in natural language, using AI tools to generate the code, testing and refining the output, and iterating until you achieve the desired result.',
                unique_aspect: 'This workflow allows for rapid prototyping and experimentation without the overhead of traditional development processes.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Vibe Coding Workflow Explained',
                            url: 'https://www.youtube.com/embed/jwG_OzHVoqo',
                            embeddable: true,
                            why_relevant: 'Step-by-step guide to the Vibe Coding workflow with practical examples.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Tools for Vibe Coding': {
                core_concepts: 'Vibe Coding leverages AI tools like ChatGPT, GitHub Copilot, Replit, and other AI-powered development environments to generate code from natural language descriptions.',
                unique_aspect: 'The right tools can dramatically accelerate the Vibe Coding process and improve the quality of generated code.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Best Tools for Vibe Coding',
                            url: 'https://www.youtube.com/embed/Z6VZYyGFco4',
                            embeddable: true,
                            why_relevant: 'Review of the most effective AI tools for Vibe Coding with practical demonstrations.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Practical Vibe Coding Examples': {
                core_concepts: 'Practical examples demonstrate how to apply Vibe Coding to real-world problems like building web applications, creating automation scripts, and developing digital products.',
                unique_aspect: 'These examples show how to think in concepts and translate ideas into working solutions using AI tools.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Practical Vibe Coding Examples',
                            url: 'https://www.youtube.com/embed/uKj01Hy24A0',
                            embeddable: true,
                            why_relevant: 'Real-world examples of Vibe Coding in action with complete walkthroughs.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Advanced Vibe Coding Techniques': {
                core_concepts: 'Advanced techniques include prompt engineering, iterative refinement, and combining multiple AI tools for complex projects.',
                unique_aspect: 'These techniques allow for more sophisticated projects and better control over AI-generated outputs.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Advanced Vibe Coding Techniques',
                            url: 'https://www.youtube.com/embed/P5g3ujZCp8M',
                            embeddable: true,
                            why_relevant: 'Deep dive into advanced techniques for maximizing the effectiveness of Vibe Coding.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Building Your First Vibe Coding Project': {
                core_concepts: 'Your first Vibe Coding project should be simple but complete, allowing you to experience the full workflow from idea to working application.',
                unique_aspect: 'Starting with a manageable project helps build confidence and understanding of the Vibe Coding approach.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Building Your First Vibe Coding Project',
                            url: 'https://www.youtube.com/embed/5OWurmg41tI',
                            embeddable: true,
                            why_relevant: 'Complete walkthrough of building a first project using Vibe Coding principles.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
            },
            'Common Vibe Coding Mistakes': {
                core_concepts: 'Common mistakes include being too vague in prompts, not iterating enough, and expecting perfect results on the first try.',
                unique_aspect: 'Learning to avoid these mistakes helps improve the effectiveness of the Vibe Coding approach.',
                resources: {
                    youtube_videos: [
                        {
                            title: 'Common Vibe Coding Mistakes to Avoid',
                            url: 'https://www.youtube.com/embed/DLX62G4lc44',
                            embeddable: true,
                            why_relevant: 'Practical advice on avoiding common pitfalls in Vibe Coding.'
                        }
                    ],
                    images: [],
                    downloads: []
                }
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