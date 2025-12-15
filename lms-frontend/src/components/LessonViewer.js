import React, { useState, useEffect } from "react";
import { useParams, useNavigate, useLocation, Link } from "react-router-dom";
import VideoPlayer from "./VideoPlayer";

const LessonViewer = ({ course, lessonId, onLessonComplete }) => {
    const params = useParams();
    const effectiveLessonId = lessonId || params.lessonId;
    const navigate = useNavigate();
    const location = useLocation();
    const [currentLesson, setCurrentLesson] = useState(null);
    const [videoProgress, setVideoProgress] = useState(0);
    const [isLessonCompleted, setIsLessonCompleted] = useState(false);
    const [showNotes, setShowNotes] = useState(false);
    const [notes, setNotes] = useState('');
    const [showResources, setShowResources] = useState(false);
    const [selectedQuizAnswer, setSelectedQuizAnswer] = useState(null);
    const [quizStep, setQuizStep] = useState(0);
    const [quizAnswers, setQuizAnswers] = useState([]);
    const [quizCompleted, setQuizCompleted] = useState(false);
    const [quizTimer, setQuizTimer] = useState(300); // 5 minutes for 20 questions
    const [quizInterval, setQuizInterval] = useState(null);

    useEffect(() => {
        if (effectiveLessonId && course.lessons) {
            const lesson = course.lessons.find(l => l.id === effectiveLessonId);
            setCurrentLesson(lesson || null);
            // Reset states for new lesson
            setVideoProgress(0);
            setIsLessonCompleted(lesson?.isCompleted || false);
            setNotes('');
        }
    }, [effectiveLessonId, course.lessons]);

    useEffect(() => {
        if (!currentLesson || !currentLesson.quiz || quizCompleted)
            return;
        setQuizAnswers(Array(currentLesson.quiz.length).fill(null));
        setQuizStep(0);
        setQuizTimer(300);
        if (quizInterval)
            clearInterval(quizInterval);
        const interval = setInterval(() => setQuizTimer(t => t > 0 ? t - 1 : 0), 1000);
        setQuizInterval(interval);
        return () => clearInterval(interval);
        // eslint-disable-next-line
    }, [currentLesson]);

    useEffect(() => {
        if (quizTimer === 0 && quizInterval) {
            clearInterval(quizInterval);
            setQuizCompleted(true);
        }
    }, [quizTimer, quizInterval]);

    const handleVideoProgress = (progress) => {
        setVideoProgress(progress);
        // Mark lesson as completed when video is 90% watched
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
        if (!currentLesson)
            return;
        const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
        const nextLesson = course.lessons[currentIndex + 1];
        if (nextLesson) {
            navigate(`/course/${course.id}/lesson/${nextLesson.id}`);
        }
    };

    const handlePreviousLesson = () => {
        if (!currentLesson)
            return;
        const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
        const prevLesson = course.lessons[currentIndex - 1];
        if (prevLesson) {
            navigate(`/course/${course.id}/lesson/${prevLesson.id}`);
        }
    };

    const saveNotes = () => {
        // In a real app, this would save to backend
        localStorage.setItem(`notes_${currentLesson?.id}`, notes);
    };

    const loadNotes = () => {
        const savedNotes = localStorage.getItem(`notes_${currentLesson?.id}`);
        if (savedNotes) {
            setNotes(savedNotes);
        }
    };

    useEffect(() => {
        loadNotes();
    }, [currentLesson?.id]);

    const handleQuizAnswer = (idx) => {
        if (!currentLesson || !currentLesson.quiz)
            return;
        const updated = [...quizAnswers];
        updated[quizStep] = idx;
        setQuizAnswers(updated);
    };

    const handleQuizNext = () => {
        if (!currentLesson || !currentLesson.quiz)
            return;
        if (quizStep < currentLesson.quiz.length - 1) {
            setQuizStep(quizStep + 1);
        }
        else {
            setQuizCompleted(true);
            if (quizInterval)
                clearInterval(quizInterval);
        }
    };

    const handleQuizPrev = () => {
        if (quizStep > 0)
            setQuizStep(quizStep - 1);
    };

    const quizScore = currentLesson && currentLesson.quiz ? quizAnswers.filter((a, i) => { var _a; return a === ((_a = currentLesson.quiz) === null || _a === void 0 ? void 0 : _a[i].correctAnswer); }).length : 0;

    if (!currentLesson) {
        return (<div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="text-6xl mb-4">📚</div>
          <h2 className="text-2xl font-heading font-semibold text-gray-900 mb-2">
            Lesson Not Found
          </h2>
          <p className="text-gray-600 mb-6">
            The lesson you're looking for doesn't exist.
          </p>
          <button className="btn-primary" onClick={() => { sessionStorage.removeItem('fromDashboard'); navigate('/dashboard/my-course'); }}>
            Go Back to Dashboard
          </button>
        </div>
      </div>);
    }

    const currentIndex = course.lessons.findIndex(l => l.id === currentLesson.id);
    const hasNextLesson = currentIndex < course.lessons.length - 1;
    const hasPreviousLesson = currentIndex > 0;
    // TODO: Replace with actual lesson video URL from lesson data    
    const videoUrl = currentLesson?.videoUrl || "";

    return (<div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div>
              <Link to="/my-courses" className="text-indigo-700 hover:underline flex items-center mb-4">
                <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7"></path></svg>
                Back to My Courses
              </Link>
              <h1 className="text-xl font-heading font-semibold text-gray-900 mt-1">
                {course.title}
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-600">
                Lesson {currentIndex + 1} of {course.lessons.length}
              </span>
              {isLessonCompleted && (<span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                  ✓ Completed
                </span>)}
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2">
            {/* Video Player */}
            <div className="bg-white rounded-lg shadow-sm overflow-hidden mb-6">
              <VideoPlayer videoUrl={videoUrl} title={currentLesson.title} onProgress={handleVideoProgress} onComplete={handleVideoComplete} autoPlay={false}/>
            </div>

            {/* Lesson Content */}
            <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-4">
                {currentLesson.title}
              </h2>
              <p className="text-gray-600 mb-6">
                {currentLesson.description || 'This lesson covers important concepts and practical applications.'}
              </p>

              {/* Lesson Details */}
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                <div className="lesson-3d-card duration">
                  <div className="text-2xl font-bold">{currentLesson.duration}</div>
                  <div className="text-sm">Duration</div>
                </div>
                <div className="lesson-3d-card progress">
                  <div className="text-2xl font-bold">{isNaN(videoProgress) || typeof videoProgress !== 'number' ? 0 : Math.round(videoProgress)}%</div>
                  <div className="text-sm">Progress</div>
                </div>
                <div className="lesson-3d-card lesson">
                  <div className="text-2xl font-bold">{currentLesson.order}</div>
                  <div className="text-sm">Lesson</div>
                </div>
                <div className="lesson-3d-card status">
                  <div className="text-2xl font-bold">{isLessonCompleted ? '✓' : '○'}</div>
                  <div className="text-sm">Status</div>
                </div>
              </div>

              {/* Multi-question Quiz Section */}
              {currentLesson && currentLesson.quiz && (<div className="bg-white rounded-lg shadow-md p-6 mb-6 mt-4 border border-blue-100">
                  <h3 className="text-lg font-heading font-semibold mb-4 text-blue-700">Quiz</h3>
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium">Question {quizStep + 1} of {currentLesson.quiz.length}</span>
                    <span className="text-sm text-red-600">Time left: {quizTimer}s</span>
                  </div>
                  {!quizCompleted ? (<>
                      <div className="mb-2 font-medium">{currentLesson.quiz[quizStep].question}</div>
                      <div className="space-y-2">
                        {currentLesson.quiz[quizStep].options.map((option, idx) => {
                    var _a;
                    return (<button key={idx} onClick={() => handleQuizAnswer(idx)} className={`block w-full text-left px-4 py-2 rounded-lg border transition-colors
                              ${quizAnswers[quizStep] === idx ? (idx === ((_a = currentLesson.quiz) === null || _a === void 0 ? void 0 : _a[quizStep].correctAnswer) ? 'bg-green-100 border-green-400 text-green-800' : 'bg-red-100 border-red-400 text-red-800') : 'bg-gray-50 border-gray-200 hover:bg-blue-50'}`} disabled={quizAnswers[quizStep] !== null}>
                            {option}
                          </button>);
                })}
                      </div>
                      {quizAnswers[quizStep] !== null && (<div className={`mt-4 font-semibold ${quizAnswers[quizStep] === currentLesson.quiz[quizStep].correctAnswer ? 'text-green-700' : 'text-red-700'}`}>
                          {quizAnswers[quizStep] === currentLesson.quiz[quizStep].correctAnswer ? 'Correct! 🎉' : 'Incorrect.'}
                          {currentLesson.quiz[quizStep].explanation && (<div className="text-sm mt-1 text-gray-600">{currentLesson.quiz[quizStep].explanation}</div>)}
                        </div>)}
                      <div className="flex justify-between mt-6">
                        <button onClick={handleQuizPrev} disabled={quizStep === 0} className="btn-secondary disabled:opacity-50">Previous</button>
                        {quizStep < currentLesson.quiz.length - 1 ? (<button onClick={handleQuizNext} disabled={quizAnswers[quizStep] === null} className="btn-primary disabled:opacity-50">Next</button>) : (<button onClick={handleQuizNext} disabled={quizAnswers[quizStep] === null} className="btn-primary disabled:opacity-50">Finish</button>)}
                      </div>
                    </>) : (<div className="text-center">
                      <div className="text-2xl font-bold mb-2">Quiz Complete!</div>
                      <div className="mb-2">Your score: <span className="font-semibold">{quizScore} / {currentLesson.quiz.length}</span></div>
                      <div className="mb-2">{quizScore === currentLesson.quiz.length ? 'Perfect score! 🎉' : quizScore > 0 ? 'Good job! Review the explanations above.' : 'Try again next time!'}</div>
                    </div>)}
                </div>)}

              {/* Action Buttons */}
              <div className="flex flex-wrap gap-4">
                <button onClick={() => setShowNotes(!showNotes)} className="btn-secondary">
                  {showNotes ? 'Hide Notes' : 'Take Notes'}
                </button>
                <button onClick={() => setShowResources(!showResources)} className="btn-secondary">
                  {showResources ? 'Hide Resources' : 'View Resources'}
                </button>
                {isLessonCompleted && (<button className="btn-primary">
                    Mark as Complete
                  </button>)}
              </div>
            </div>

            {/* Notes Section */}
            {showNotes && (<div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                <h3 className="text-lg font-heading font-semibold text-gray-900 mb-4">
                  My Notes
                </h3>
                <textarea value={notes} onChange={(e) => setNotes(e.target.value)} placeholder="Take notes during this lesson..." className="w-full h-32 p-3 border border-gray-300 rounded-lg resize-none focus:ring-2 focus:ring-brand-cyan focus:border-transparent"/>
                <div className="flex justify-end mt-4">
                  <button onClick={saveNotes} className="btn-primary">
                    Save Notes
                  </button>
                </div>
              </div>)}

            {/* Resources Section */}
            {showResources && (<div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                <h3 className="text-lg font-heading font-semibold text-gray-900 mb-4">
                  Lesson Resources
                </h3>
                <div className="space-y-3">
                  <div className="flex items-center p-3 border border-gray-200 rounded-lg">
                    <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clipRule="evenodd"/>
                    </svg>
                    <span className="text-gray-700">Lesson Slides (PDF)</span>
                    <button className="ml-auto text-brand-cyan hover:text-brand-navy font-medium">
                      Download
                    </button>
                  </div>
                  <div className="flex items-center p-3 border border-gray-200 rounded-lg">
                    <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clipRule="evenodd"/>
                    </svg>
                    <span className="text-gray-700">Practice Exercises</span>
                    <button className="ml-auto text-brand-cyan hover:text-brand-navy font-medium">
                      Download
                    </button>
                  </div>
                  <div className="flex items-center p-3 border border-gray-200 rounded-lg">
                    <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clipRule="evenodd"/>
                    </svg>
                    <span className="text-gray-700">Reference Guide</span>
                    <button className="ml-auto text-brand-cyan hover:text-brand-navy font-medium">
                      Download
                    </button>
                  </div>
                </div>
              </div>)}

            {/* Navigation */}
            <div className="flex justify-between">
              <button onClick={handlePreviousLesson} disabled={!hasPreviousLesson} className="btn-secondary disabled:opacity-50 disabled:cursor-not-allowed">
                ← Previous Lesson
              </button>
              <button onClick={handleNextLesson} disabled={!hasNextLesson} className="btn-primary disabled:opacity-50 disabled:cursor-not-allowed">
                Next Lesson →
              </button>
            </div>
          </div>

          {/* Sidebar */}
          <div className="lg:col-span-1">
            <div className="bg-white rounded-lg shadow-sm">
              <div className="p-6 border-b border-gray-200">
                <h3 className="text-lg font-heading font-semibold text-gray-900">
                  Course Curriculum
                </h3>
              </div>
              <div className="p-6">
                <div className="space-y-2">
                  {course.lessons.map((lesson, index) => (<Link key={lesson.id} to={`/course/${course.id}/lesson/${lesson.id}`} className={`block p-3 rounded-lg transition-colors ${lesson.id === currentLesson.id
                ? 'bg-brand-cyan text-white'
                : lesson.isCompleted
                    ? 'bg-green-50 text-green-700 hover:bg-green-100'
                    : 'text-gray-700 hover:bg-gray-50'}`}>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center space-x-3">
                          <div className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium">
                            {lesson.isCompleted ? '✓' : index + 1}
                          </div>
                          <span className="font-medium">{lesson.title}</span>
                        </div>
                        <span className="text-sm opacity-75">
                          {lesson.duration}
                        </span>
                      </div>
                    </Link>))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>);
};

export default LessonViewer;