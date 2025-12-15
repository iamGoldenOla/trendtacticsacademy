import React, { useState, useEffect } from "react";

const GameActivity = ({ activity, onComplete, onClose }) => {
    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const [selectedAnswers, setSelectedAnswers] = useState([]);
    const [score, setScore] = useState(0);
    const [timeLeft, setTimeLeft] = useState(activity.timeLimit || 300);
    const [gameStarted, setGameStarted] = useState(false);
    const [gameCompleted, setGameCompleted] = useState(false);
    const [showExplanation, setShowExplanation] = useState(false);
    const [dragItems, setDragItems] = useState([]);
    const [dropZones, setDropZones] = useState({});
    const [memoryCards, setMemoryCards] = useState([]);
    const [flippedCards, setFlippedCards] = useState([]);

    useEffect(() => {
        if (gameStarted && activity.timeLimit && timeLeft > 0) {
            const timer = setTimeout(() => setTimeLeft(timeLeft - 1), 1000);
            return () => clearTimeout(timer);
        }
        else if (timeLeft === 0) {
            handleGameComplete();
        }
    }, [gameStarted, timeLeft]);

    useEffect(() => {
        if (activity.type === 'memory') {
            initializeMemoryGame();
        }
        else if (activity.type === 'drag-drop') {
            initializeDragDropGame();
        }
    }, [activity]);

    const initializeMemoryGame = () => {
        const pairs = [
            { term: 'SEO', definition: 'Search Engine Optimization' },
            { term: 'PPC', definition: 'Pay-Per-Click' },
            { term: 'CRO', definition: 'Conversion Rate Optimization' },
            { term: 'CTR', definition: 'Click-Through Rate' },
            { term: 'ROI', definition: 'Return on Investment' },
            { term: 'KPI', definition: 'Key Performance Indicator' }
        ];
        const cards = pairs.flatMap(pair => [
            { id: `term-${pair.term}`, content: pair.term, flipped: false, matched: false },
            { id: `def-${pair.term}`, content: pair.definition, flipped: false, matched: false }
        ]);
        setMemoryCards(cards.sort(() => Math.random() - 0.5));
    };

    const initializeDragDropGame = () => {
        const items = ['Email Marketing', 'Social Media', 'SEO', 'PPC Advertising', 'Content Marketing'];
        setDragItems(items.sort(() => Math.random() - 0.5));
    };

    const startGame = () => {
        setGameStarted(true);
        setSelectedAnswers([]);
        setScore(0);
        setCurrentQuestionIndex(0);
    };

    const handleAnswerSelect = (answer) => {
        const newAnswers = [...selectedAnswers];
        newAnswers[currentQuestionIndex] = answer;
        setSelectedAnswers(newAnswers);
    };

    const handleNextQuestion = () => {
        if (showExplanation) {
            setShowExplanation(false);
            if (currentQuestionIndex < (activity.questions?.length || 0) - 1) {
                setCurrentQuestionIndex(currentQuestionIndex + 1);
            }
            else {
                handleGameComplete();
            }
        }
        else {
            setShowExplanation(true);
            const currentQuestion = activity.questions?.[currentQuestionIndex];
            if (currentQuestion && selectedAnswers[currentQuestionIndex] === currentQuestion.correctAnswer) {
                setScore(score + currentQuestion.points);
            }
        }
    };

    const handleMemoryCardClick = (cardId) => {
        if (flippedCards.length === 2)
            return;
        const newFlippedCards = [...flippedCards, cardId];
        setFlippedCards(newFlippedCards);
        const newMemoryCards = memoryCards.map(card => card.id === cardId ? { ...card, flipped: true } : card);
        setMemoryCards(newMemoryCards);
        if (newFlippedCards.length === 2) {
            setTimeout(() => {
                const [first, second] = newFlippedCards;
                const firstCard = memoryCards.find(c => c.id === first);
                const secondCard = memoryCards.find(c => c.id === second);
                const isMatch = firstCard && secondCard && ((first.startsWith('term-') && second.startsWith('def-') && first.split('-')[1] === second.split('-')[1]) ||
                    (first.startsWith('def-') && second.startsWith('term-') && first.split('-')[1] === second.split('-')[1]));
                if (isMatch) {
                    setMemoryCards(prev => prev.map(card => card.id === first || card.id === second ? { ...card, matched: true } : card));
                    setScore(score + 10);
                }
                else {
                    setMemoryCards(prev => prev.map(card => card.id === first || card.id === second ? { ...card, flipped: false } : card));
                }
                setFlippedCards([]);
                // Check if game is complete
                const allMatched = newMemoryCards.every(card => card.matched || card.id === first || card.id === second);
                if (allMatched && isMatch) {
                    setTimeout(() => handleGameComplete(), 1000);
                }
            }, 1000);
        }
    };

    const handleDragStart = (e, item) => {
        e.dataTransfer.setData('text/plain', item);
    };

    const handleDrop = (e, zone) => {
        e.preventDefault();
        const item = e.dataTransfer.getData('text/plain');
        setDropZones({ ...dropZones, [zone]: item });
        setDragItems(dragItems.filter(i => i !== item));
    };

    const handleGameComplete = () => {
        setGameCompleted(true);
        onComplete(score);
    };

    const formatTime = (seconds) => {
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${mins}:${secs.toString().padStart(2, '0')}`;
    };

    const getDifficultyColor = (difficulty) => {
        switch (difficulty) {
            case 'easy': return 'text-green-600 bg-green-100';
            case 'medium': return 'text-yellow-600 bg-yellow-100';
            case 'hard': return 'text-red-600 bg-red-100';
            default: return 'text-gray-600 bg-gray-100';
        }
    };

    const getTypeIcon = (type) => {
        switch (type) {
            case 'quiz': return '🧠';
            case 'memory': return '🃏';
            case 'drag-drop': return '🎯';
            case 'word-match': return '🔤';
            case 'scenario': return '🎭';
            default: return '🎮';
        }
    };

    if (!gameStarted) {
        return (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-md w-full mx-4 shadow-2xl">
          <div className="text-center">
            <div className="text-6xl mb-4">{getTypeIcon(activity.type)}</div>
            <h2 className="text-2xl font-bold text-gray-900 mb-2">{activity.title}</h2>
            <p className="text-gray-600 mb-4">{activity.description}</p>
            
            <div className="flex justify-center space-x-4 mb-6">
              <span className={`px-3 py-1 rounded-full text-sm font-medium ${getDifficultyColor(activity.difficulty)}`}>
                {activity.difficulty.toUpperCase()}
              </span>
              <span className="px-3 py-1 rounded-full text-sm font-medium text-blue-600 bg-blue-100">
                {activity.points} points
              </span>
              {activity.timeLimit && (<span className="px-3 py-1 rounded-full text-sm font-medium text-purple-600 bg-purple-100">
                  {formatTime(activity.timeLimit)}
                </span>)}
            </div>
            
            <div className="flex space-x-3">
              <button onClick={startGame} className="flex-1 bg-brand-cyan text-white py-3 px-6 rounded-lg font-semibold hover:bg-brand-navy transition-colors">
                Start Game
              </button>
              <button onClick={onClose} className="flex-1 bg-gray-200 text-gray-700 py-3 px-6 rounded-lg font-semibold hover:bg-gray-300 transition-colors">
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>);
    }

    if (gameCompleted) {
        const percentage = activity.questions ? Math.round((score / (activity.questions.reduce((sum, q) => sum + q.points, 0))) * 100) : Math.min(100, score);
        return (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-md w-full mx-4 shadow-2xl">
          <div className="text-center">
            <div className="text-6xl mb-4">{percentage >= 80 ? '🏆' : percentage >= 60 ? '🥈' : '🥉'}</div>
            <h2 className="text-2xl font-bold text-gray-900 mb-2">Game Complete!</h2>
            <p className="text-gray-600 mb-4">You scored {score} points ({percentage}%)</p>
            
            <div className="bg-gray-100 rounded-lg p-4 mb-6">
              <div className="flex justify-between text-sm text-gray-600 mb-2">
                <span>Your Score</span>
                <span>{percentage}%</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-3">
                <div className={`h-3 rounded-full transition-all duration-1000 ${percentage >= 80 ? 'bg-green-500' : percentage >= 60 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${percentage}%` }}></div>
              </div>
            </div>
            
            <button onClick={onClose} className="w-full bg-brand-cyan text-white py-3 px-6 rounded-lg font-semibold hover:bg-brand-navy transition-colors">
              Continue Learning
            </button>
          </div>
        </div>
      </div>);
    }

    // Quiz Game
    if (activity.type === 'quiz' && activity.questions) {
        const currentQuestion = activity.questions[currentQuestionIndex];
        return (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-2xl w-full mx-4 shadow-2xl max-h-[90vh] overflow-y-auto">
          {/* Header */}
          <div className="flex justify-between items-center mb-6">
            <div className="flex items-center space-x-4">
              <span className="text-sm font-medium text-gray-500">
                Question {currentQuestionIndex + 1} of {activity.questions.length}
              </span>
              <span className="text-sm font-medium text-blue-600">
                Score: {score}
              </span>
            </div>
            {activity.timeLimit && (<div className={`text-sm font-medium ${timeLeft < 60 ? 'text-red-600' : 'text-gray-600'}`}>
                ⏱️ {formatTime(timeLeft)}
              </div>)}
          </div>
          
          {/* Progress Bar */}
          <div className="w-full bg-gray-200 rounded-full h-2 mb-6">
            <div className="bg-brand-cyan h-2 rounded-full transition-all duration-300" style={{ width: `${((currentQuestionIndex + 1) / activity.questions.length) * 100}%` }}></div>
          </div>
          
          {!showExplanation ? (<>
              {/* Question */}
              <h3 className="text-xl font-semibold text-gray-900 mb-6">
                {currentQuestion.question}
              </h3>
              
              {/* Options */}
              <div className="space-y-3 mb-6">
                {currentQuestion.options?.map((option, index) => (<button key={index} onClick={() => handleAnswerSelect(index)} className={`w-full text-left p-4 rounded-lg border-2 transition-colors ${selectedAnswers[currentQuestionIndex] === index
                        ? 'border-brand-cyan bg-blue-50 text-brand-navy'
                        : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'}`}>
                    <span className="font-medium mr-3">{String.fromCharCode(65 + index)}.</span>
                    {option}
                  </button>))}
              </div>
              
              {/* Next Button */}
              <button onClick={handleNextQuestion} disabled={selectedAnswers[currentQuestionIndex] === undefined} className="w-full bg-brand-cyan text-white py-3 px-6 rounded-lg font-semibold hover:bg-brand-navy transition-colors disabled:bg-gray-300 disabled:cursor-not-allowed">
                {selectedAnswers[currentQuestionIndex] !== undefined ? 'Check Answer' : 'Select an Answer'}
              </button>
            </>) : (<>
              {/* Explanation */}
              <div className={`p-4 rounded-lg mb-6 ${selectedAnswers[currentQuestionIndex] === currentQuestion.correctAnswer
                    ? 'bg-green-100 border border-green-200'
                    : 'bg-red-100 border border-red-200'}`}>
                <div className="flex items-center mb-2">
                  {selectedAnswers[currentQuestionIndex] === currentQuestion.correctAnswer ? (<span className="text-green-600 font-semibold">✅ Correct! (+{currentQuestion.points} points)</span>) : (<span className="text-red-600 font-semibold">❌ Incorrect</span>)}
                </div>
                {currentQuestion.explanation && (<p className="text-gray-700">{currentQuestion.explanation}</p>)}
              </div>
              
              <button onClick={handleNextQuestion} className="w-full bg-brand-cyan text-white py-3 px-6 rounded-lg font-semibold hover:bg-brand-navy transition-colors">
                {currentQuestionIndex < activity.questions.length - 1 ? 'Next Question' : 'Complete Game'}
              </button>
            </>)}
        </div>
      </div>);
    }

    // Memory Game
    if (activity.type === 'memory') {
        return (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-4xl w-full mx-4 shadow-2xl max-h-[90vh] overflow-y-auto">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-xl font-semibold text-gray-900">Memory Match - Digital Marketing Terms</h3>
            <div className="flex items-center space-x-4">
              <span className="text-sm font-medium text-blue-600">Score: {score}</span>
              {activity.timeLimit && (<span className={`text-sm font-medium ${timeLeft < 60 ? 'text-red-600' : 'text-gray-600'}`}>
                  ⏱️ {formatTime(timeLeft)}
                </span>)}
            </div>
          </div>
          
          <div className="grid grid-cols-4 gap-4 mb-6">
            {memoryCards.map((card) => (<button key={card.id} onClick={() => handleMemoryCardClick(card.id)} disabled={card.flipped || card.matched} className={`aspect-square p-4 rounded-lg border-2 transition-all duration-300 ${card.matched
                    ? 'bg-green-100 border-green-300 text-green-700'
                    : card.flipped
                        ? 'bg-blue-100 border-blue-300 text-blue-700'
                        : 'bg-gray-100 border-gray-300 hover:bg-gray-200'}`}>
                <div className="text-sm font-medium text-center">
                  {card.flipped || card.matched ? card.content : '?'}
                </div>
              </button>))}
          </div>
          
          <button onClick={onClose} className="w-full bg-gray-200 text-gray-700 py-3 px-6 rounded-lg font-semibold hover:bg-gray-300 transition-colors">
            Exit Game
          </button>
        </div>
      </div>);
    }

    // Drag and Drop Game
    if (activity.type === 'drag-drop') {
        return (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-4xl w-full mx-4 shadow-2xl">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-xl font-semibold text-gray-900">Drag & Drop - Marketing Channels</h3>
            <span className="text-sm font-medium text-blue-600">Score: {score}</span>
          </div>
          
          <p className="text-gray-600 mb-6">Drag the marketing channels to their appropriate categories:</p>
          
          <div className="grid grid-cols-2 gap-8 mb-6">
            {/* Drag Items */}
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">Marketing Channels</h4>
              <div className="space-y-2">
                {dragItems.map((item) => (<div key={item} draggable onDragStart={(e) => handleDragStart(e, item)} className="p-3 bg-blue-100 border border-blue-300 rounded-lg cursor-move hover:bg-blue-200 transition-colors">
                    {item}
                  </div>))}
              </div>
            </div>
            
            {/* Drop Zones */}
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">Categories</h4>
              <div className="space-y-4">
                {['Paid Advertising', 'Organic Marketing', 'Direct Marketing'].map((zone) => (<div key={zone} onDragOver={(e) => e.preventDefault()} onDrop={(e) => handleDrop(e, zone)} className="p-4 border-2 border-dashed border-gray-300 rounded-lg min-h-[60px] hover:border-gray-400 transition-colors">
                    <div className="font-medium text-gray-700 mb-2">{zone}</div>
                    {dropZones[zone] && (<div className="p-2 bg-green-100 border border-green-300 rounded text-green-700">
                        {dropZones[zone]}
                      </div>)}
                  </div>))}
              </div>
            </div>
          </div>
          
          <div className="flex space-x-3">
            <button onClick={handleGameComplete} className="flex-1 bg-brand-cyan text-white py-3 px-6 rounded-lg font-semibold hover:bg-brand-navy transition-colors">
              Complete Game
            </button>
            <button onClick={onClose} className="flex-1 bg-gray-200 text-gray-700 py-3 px-6 rounded-lg font-semibold hover:bg-gray-300 transition-colors">
              Exit Game
            </button>
          </div>
        </div>
      </div>);
    }

    return null;
};

export default GameActivity;