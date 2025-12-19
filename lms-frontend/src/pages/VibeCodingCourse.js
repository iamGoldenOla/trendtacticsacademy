import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import VibeCodingLesson from '../components/VibeCodingLesson';

const VibeCodingCourse = () => {
  const { id } = useParams();
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentLessonIndex, setCurrentLessonIndex] = useState(0);
  const [allLessons, setAllLessons] = useState([]);

  useEffect(() => {
    const fetchCourse = async () => {
      try {
        setLoading(true);
        console.log('Fetching Vibe Coding course with ID:', id);
        
        const { data, error } = await supabase
          .from('courses')
          .select(`
            *,
            modules (
              *,
              lessons (*)
            )
          `)
          .eq('id', id)
          .single();

        if (error) {
          throw error;
        }

        if (!data) {
          throw new Error('Course not found');
        }

        setCourse(data);
        
        // Flatten all lessons into a single array
        const lessons = [];
        if (data.modules) {
          data.modules.forEach(module => {
            if (module.lessons) {
              module.lessons.forEach(lesson => {
                lessons.push({
                  ...lesson,
                  module: {
                    id: module.id,
                    title: module.title
                  }
                });
              });
            }
          });
        }
        
        // Sort lessons by module ordering, then by lesson ordering
        lessons.sort((a, b) => {
          const moduleA = data.modules.find(m => m.id === a.module.id);
          const moduleB = data.modules.find(m => m.id === b.module.id);
          
          if (moduleA.ordering !== moduleB.ordering) {
            return moduleA.ordering - moduleB.ordering;
          }
          return a.ordering - b.ordering;
        });
        
        setAllLessons(lessons);
        console.log('Fetched lessons:', lessons);
      } catch (err) {
        console.error('Error fetching course:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    if (id) {
      fetchCourse();
    }
  }, [id]);

  const handleNextLesson = () => {
    if (currentLessonIndex < allLessons.length - 1) {
      setCurrentLessonIndex(prev => prev + 1);
    }
  };

  const handlePreviousLesson = () => {
    if (currentLessonIndex > 0) {
      setCurrentLessonIndex(prev => prev - 1);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading your Vibe Coding course...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="text-red-500 text-2xl mb-4">⚠️</div>
          <h2 className="text-2xl font-bold text-gray-800 mb-2">Error Loading Course</h2>
          <p className="text-gray-600 mb-4">{error}</p>
          <button
            onClick={() => window.location.reload()}
            className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors"
          >
            Try Again
          </button>
        </div>
      </div>
    );
  }

  if (!course || allLessons.length === 0) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="text-gray-400 text-2xl mb-4">📚</div>
          <h2 className="text-2xl font-bold text-gray-800 mb-2">Course Not Found</h2>
          <p className="text-gray-600">The Vibe Coding course you're looking for doesn't exist or hasn't been published yet.</p>
        </div>
      </div>
    );
  }

  const currentLesson = allLessons[currentLessonIndex];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Course Header */}
      <div className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 py-6 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between">
            <div>
              <h1 className="text-3xl font-bold text-gray-900">{course.title}</h1>
              <p className="mt-2 text-gray-600">{course.description}</p>
            </div>
            <div className="mt-4 md:mt-0">
              <div className="flex items-center">
                <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                  {course.level.charAt(0).toUpperCase() + course.level.slice(1)}
                </span>
                <span className="ml-2 inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                  {course.duration}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Course Content */}
      <div className="max-w-7xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
          {/* Course Navigation */}
          <div className="lg:col-span-1">
            <div className="bg-white rounded-lg shadow-sm p-6 sticky top-8">
              <h2 className="text-lg font-semibold text-gray-900 mb-4">Course Content</h2>
              
              <div className="space-y-6">
                {course.modules?.map((module) => (
                  <div key={module.id}>
                    <h3 className="font-medium text-gray-800 mb-2">{module.title}</h3>
                    <ul className="space-y-1">
                      {module.lessons?.map((lesson) => {
                        // Find the flattened lesson to get the correct index
                        const flatLesson = allLessons.find(l => l.id === lesson.id);
                        const lessonIndex = allLessons.findIndex(l => l.id === lesson.id);
                        const isCurrent = flatLesson && flatLesson.id === currentLesson?.id;
                        
                        return (
                          <li key={lesson.id}>
                            <button
                              onClick={() => setCurrentLessonIndex(lessonIndex)}
                              className={`w-full text-left px-3 py-2 rounded-md text-sm ${
                                isCurrent
                                  ? 'bg-blue-100 text-blue-700 font-medium'
                                  : 'text-gray-600 hover:bg-gray-100'
                              }`}
                            >
                              <span className="mr-2">
                                {lessonIndex + 1}.
                              </span>
                              {lesson.title}
                            </button>
                          </li>
                        );
                      })}
                    </ul>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Lesson Content */}
          <div className="lg:col-span-3">
            <div className="bg-white rounded-lg shadow-sm overflow-hidden">
              {currentLesson ? (
                <VibeCodingLesson
                  lesson={currentLesson}
                  onNext={handleNextLesson}
                  onPrevious={handlePreviousLesson}
                  currentLessonIndex={currentLessonIndex}
                  totalLessons={allLessons.length}
                />
              ) : (
                <div className="p-12 text-center">
                  <div className="text-gray-400 text-4xl mb-4">📘</div>
                  <h3 className="text-xl font-medium text-gray-900 mb-2">No Lesson Selected</h3>
                  <p className="text-gray-500">Please select a lesson from the course navigation.</p>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default VibeCodingCourse;