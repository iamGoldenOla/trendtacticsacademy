import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { courseService } from "../services";

const DebugCourse = () => {
    const { id } = useParams();
    const [courseData, setCourseData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [supabaseConfig, setSupabaseConfig] = useState(null);

    useEffect(() => {
        const debugCourse = async () => {
            try {
                setLoading(true);
                setError(null);
                
                // Log the course ID
                console.log("Course ID from URL params:", id);
                
                // Check if ID exists
                if (!id) {
                    setError("No course ID provided in URL");
                    return;
                }
                
                // Try to fetch course
                console.log("Attempting to fetch course with ID:", id);
                const data = await courseService.getCourseById(id);
                setCourseData(data);
                console.log("Course data received:", data);
            } catch (err) {
                console.error("Error in debug course:", err);
                setError(err.message || "Unknown error occurred");
            } finally {
                setLoading(false);
            }
        };
        
        // Also check Supabase config
        try {
            const supabaseUrl = process.env.REACT_APP_SUPABASE_URL;
            const supabaseKey = process.env.REACT_APP_SUPABASE_ANON_KEY;
            setSupabaseConfig({
                url: supabaseUrl,
                keyLength: supabaseKey ? supabaseKey.length : 0,
                hasUrl: !!supabaseUrl,
                hasKey: !!supabaseKey
            });
        } catch (configErr) {
            console.error("Error getting Supabase config:", configErr);
        }
        
        debugCourse();
    }, [id]);

    return (
        <div className="container mx-auto px-4 py-8">
            <h1 className="text-2xl font-bold mb-6">Course Debug Page</h1>
            
            <div className="bg-white rounded-lg shadow p-6 mb-6">
                <h2 className="text-xl font-semibold mb-4">Debug Information</h2>
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                    <div className="border p-4 rounded">
                        <h3 className="font-medium mb-2">URL Parameters</h3>
                        <p><strong>Course ID:</strong> {id || "None"}</p>
                    </div>
                    
                    <div className="border p-4 rounded">
                        <h3 className="font-medium mb-2">Supabase Configuration</h3>
                        {supabaseConfig ? (
                            <>
                                <p><strong>URL Set:</strong> {supabaseConfig.hasUrl ? "Yes" : "No"}</p>
                                <p><strong>Key Set:</strong> {supabaseConfig.hasKey ? "Yes" : "No"}</p>
                                <p><strong>Key Length:</strong> {supabaseConfig.keyLength}</p>
                            </>
                        ) : (
                            <p>Loading configuration...</p>
                        )}
                    </div>
                </div>
            </div>
            
            {loading && (
                <div className="text-center py-8">
                    <div className="inline-block animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-brand-cyan"></div>
                    <p className="mt-2">Loading course data...</p>
                </div>
            )}
            
            {error && (
                <div className="bg-red-50 border border-red-200 rounded-lg p-6 mb-6">
                    <h2 className="text-xl font-semibold text-red-800 mb-2">Error</h2>
                    <p className="text-red-600 mb-4">{error}</p>
                    <button 
                        onClick={() => window.location.reload()}
                        className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700"
                    >
                        Try Again
                    </button>
                </div>
            )}
            
            {courseData && (
                <div className="bg-green-50 border border-green-200 rounded-lg p-6">
                    <h2 className="text-xl font-semibold text-green-800 mb-2">Success!</h2>
                    <p className="text-green-600 mb-4">Course data loaded successfully.</p>
                    <div className="border p-4 rounded bg-white">
                        <h3 className="font-medium mb-2">Course Information</h3>
                        <p><strong>Title:</strong> {courseData.title}</p>
                        <p><strong>ID:</strong> {courseData.id}</p>
                        <p><strong>Modules:</strong> {courseData.modules?.length || 0}</p>
                        {courseData.modules && courseData.modules.map((module, index) => (
                            <div key={module.id} className="ml-4 mt-2">
                                <p><strong>Module {index + 1}:</strong> {module.title} ({module.lessons?.length || 0} lessons)</p>
                            </div>
                        ))}
                    </div>
                </div>
            )}
            
            {!loading && !error && !courseData && (
                <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6">
                    <h2 className="text-xl font-semibold text-yellow-800 mb-2">No Data</h2>
                    <p className="text-yellow-600">No course data available. This might indicate the course doesn't exist or there's a configuration issue.</p>
                </div>
            )}
        </div>
    );
};

export default DebugCourse;