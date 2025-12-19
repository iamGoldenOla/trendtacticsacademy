import React, { useState } from "react";
import { aiCourseService } from "../services";

const AICourseGenerator = () => {
    const [topic, setTopic] = useState("");
    const [generatedCourse, setGeneratedCourse] = useState(null);
    const [isGenerating, setIsGenerating] = useState(false);
    const [error, setError] = useState(null);

    const handleGenerateCourse = async (e) => {
        e.preventDefault();
        
        if (!topic.trim()) {
            setError("Please enter a topic for the course");
            return;
        }
        
        try {
            setIsGenerating(true);
            setError(null);
            
            // Generate course using AI service
            const course = await aiCourseService.generateCourse(topic);
            setGeneratedCourse(course);
        } catch (err) {
            console.error("Error generating course:", err);
            setError("Failed to generate course. Please try again.");
        } finally {
            setIsGenerating(false);
        }
    };

    const handleSaveCourse = async () => {
        try {
            // In a real implementation, this would save the course to the database
            alert("Course would be saved to the database in a real implementation!");
            setGeneratedCourse(null);
            setTopic("");
        } catch (err) {
            console.error("Error saving course:", err);
            setError("Failed to save course. Please try again.");
        }
    };

    return (
        <div className="min-h-screen bg-gray-50 py-8">
            <div className="max-w-4xl mx-auto px-4">
                <div className="bg-white rounded-lg shadow p-6 mb-8">
                    <h1 className="text-2xl font-bold text-gray-900 mb-2">AI Course Generator</h1>
                    <p className="text-gray-600 mb-6">
                        Generate courses automatically using AI. Enter a topic below and let our AI create a complete course structure for you.
                    </p>
                    
                    <form onSubmit={handleGenerateCourse} className="mb-6">
                        <div className="flex gap-4">
                            <input
                                type="text"
                                value={topic}
                                onChange={(e) => setTopic(e.target.value)}
                                placeholder="Enter a course topic (e.g., Python, Digital Marketing, React Native)"
                                className="flex-1 input-field"
                                disabled={isGenerating}
                            />
                            <button
                                type="submit"
                                className="btn-primary"
                                disabled={isGenerating}
                            >
                                {isGenerating ? "Generating..." : "Generate Course"}
                            </button>
                        </div>
                    </form>
                    
                    {error && (
                        <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
                            <p className="text-red-800">{error}</p>
                        </div>
                    )}
                </div>
                
                {isGenerating && (
                    <div className="bg-white rounded-lg shadow p-6 mb-8 text-center">
                        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-brand-cyan mx-auto mb-4"></div>
                        <p className="text-gray-600">Our AI is generating a course for "{topic}"...</p>
                    </div>
                )}
                
                {generatedCourse && (
                    <div className="bg-white rounded-lg shadow p-6">
                        <div className="flex justify-between items-start mb-6">
                            <div>
                                <h2 className="text-2xl font-bold text-gray-900 mb-2">{generatedCourse.title}</h2>
                                <p className="text-gray-600 mb-4">{generatedCourse.description}</p>
                                
                                <div className="flex flex-wrap gap-4 mb-4">
                                    <span className="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                                        {generatedCourse.category}
                                    </span>
                                    <span className="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">
                                        {generatedCourse.level}
                                    </span>
                                    <span className="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm">
                                        {generatedCourse.duration}
                                    </span>
                                </div>
                            </div>
                            
                            <img 
                                src={generatedCourse.thumbnail_url} 
                                alt={generatedCourse.title}
                                className="w-32 h-20 object-cover rounded-lg"
                            />
                        </div>
                        
                        <div className="mb-6">
                            <h3 className="text-xl font-semibold text-gray-900 mb-4">Course Structure</h3>
                            
                            <div className="space-y-4">
                                {generatedCourse.modules.map((module) => (
                                    <div key={module.id} className="border border-gray-200 rounded-lg p-4">
                                        <div className="flex justify-between items-center mb-2">
                                            <h4 className="font-medium text-gray-900">{module.title}</h4>
                                            <span className="text-sm text-gray-500">{module.duration}</span>
                                        </div>
                                        <p className="text-gray-600 text-sm mb-3">{module.description}</p>
                                        
                                        <div className="ml-4 space-y-2">
                                            {module.lessons.map((lesson) => (
                                <div key={lesson.id} className="flex items-center text-sm text-gray-600">
                                    <svg className="w-4 h-4 mr-2 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                        <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                                    </svg>
                                    {lesson.title} ({lesson.duration})
                                </div>
                            ))}
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>
                        
                        <div className="flex gap-4">
                            <button
                                onClick={handleSaveCourse}
                                className="btn-primary"
                            >
                                Save Course to Database
                            </button>
                            <button
                                onClick={() => setGeneratedCourse(null)}
                                className="btn-secondary"
                            >
                                Generate Another
                            </button>
                        </div>
                    </div>
                )}
                
                {!generatedCourse && !isGenerating && (
                    <div className="bg-white rounded-lg shadow p-6 text-center">
                        <div className="text-6xl mb-4">🤖</div>
                        <h3 className="text-xl font-semibold text-gray-900 mb-2">Ready to Generate a Course?</h3>
                        <p className="text-gray-600 mb-6">
                            Enter a topic above and our AI will create a complete course structure for you.
                        </p>
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 max-w-2xl mx-auto">
                            <div className="bg-gray-50 p-4 rounded-lg">
                                <h4 className="font-medium text-gray-900 mb-2">Web Development</h4>
                                <p className="text-sm text-gray-600">HTML, CSS, JavaScript, React</p>
                            </div>
                            <div className="bg-gray-50 p-4 rounded-lg">
                                <h4 className="font-medium text-gray-900 mb-2">Mobile Apps</h4>
                                <p className="text-sm text-gray-600">React Native, Flutter, iOS, Android</p>
                            </div>
                            <div className="bg-gray-50 p-4 rounded-lg">
                                <h4 className="font-medium text-gray-900 mb-2">Digital Marketing</h4>
                                <p className="text-sm text-gray-600">SEO, Social Media, Ads, Analytics</p>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};

export default AICourseGenerator;