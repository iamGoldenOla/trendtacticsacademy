import React, { useState, useEffect } from "react";
import AITutorChat from "./AITutorChat";
import AIRecommendations from "./AIRecommendations";
import { aiService } from "../services/aiService";

export const AIDashboard = ({ userId, currentCourse, currentLesson, onBack }) => {
  const [activeTab, setActiveTab] = useState('chat');
  const [analytics, setAnalytics] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (activeTab === 'analytics') {
      fetchAnalytics();
    }
  }, [activeTab, userId]);

  const fetchAnalytics = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await aiService.getAnalytics(userId);
      setAnalytics(data);
    } catch (err) {
      setError('Failed to load analytics');
      console.error('Analytics error:', err);
    } finally {
      setLoading(false);
    }
  };

  const renderTabContent = () => {
    switch (activeTab) {
      case 'chat':
        return (<AITutorChat courseId={currentCourse} lessonId={currentLesson} topic={undefined} isOpen={true} onClose={onBack} />);
      case 'recommendations':
        return (<AIRecommendations courseId={currentCourse} currentProgress={analytics?.learningProgress?.averageScore} learningGoals={[]} />);
      case 'analytics':
        return (<div className="space-y-6">
          {loading && (<div className="flex justify-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          </div>)}

          {error && (<div className="bg-red-50 border border-red-200 rounded-lg p-4">
            <p className="text-red-600">{error}</p>
            <button onClick={fetchAnalytics} className="mt-2 text-red-700 hover:text-red-800 underline">
              Try again
            </button>
          </div>)}

          {analytics && (<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* Learning Progress */}
            <div className="bg-white rounded-lg shadow-md p-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">Learning Progress</h3>
              <div className="space-y-3">
                <div className="flex justify-between">
                  <span className="text-gray-600">Completed Lessons:</span>
                  <span className="font-medium">
                    {analytics.learningProgress.completedLessons}/{analytics.learningProgress.totalLessons}
                  </span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Average Score:</span>
                  <span className="font-medium">{analytics.learningProgress.averageScore}%</span>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div className="bg-blue-600 h-2 rounded-full" style={{
                    width: `${(analytics.learningProgress.completedLessons / analytics.learningProgress.totalLessons) * 100}%`
                  }}></div>
                </div>
              </div>
            </div>

            {/* AI Engagement */}
            <div className="bg-white rounded-lg shadow-md p-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">AI Engagement</h3>
              <div className="space-y-3">
                <div className="flex justify-between">
                  <span className="text-gray-600">Total Sessions:</span>
                  <span className="font-medium">{analytics.totalSessions}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Questions Asked:</span>
                  <span className="font-medium">{analytics.engagementMetrics.questionsAsked}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Avg. Session:</span>
                  <span className="font-medium">{Math.round(analytics.averageSessionDuration)} min</span>
                </div>
              </div>
            </div>

            {/* Top Topics */}
            <div className="bg-white rounded-lg shadow-md p-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">Top Discussion Topics</h3>
              <div className="space-y-2">
                {analytics.topTopics.slice(0, 5).map((topic, index) => (<div key={index} className="flex items-center space-x-2">
                  <span className="w-6 h-6 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-sm font-medium">
                    {index + 1}
                  </span>
                  <span className="text-gray-700 text-sm">{topic}</span>
                </div>))}
              </div>
            </div>
          </div>)}
        </div>);
      default:
        return null;
    }
  };

  return (<div className="bg-gray-50 min-h-screen">
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900">AI Learning Assistant</h1>
        <p className="mt-2 text-gray-600">
          Get personalized help, recommendations, and insights powered by TrendyAI
        </p>
      </div>

      {/* Tab Navigation */}
      <div className="border-b border-gray-200 mb-8">
        <nav className="-mb-px flex space-x-8">
          <button onClick={() => setActiveTab('chat')} className={`py-2 px-1 border-b-2 font-medium text-sm ${activeTab === 'chat'
            ? 'border-blue-500 text-blue-600'
            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}`}>
            AI Tutor Chat
          </button>
          <button onClick={() => setActiveTab('recommendations')} className={`py-2 px-1 border-b-2 font-medium text-sm ${activeTab === 'recommendations'
            ? 'border-blue-500 text-blue-600'
            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}`}>
            Recommendations
          </button>
          <button onClick={() => setActiveTab('analytics')} className={`py-2 px-1 border-b-2 font-medium text-sm ${activeTab === 'analytics'
            ? 'border-blue-500 text-blue-600'
            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}`}>
            Analytics
          </button>
        </nav>
      </div>

      {/* Tab Content */}
      <div className="bg-white rounded-lg shadow-sm">
        {renderTabContent()}
      </div>
    </div>
  </div>);
};

export default AIDashboard;