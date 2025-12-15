import React, { useState, useEffect } from 'react';
import { Task, CalendarEvent, User } from '../types';
import Calendar from '../components/Calendar';
import TodoList from '../components/TodoList';

interface PlannerPageProps {
  user: User | null;
}

const PlannerPage: React.FC<PlannerPageProps> = ({ user }) => {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [activeTab, setActiveTab] = useState<'overview' | 'calendar' | 'tasks'>('overview');

  // Sample data - in a real app, this would come from an API
  useEffect(() => {
    const sampleTasks: Task[] = [
      {
        id: '1',
        title: 'Complete React Assignment',
        description: 'Build a todo app using React hooks and context',
        type: 'assignment',
        priority: 'high',
        status: 'pending',
        dueDate: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000), // 2 days from now
        courseId: 'course1',
        courseName: 'React Development',
        createdAt: new Date()
      },
      {
        id: '2',
        title: 'Study for JavaScript Quiz',
        description: 'Review ES6 features, async/await, and promises',
        type: 'quiz',
        priority: 'medium',
        status: 'in-progress',
        dueDate: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // 5 days from now
        courseId: 'course2',
        courseName: 'JavaScript Fundamentals',
        createdAt: new Date()
      },
      {
        id: '3',
        title: 'Read Chapter 5: State Management',
        description: 'Understanding Redux and Context API',
        type: 'reading',
        priority: 'low',
        status: 'completed',
        courseId: 'course1',
        courseName: 'React Development',
        createdAt: new Date(),
        completedAt: new Date()
      },
      {
        id: '4',
        title: 'Plan weekend study session',
        description: 'Organize study materials and create schedule',
        type: 'personal',
        priority: 'medium',
        status: 'pending',
        dueDate: new Date(Date.now() + 1 * 24 * 60 * 60 * 1000), // 1 day from now
        createdAt: new Date()
      }
    ];

    const sampleEvents: CalendarEvent[] = [
      {
        id: '1',
        title: 'React Assignment Due',
        description: 'Submit React todo app assignment',
        date: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000),
        type: 'assignment',
        courseId: 'course1',
        courseName: 'React Development'
      },
      {
        id: '2',
        title: 'JavaScript Quiz',
        description: 'Online quiz on ES6 and async programming',
        date: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000),
        type: 'quiz',
        courseId: 'course2',
        courseName: 'JavaScript Fundamentals'
      },
      {
        id: '3',
        title: 'Live Coding Session',
        description: 'Interactive coding session with instructor',
        date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
        type: 'lesson',
        courseId: 'course1',
        courseName: 'React Development'
      },
      {
        id: '4',
        title: 'Project Submission Deadline',
        description: 'Final project submission for the course',
        date: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000),
        type: 'deadline',
        courseId: 'course2',
        courseName: 'JavaScript Fundamentals'
      }
    ];

    setTasks(sampleTasks);
    setEvents(sampleEvents);
  }, []);

  const handleTaskUpdate = (updatedTask: Task) => {
    setTasks(prev => prev.map(task => task.id === updatedTask.id ? updatedTask : task));
  };

  const handleTaskDelete = (taskId: string) => {
    setTasks(prev => prev.filter(task => task.id !== taskId));
  };

  const handleTaskAdd = (newTaskData: Omit<Task, 'id' | 'createdAt'>) => {
    const newTask: Task = {
      ...newTaskData,
      id: Date.now().toString(),
      createdAt: new Date()
    };
    setTasks(prev => [...prev, newTask]);
  };

  const handleEventClick = (event: CalendarEvent) => {
    alert(`Event: ${event.title}\n${event.description || ''}`);
  };

  const handleDateClick = (date: Date) => {
    console.log('Date clicked:', date);
  };

  const getUpcomingTasks = () => {
    return tasks
      .filter(task => task.status !== 'completed' && task.dueDate)
      .sort((a, b) => new Date(a.dueDate!).getTime() - new Date(b.dueDate!).getTime())
      .slice(0, 5);
  };

  const getTaskStats = () => {
    const total = tasks.length;
    const completed = tasks.filter(task => task.status === 'completed').length;
    const pending = tasks.filter(task => task.status === 'pending').length;
    const inProgress = tasks.filter(task => task.status === 'in-progress').length;
    const completionRate = total > 0 ? Math.round((completed / total) * 100) : 0;
    
    return { total, completed, pending, inProgress, completionRate };
  };

  const stats = getTaskStats();
  const upcomingTasks = getUpcomingTasks();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white shadow-sm border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">Study Planner</h1>
              <p className="text-sm text-gray-600">Organize your learning journey</p>
            </div>
            <div className="flex items-center gap-4">
              <div className="text-sm text-gray-600">
                 Welcome back, <span className="font-medium">{user?.name || 'Guest'}</span>
               </div>
            </div>
          </div>
        </div>
      </div>

      {/* Navigation Tabs */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <nav className="flex space-x-8">
            {[
              { id: 'overview', label: 'Overview', icon: '📊' },
              { id: 'calendar', label: 'Calendar', icon: '📅' },
              { id: 'tasks', label: 'Tasks', icon: '✅' }
            ].map(tab => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as any)}
                className={`flex items-center gap-2 py-4 px-1 border-b-2 font-medium text-sm transition-colors ${
                  activeTab === tab.id
                    ? 'border-brand-cyan text-brand-cyan'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                }`}
              >
                <span>{tab.icon}</span>
                {tab.label}
              </button>
            ))}
          </nav>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {activeTab === 'overview' && (
          <div className="space-y-8">
            {/* Stats Overview */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-gray-600">Total Tasks</p>
                    <p className="text-3xl font-bold text-gray-900">{stats.total}</p>
                  </div>
                  <div className="text-3xl">📋</div>
                </div>
              </div>
              
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-gray-600">Completed</p>
                    <p className="text-3xl font-bold text-green-600">{stats.completed}</p>
                  </div>
                  <div className="text-3xl">✅</div>
                </div>
              </div>
              
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-gray-600">In Progress</p>
                    <p className="text-3xl font-bold text-yellow-600">{stats.inProgress}</p>
                  </div>
                  <div className="text-3xl">🚀</div>
                </div>
              </div>
              
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-gray-600">Completion Rate</p>
                    <p className="text-3xl font-bold text-brand-cyan">{stats.completionRate}%</p>
                  </div>
                  <div className="text-3xl">📈</div>
                </div>
              </div>
            </div>

            {/* Quick Overview Grid */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
              {/* Upcoming Tasks */}
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <span>⏰</span>
                  Upcoming Deadlines
                </h3>
                <div className="space-y-3">
                  {upcomingTasks.length > 0 ? (
                    upcomingTasks.map(task => (
                      <div key={task.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                        <div>
                          <p className="font-medium text-gray-900">{task.title}</p>
                          <p className="text-sm text-gray-600">{task.courseName || 'Personal'}</p>
                        </div>
                        <div className="text-right">
                          <p className={`text-sm font-medium ${
                            new Date(task.dueDate!).getTime() - new Date().getTime() < 24 * 60 * 60 * 1000
                              ? 'text-red-600' : 'text-gray-600'
                          }`}>
                            {new Date(task.dueDate!).toLocaleDateString()}
                          </p>
                          <span className={`inline-block px-2 py-1 rounded-full text-xs ${
                            task.priority === 'high' ? 'bg-red-100 text-red-700' :
                            task.priority === 'medium' ? 'bg-yellow-100 text-yellow-700' :
                            'bg-green-100 text-green-700'
                          }`}>
                            {task.priority}
                          </span>
                        </div>
                      </div>
                    ))
                  ) : (
                    <div className="text-center py-8 text-gray-500">
                      <div className="text-4xl mb-2">🎉</div>
                      <p>No upcoming deadlines!</p>
                    </div>
                  )}
                </div>
              </div>

              {/* Recent Activity */}
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <span>📈</span>
                  Progress Overview
                </h3>
                <div className="space-y-4">
                  <div>
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-gray-600">Overall Completion</span>
                      <span className="font-medium">{stats.completionRate}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div 
                        className="bg-brand-cyan h-2 rounded-full transition-all duration-300"
                        style={{ width: `${stats.completionRate}%` }}
                      ></div>
                    </div>
                  </div>
                  
                  <div className="grid grid-cols-3 gap-4 pt-4">
                    <div className="text-center">
                      <div className="text-2xl font-bold text-blue-600">{stats.pending}</div>
                      <div className="text-xs text-gray-600">Pending</div>
                    </div>
                    <div className="text-center">
                      <div className="text-2xl font-bold text-yellow-600">{stats.inProgress}</div>
                      <div className="text-xs text-gray-600">In Progress</div>
                    </div>
                    <div className="text-center">
                      <div className="text-2xl font-bold text-green-600">{stats.completed}</div>
                      <div className="text-xs text-gray-600">Completed</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}

        {activeTab === 'calendar' && (
          <Calendar 
            events={events}
            onEventClick={handleEventClick}
            onDateClick={handleDateClick}
          />
        )}

        {activeTab === 'tasks' && (
          <TodoList
            tasks={tasks}
            onTaskUpdate={handleTaskUpdate}
            onTaskDelete={handleTaskDelete}
            onTaskAdd={handleTaskAdd}
          />
        )}
      </div>
    </div>
  );
};

export default PlannerPage;