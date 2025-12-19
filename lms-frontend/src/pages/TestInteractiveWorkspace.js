import React, { useState, useEffect } from "react";
import CourseLearningBoard from "../components/CourseLearningBoard";

const TestInteractiveWorkspace = () => {
    const [course, setCourse] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Create a mock course with proper structure to test the interactive workspace
        const mockCourse = {
            id: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
            title: 'Test Interactive Course',
            description: 'A course to test the interactive learning workspace',
            modules: [
                {
                    id: 'm1',
                    title: 'Module 1: Getting Started',
                    description: 'Introduction to the course',
                    lessons: [
                        {
                            id: 'l1',
                            title: 'Lesson 1: Introduction',
                            content: '# Welcome to the Course\n\nThis is the first lesson of the course.\n\n## What you will learn\n\n- Basic concepts\n- Hands-on practice\n- Interactive coding exercises',
                            description: 'Introduction to the course content'
                        },
                        {
                            id: 'l2',
                            title: 'Lesson 2: Setting Up',
                            content: '# Setting Up Your Environment\n\nIn this lesson, you will learn how to set up your development environment.\n\n## Prerequisites\n\n- Basic computer skills\n- Text editor\n- Internet connection',
                            description: 'How to set up your development environment'
                        }
                    ]
                },
                {
                    id: 'm2',
                    title: 'Module 2: Core Concepts',
                    description: 'Deep dive into core concepts',
                    lessons: [
                        {
                            id: 'l3',
                            title: 'Lesson 3: Variables and Data Types',
                            content: '# Variables and Data Types\n\nIn programming, variables are used to store data.\n\n## Examples\n\n```javascript\nlet name = "John";\nconst age = 25;\n```\n\n## Practice Exercise\n\nTry creating your own variables with different data types.',
                            description: 'Understanding variables and data types'
                        }
                    ]
                }
            ]
        };
        
        setCourse(mockCourse);
        setLoading(false);
    }, []);

    if (loading) {
        return (
            <div className="min-h-screen bg-gray-50 flex items-center justify-center">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-brand-cyan mx-auto mb-4"></div>
                    <p className="text-gray-600">Loading test workspace...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gray-50">
            <div className="bg-white border-b border-gray-200">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="py-4">
                        <h1 className="text-2xl font-bold text-gray-900">{course.title}</h1>
                        <p className="text-gray-600">{course.description}</p>
                    </div>
                </div>
            </div>
            
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 h-[calc(100vh-140px)]">
                <CourseLearningBoard course={course} />
            </div>
        </div>
    );
};

export default TestInteractiveWorkspace;