import React, { useState } from 'react';
import { GameActivity } from '../services/types';
import GameActivityComponent from './GameActivity';

interface GameHubProps {
  courseId: string;
  courseTitle: string;
  gameActivities: GameActivity[];
  onGameComplete: (activityId: string, score: number) => void;
  onClose: () => void;
}

const GameHub: React.FC<GameHubProps> = ({ 
  courseId, 
  courseTitle, 
  gameActivities, 
  onGameComplete, 
  onClose 
}) => {
  const [selectedActivity, setSelectedActivity] = useState<GameActivity | null>(null);
  const [userStats, setUserStats] = useState({
    totalPoints: 0,
    gamesCompleted: 0,
    averageScore: 0
  });

  const handleActivitySelect = (activity: GameActivity) => {
    if (activity.unlocked) {
      setSelectedActivity(activity);
    }
  };

  const handleGameComplete = (score: number) => {
    if (selectedActivity) {
      onGameComplete(selectedActivity.id, score);
      
      // Update local stats
      setUserStats(prev => ({
        totalPoints: prev.totalPoints + score,
        gamesCompleted: prev.gamesCompleted + 1,
        averageScore: Math.round((prev.totalPoints + score) / (prev.gamesCompleted + 1))
      }));
      
      setSelectedActivity(null);
    }
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'easy': return 'text-green-600 bg-green-100 border-green-200';
      case 'medium': return 'text-yellow-600 bg-yellow-100 border-yellow-200';
      case 'hard': return 'text-red-600 bg-red-100 border-red-200';
      default: return 'text-gray-600 bg-gray-100 border-gray-200';
    }
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'quiz': return '🧠';
      case 'memory': return '🃏';
      case 'drag-drop': return '🎯';
      case 'word-match': return '🔤';
      case 'scenario': return '🎭';
      default: return '🎮';
    }
  };

  const getCompletionBadge = (activity: GameActivity) => {
    if (!activity.completed) return null;
    
    const score = activity.bestScore || 0;
    if (score >= 90) return { emoji: '🏆', text: 'Gold', color: 'text-yellow-600 bg-yellow-100' };
    if (score >= 75) return { emoji: '🥈', text: 'Silver', color: 'text-gray-600 bg-gray-100' };
    if (score >= 60) return { emoji: '🥉', text: 'Bronze', color: 'text-orange-600 bg-orange-100' };
    return { emoji: '✅', text: 'Complete', color: 'text-green-600 bg-green-100' };
  };

  if (selectedActivity) {
    return (
      <GameActivityComponent
        activity={selectedActivity}
        onComplete={handleGameComplete}
        onClose={() => setSelectedActivity(null)}
      />
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-xl max-w-6xl w-full mx-4 shadow-2xl max-h-[90vh] overflow-hidden">
        {/* Header */}
        <div className="bg-gradient-to-r from-brand-cyan to-brand-navy text-white p-6">
          <div className="flex justify-between items-center">
            <div>
              <h2 className="text-2xl font-bold mb-2">🎮 Game Hub</h2>
              <p className="text-blue-100">{courseTitle}</p>
            </div>
            <button
              onClick={onClose}
              className="text-white hover:text-gray-200 transition-colors"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          
          {/* Stats */}
          <div className="grid grid-cols-3 gap-4 mt-6">
            <div className="bg-white bg-opacity-20 rounded-lg p-3 text-center">
              <div className="text-2xl font-bold">{userStats.totalPoints}</div>
              <div className="text-sm text-blue-100">Total Points</div>
            </div>
            <div className="bg-white bg-opacity-20 rounded-lg p-3 text-center">
              <div className="text-2xl font-bold">{userStats.gamesCompleted}</div>
              <div className="text-sm text-blue-100">Games Completed</div>
            </div>
            <div className="bg-white bg-opacity-20 rounded-lg p-3 text-center">
              <div className="text-2xl font-bold">{userStats.averageScore}%</div>
              <div className="text-sm text-blue-100">Average Score</div>
            </div>
          </div>
        </div>
        
        {/* Content */}
        <div className="p-6 overflow-y-auto max-h-[calc(90vh-200px)]">
          <div className="mb-6">
            <h3 className="text-xl font-semibold text-gray-900 mb-2">Available Games</h3>
            <p className="text-gray-600">Test your knowledge and earn points with these interactive activities!</p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {gameActivities.map((activity) => {
              const completionBadge = getCompletionBadge(activity);
              
              return (
                <div
                  key={activity.id}
                  className={`border-2 rounded-xl p-6 transition-all duration-200 cursor-pointer ${
                    activity.unlocked
                      ? 'border-gray-200 hover:border-brand-cyan hover:shadow-lg'
                      : 'border-gray-100 bg-gray-50 cursor-not-allowed opacity-60'
                  }`}
                  onClick={() => handleActivitySelect(activity)}
                >
                  {/* Activity Header */}
                  <div className="flex items-start justify-between mb-4">
                    <div className="text-3xl">{getTypeIcon(activity.type)}</div>
                    <div className="flex flex-col items-end space-y-2">
                      {!activity.unlocked && (
                        <span className="text-xs text-gray-500 bg-gray-200 px-2 py-1 rounded-full">
                          🔒 Locked
                        </span>
                      )}
                      {completionBadge && (
                        <span className={`text-xs px-2 py-1 rounded-full border ${completionBadge.color}`}>
                          {completionBadge.emoji} {completionBadge.text}
                        </span>
                      )}
                    </div>
                  </div>
                  
                  {/* Activity Info */}
                  <h4 className="font-semibold text-gray-900 mb-2">{activity.title}</h4>
                  <p className="text-sm text-gray-600 mb-4 line-clamp-2">{activity.description}</p>
                  
                  {/* Activity Meta */}
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-2">
                      <span className={`text-xs px-2 py-1 rounded-full border ${getDifficultyColor(activity.difficulty)}`}>
                        {activity.difficulty.toUpperCase()}
                      </span>
                      <span className="text-xs text-gray-500">
                        {activity.points} pts
                      </span>
                    </div>
                    
                    {activity.timeLimit && (
                      <span className="text-xs text-gray-500">
                        ⏱️ {Math.floor(activity.timeLimit / 60)}m
                      </span>
                    )}
                  </div>
                  
                  {/* Best Score */}
                  {activity.completed && activity.bestScore && (
                    <div className="mt-3 pt-3 border-t border-gray-200">
                      <div className="flex justify-between text-xs text-gray-600">
                        <span>Best Score:</span>
                        <span className="font-medium">{activity.bestScore}%</span>
                      </div>
                    </div>
                  )}
                  
                  {/* Play Button */}
                  {activity.unlocked && (
                    <button className="w-full mt-4 bg-brand-cyan text-white py-2 px-4 rounded-lg font-medium hover:bg-brand-navy transition-colors">
                      {activity.completed ? 'Play Again' : 'Start Game'}
                    </button>
                  )}
                </div>
              );
            })}
          </div>
          
          {/* Achievement Section */}
          <div className="mt-8 p-6 bg-gradient-to-r from-purple-50 to-pink-50 rounded-xl border border-purple-200">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">🏆 Achievements</h3>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              <div className={`text-center p-3 rounded-lg ${
                userStats.gamesCompleted >= 1 ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-400'
              }`}>
                <div className="text-2xl mb-1">🎯</div>
                <div className="text-xs font-medium">First Game</div>
              </div>
              <div className={`text-center p-3 rounded-lg ${
                userStats.totalPoints >= 100 ? 'bg-blue-100 text-blue-700' : 'bg-gray-100 text-gray-400'
              }`}>
                <div className="text-2xl mb-1">💯</div>
                <div className="text-xs font-medium">100 Points</div>
              </div>
              <div className={`text-center p-3 rounded-lg ${
                userStats.gamesCompleted >= 5 ? 'bg-purple-100 text-purple-700' : 'bg-gray-100 text-gray-400'
              }`}>
                <div className="text-2xl mb-1">🔥</div>
                <div className="text-xs font-medium">Game Master</div>
              </div>
              <div className={`text-center p-3 rounded-lg ${
                userStats.averageScore >= 90 ? 'bg-yellow-100 text-yellow-700' : 'bg-gray-100 text-gray-400'
              }`}>
                <div className="text-2xl mb-1">⭐</div>
                <div className="text-xs font-medium">High Scorer</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GameHub;