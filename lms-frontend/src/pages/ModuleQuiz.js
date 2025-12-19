import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import { digitalMarketingCourses } from "../data/digitalMarketingCourses";

const ModuleQuiz = () => {
    const { id } = useParams();
    const course = digitalMarketingCourses.find(c => c.id === id);
    const questions = course?.moduleQuiz || [];
    const [quizStep, setQuizStep] = useState(0);
    const [quizAnswers, setQuizAnswers] = useState([]);
    const [quizCompleted, setQuizCompleted] = useState(false);
    const [quizTimer, setQuizTimer] = useState(1200); // 20 minutes for 50 questions
    const [quizInterval, setQuizInterval] = useState(null);

    useEffect(() => {
        if (questions.length > 0 && !quizCompleted) {
            setQuizAnswers(Array(questions.length).fill(null));
            setQuizStep(0);
            setQuizTimer(1200);
            if (quizInterval)
                clearInterval(quizInterval);
            const interval = setInterval(() => setQuizTimer(t => t > 0 ? t - 1 : 0), 1000);
            setQuizInterval(interval);
            return () => clearInterval(interval);
        }
        // eslint-disable-next-line
    }, [id]);

    useEffect(() => {
        if (quizTimer === 0 && quizInterval) {
            clearInterval(quizInterval);
            setQuizCompleted(true);
        }
    }, [quizTimer, quizInterval]);

    const handleQuizAnswer = (idx) => {
        if (!questions.length)
            return;
        const updated = [...quizAnswers];
        updated[quizStep] = idx;
        setQuizAnswers(updated);
    };

    const handleQuizNext = () => {
        if (quizStep < questions.length - 1) {
            setQuizStep(quizStep + 1);
        } else {
            setQuizCompleted(true);
            if (quizInterval)
                clearInterval(quizInterval);
        }
    };

    const handleQuizPrev = () => {
        if (quizStep > 0)
            setQuizStep(quizStep - 1);
    };

    const quizScore = questions.length ? quizAnswers.filter((a, i) => a === questions[i].correctAnswer).length : 0;
    const badgeEarned = quizScore >= 45;

    if (!course) {
        return <div className="min-h-screen flex items-center justify-center">Course Not Found</div>;
    }

    return (<div className="min-h-screen bg-gray-50">
      <div className="max-w-2xl mx-auto px-4 py-8">
        <h1 className="text-2xl font-bold mb-4 text-center">{course.title} - Module Quiz</h1>
        <div className="mb-6 text-center">
          <Link to="/my-courses" className="text-brand-cyan hover:underline">← Back to My Courses</Link>
        </div>
        {questions.length === 0 ? (<div className="text-center">No module quiz available for this course.</div>) : (<div className="bg-white rounded-lg shadow-md p-6 border border-blue-100">
            <div className="flex items-center justify-between mb-2">
              <span className="font-medium">Question {quizStep + 1} of {questions.length}</span>
              <span className="text-sm text-red-600">Time left: {quizTimer}s</span>
            </div>
            {!quizCompleted ? (<>
                <div className="mb-2 font-medium">{questions[quizStep].question}</div>
                <div className="space-y-2">
                  {questions[quizStep].options.map((option, idx) => (<button key={idx} onClick={() => handleQuizAnswer(idx)} className={`block w-full text-left px-4 py-2 rounded-lg border transition-colors
                        ${quizAnswers[quizStep] === idx ? (idx === questions[quizStep].correctAnswer ? 'bg-green-100 border-green-400 text-green-800' : 'bg-red-100 border-red-400 text-red-800') : 'bg-gray-50 border-gray-200 hover:bg-blue-50'}`} disabled={quizAnswers[quizStep] !== null}>
                      {option}
                    </button>))}
                </div>
                {quizAnswers[quizStep] !== null && (<div className={`mt-4 font-semibold ${quizAnswers[quizStep] === questions[quizStep].correctAnswer ? 'text-green-700' : 'text-red-700'}`}>
                    {quizAnswers[quizStep] === questions[quizStep].correctAnswer ? 'Correct! 🎉' : 'Incorrect.'}
                    {questions[quizStep].explanation && (<div className="text-sm mt-1 text-gray-600">{questions[quizStep].explanation}</div>)}
                  </div>)}
                <div className="flex justify-between mt-6">
                  <button onClick={handleQuizPrev} disabled={quizStep === 0} className="btn-secondary disabled:opacity-50">Previous</button>
                  {quizStep < questions.length - 1 ? (<button onClick={handleQuizNext} disabled={quizAnswers[quizStep] === null} className="btn-primary disabled:opacity-50">Next</button>) : (<button onClick={handleQuizNext} disabled={quizAnswers[quizStep] === null} className="btn-primary disabled:opacity-50">Finish</button>)}
                </div>
              </>) : (<div className="text-center">
                <div className="text-2xl font-bold mb-2">Quiz Complete!</div>
                <div className="mb-2">Your score: <span className="font-semibold">{quizScore} / {questions.length}</span></div>
                {badgeEarned ? (<div className="mb-2 text-green-700 font-semibold flex flex-col items-center">
                    <span className="text-4xl mb-1">🏅</span>
                    Congratulations! You earned a badge for scoring {quizScore} out of {questions.length}!
                  </div>) : (<div className="mb-2 text-yellow-700 font-semibold">Score at least 45/50 to earn a badge.</div>)}
                <div className="mt-4">
                  <Link to={`/course/${course.id}`} className="btn-primary">Back to My Courses</Link>
                </div>
              </div>)}
          </div>)}
      </div>
    </div>);
};

export default ModuleQuiz;