import React, { useState, useEffect } from "react";
import { useParams, useNavigate, useLocation, Link } from "react-router-dom";
import VideoPlayer from "./VideoPlayer";
import InteractivePlayground from "./InteractivePlayground";
import ContentRenderer from "./ContentRenderer";

const LessonViewer = ({ course, lessonId, onLessonComplete }) => {
  const params = useParams();
  const effectiveLessonId = lessonId || params.lessonId;
  const navigate = useNavigate();
  const location = useLocation();
  const [currentLesson, setCurrentLesson] = useState(null);
  const [videoProgress, setVideoProgress] = useState(0);
  const [isLessonCompleted, setIsLessonCompleted] = useState(false);
  const [activeTab, setActiveTab] = useState('content'); // 'content', 'quiz', 'playground'
  const [showResources, setShowResources] = useState(false);

  // Quiz State
  const [selectedQuizAnswer, setSelectedQuizAnswer] = useState(null);
  const [quizStep, setQuizStep] = useState(0);
  const [quizAnswers, setQuizAnswers] = useState([]);
  const [quizCompleted, setQuizCompleted] = useState(false);
  const [quizTimer, setQuizTimer] = useState(300); // 5 minutes
  const [quizInterval, setQuizInterval] = useState(null);

  // Playground State
  const [playgroundTab, setPlaygroundTab] = useState('code');

  useEffect(() => {
    if (effectiveLessonId && course.lessons) {
      const lesson = course.lessons.find(l => l.id === effectiveLessonId);
      setCurrentLesson(lesson || null);
      // Reset states for new lesson
      setVideoProgress(0);
      setIsLessonCompleted(lesson?.isCompleted || false);
      setActiveTab('content'); // Default to content on new lesson
      setQuizCompleted(false);
    }
  }, [effectiveLessonId, course.lessons]);

  // Quiz Timer Logic
  useEffect(() => {
    if (!currentLesson || activeTab !== 'quiz' || quizCompleted) return;

    // Initialize quiz state if needed
    if (quizAnswers.length === 0 && currentLesson.quiz) {
      setQuizAnswers(Array(currentLesson.quiz.length).fill(null));
    }

    if (quizInterval) clearInterval(quizInterval);
    const interval = setInterval(() => setQuizTimer(t => t > 0 ? t - 1 : 0), 1000);
    setQuizInterval(interval);
    return () => clearInterval(interval);
  }, [currentLesson, activeTab, quizCompleted]);

  const handleVideoProgress = (progress) => {
    setVideoProgress(progress);
    if (progress >= 90 && !isLessonCompleted) {
      setIsLessonCompleted(true);
      if (onLessonComplete && currentLesson) {
        onLessonComplete(currentLesson.id);
      }
    }
  };

  const handleVideoComplete = () => {
    setIsLessonCompleted(true);
    if (onLessonComplete && currentLesson) {
      onLessonComplete(currentLesson.id);
    }
  };

  const handleNextLesson = () => {
    if (!currentLesson) return;
    const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
    const nextLesson = course.lessons[currentIndex + 1];
    if (nextLesson) {
      navigate(`/course/${course.id}/lesson/${nextLesson.id}`);
    }
  };

  const handlePreviousLesson = () => {
    if (!currentLesson) return;
    const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
    const prevLesson = course.lessons[currentIndex - 1];
    if (prevLesson) {
      navigate(`/course/${course.id}/lesson/${prevLesson.id}`);
    }
  };

  // Quiz Handlers
  const handleQuizAnswer = (idx) => {
    const updated = [...quizAnswers];
    updated[quizStep] = idx;
    setQuizAnswers(updated);
  };

  const handleQuizNext = () => {
    if (quizStep < (currentLesson?.quiz?.length || 0) - 1) {
      setQuizStep(quizStep + 1);
    } else {
      setQuizCompleted(true);
      if (quizInterval) clearInterval(quizInterval);
    }
  };

  const handleQuizPrev = () => {
    if (quizStep > 0) setQuizStep(quizStep - 1);
  };

  const quizScore = currentLesson?.quiz ? quizAnswers.filter((a, i) => a === currentLesson.quiz[i].correctAnswer).length : 0;

  if (!currentLesson) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Lesson Not Found</h2>
          <button className="btn-primary" onClick={() => navigate('/dashboard')}>Back to Dashboard</button>
        </div>
      </div>
    );
  }

  const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
  const hasNextLesson = currentIndex < course.lessons.length - 1;
  const hasPreviousLesson = currentIndex > 0;
  const videoUrl = currentLesson?.videoUrl || "";

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Header */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div>
              <Link to="/my-courses" className="text-brand-navy hover:underline flex items-center mb-2 text-sm">
                ← Back to My Courses
              </Link>
              <h1 className="text-xl font-heading font-bold text-gray-900">
                {course.title}
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-600">Lesson {currentIndex + 1} of {course.lessons.length}</span>
              {isLessonCompleted && (
                <span className="px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                  ✓ COMPLETED
                </span>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 w-full grid grid-cols-1 lg:grid-cols-3 gap-8">

        {/* Main Content Area */}
        <div className="lg:col-span-2 flex flex-col">

          {/* Tabs */}
          <div className="bg-white rounded-t-lg border-b border-gray-200 flex">
            <button
              onClick={() => setActiveTab('content')}
              className={`flex-1 py-4 text-sm font-bold text-center border-b-2 transition-colors ${activeTab === 'content' ? 'border-brand-cyan text-brand-navy' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              📺 Lesson & Video
            </button>
            <button
              onClick={() => setActiveTab('playground')}
              className={`flex-1 py-4 text-sm font-bold text-center border-b-2 transition-colors ${activeTab === 'playground' ? 'border-brand-cyan text-brand-navy' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              🤖 AI Playground
            </button>
            <button
              onClick={() => setActiveTab('quiz')}
              className={`flex-1 py-4 text-sm font-bold text-center border-b-2 transition-colors ${activeTab === 'quiz' ? 'border-brand-cyan text-brand-navy' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              📝 Quiz
            </button>
          </div>

          <div className="bg-white rounded-b-lg shadow-sm p-6 min-h-[500px]">

            {/* TAB: CONTENT */}
            {activeTab === 'content' && (
              <div className="animate-fade-in">
                <div className="mb-6 rounded-lg overflow-hidden shadow-inner bg-black">
                  <VideoPlayer videoUrl={videoUrl} title={currentLesson.title} onProgress={handleVideoProgress} onComplete={handleVideoComplete} autoPlay={false} />
                </div>

                <h2 className="text-2xl font-heading font-bold text-gray-900 mb-4">{currentLesson.title}</h2>

                {/* Use ContentRenderer for mermaid diagram support */}
                {currentLesson.description && (
                  <ContentRenderer
                    content={currentLesson.description}
                    className="prose prose-sm prose-slate max-w-none text-gray-700 mb-8 prose-headings:font-heading prose-headings:text-brand-navy prose-a:text-brand-cyan"
                  />
                )}

                <div className="flex justify-between mt-8 pt-6 border-t border-gray-100">
                  <button onClick={handlePreviousLesson} disabled={!hasPreviousLesson} className="btn-secondary disabled:opacity-50">← Previous</button>
                  <button onClick={handleNextLesson} disabled={!hasNextLesson} className="btn-primary disabled:opacity-50">Next Lesson →</button>
                </div>
              </div>
            )}

            {/* TAB: PLAYGROUND */}
            {activeTab === 'playground' && (
              <div className="h-full animate-fade-in">
                <div className="bg-gray-50 p-4 rounded-lg mb-4 border border-gray-200">
                  <h3 className="text-lg font-bold text-brand-navy mb-2">Interactive AI Workspace</h3>
                  <p className="text-sm text-gray-600">Experiment with the concepts from this lesson directly in the browser.</p>
                </div>
                <InteractivePlayground
                  activeTab={playgroundTab}
                  onTabChange={setPlaygroundTab}
                  lesson={currentLesson}
                />
              </div>
            )}

            {/* TAB: QUIZ */}
            {activeTab === 'quiz' && (
              <div className="animate-fade-in">
                {currentLesson.quiz && currentLesson.quiz.length > 0 ? (
                  <div className="max-w-2xl mx-auto">
                    <div className="flex justify-between items-center mb-6">
                      <span className="text-sm font-bold text-gray-500 uppercase tracking-wide">Question {quizStep + 1} of {currentLesson.quiz.length}</span>
                      <span className="text-sm font-mono bg-gray-100 px-3 py-1 rounded text-red-600">{quizTimer}s remaining</span>
                    </div>

                    {!quizCompleted ? (
                      <div>
                        <h3 className="text-xl font-bold text-gray-900 mb-6">{currentLesson.quiz[quizStep].question}</h3>
                        <div className="space-y-3">
                          {currentLesson.quiz[quizStep].options.map((option, idx) => (
                            <button
                              key={idx}
                              onClick={() => handleQuizAnswer(idx)}
                              className={`w-full text-left p-4 rounded-lg border-2 transition-all ${quizAnswers[quizStep] === idx
                                ? 'border-brand-cyan bg-cyan-50 text-brand-navy font-bold shadow-md'
                                : 'border-gray-200 hover:border-brand-cyan hover:bg-gray-50 text-gray-700'
                                }`}
                            >
                              {option}
                            </button>
                          ))}
                        </div>

                        <div className="mt-8 flex justify-end">
                          <button
                            onClick={handleQuizNext}
                            disabled={quizAnswers[quizStep] === null}
                            className="btn-primary disabled:opacity-50 disabled:cursor-not-allowed"
                          >
                            {quizStep < currentLesson.quiz.length - 1 ? 'Next Question →' : 'Finish Quiz'}
                          </button>
                        </div>
                      </div>
                    ) : (
                      <div className="text-center py-12">
                        <div className="text-6xl mb-4">🏆</div>
                        <h3 className="text-2xl font-bold text-gray-900 mb-2">Quiz Completed!</h3>
                        <p className="text-lg text-gray-600 mb-6">You scored <span className="font-bold text-brand-cyan">{quizScore} / {currentLesson.quiz.length}</span></p>
                        <div className="flex justify-center space-x-4">
                          <button onClick={() => {
                            setQuizStep(0);
                            setQuizAnswers(Array(currentLesson.quiz.length).fill(null));
                            setQuizCompleted(false);
                            setQuizTimer(300);
                          }} className="btn-secondary">Retry Quiz</button>
                          <button onClick={handleNextLesson} disabled={!hasNextLesson} className="btn-primary">Continue to Next Lesson</button>
                        </div>
                      </div>
                    )}
                  </div>
                ) : (
                  <div className="text-center py-12 bg-gray-50 rounded-lg border border-dashed border-gray-300">
                    <div className="text-4xl mb-4">📝</div>
                    <h3 className="text-xl font-bold text-gray-900 mb-2">No Quiz Available</h3>
                    <p className="text-gray-600">This lesson doesn't have a quiz yet. Continue to the next lesson!</p>
                    <button onClick={handleNextLesson} className="mt-6 btn-primary">Next Lesson →</button>
                  </div>
                )}
              </div>
            )}

          </div>
        </div>

        {/* Sidebar */}
        <div className="lg:col-span-1">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden sticky top-6">
            <div className="p-4 bg-gray-50 border-b border-gray-200">
              <h3 className="font-heading font-bold text-gray-900">Course Curriculum</h3>
            </div>
            <div className="max-h-[600px] overflow-y-auto p-2">
              {course.lessons.map((lesson, index) => (
                <Link
                  key={lesson.id}
                  to={`/course/${course.id}/lesson/${lesson.id}`}
                  className={`block p-3 mb-1 rounded-md transition-all ${lesson.id === currentLesson.id
                    ? 'bg-brand-navy text-white shadow-md transform scale-[1.02]'
                    : lesson.isCompleted
                      ? 'bg-green-50 text-green-800 border border-green-100 hover:bg-green-100'
                      : 'text-gray-600 hover:bg-gray-100'
                    }`}
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-3">
                      <span className={`flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold ${lesson.id === currentLesson.id ? 'bg-white/20' : 'bg-gray-200'
                        }`}>
                        {lesson.isCompleted ? '✓' : index + 1}
                      </span>
                      <span className="text-sm font-medium truncate max-w-[160px]">{lesson.title}</span>
                    </div>
                    <span className="text-xs opacity-70">{lesson.duration}</span>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </div>

      </div>
    </div>
  );
};

export default LessonViewer;