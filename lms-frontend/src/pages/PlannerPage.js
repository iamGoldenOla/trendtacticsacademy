import React, { useState, useEffect } from "react";
import Calendar from "../components/Calendar";
import TodoList from "../components/TodoList";

const PlannerPage = ({ user }) => {
    const [tasks, setTasks] = useState([]);
    const [events, setEvents] = useState([]);
    const [activeTab, setActiveTab] = useState('overview');

    // Sample data - in a real app, this would come from an API
    useEffect(() => {
        const sampleTasks = [
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

        const sampleEvents = [
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

    const handleTaskUpdate = (updatedTask) => {
        setTasks(prev => prev.map(task => task.id === updatedTask.id ? updatedTask : task));
    };

    const handleTaskDelete = (taskId) => {
        setTasks(prev => prev.filter(task => task.id !== taskId));
    };

    const handleTaskAdd = (newTaskData) => {
        const newTask = {
            ...newTaskData,
            id: Date.now().toString(),
            createdAt: new Date()
        };
        setTasks(prev => [...prev, newTask]);
    };

    const handleEventClick = (event) => {
        alert(`Event: ${event.title}\n${event.description || ''}`);
    };

    const handleDateClick = (date) => {
        console.log('Date clicked:', date);
    };

    const getUpcomingTasks = () => {
        return tasks
            .filter(task => task.status !== 'completed' && task.dueDate)
            .sort((a, b) => new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime())
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
                                onClick={() => setActiveTab(tab.id)}
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

            {/* Tab Content */}
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                {activeTab === 'overview' && (
                    <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                        {/* Stats Cards */}
                        <div className="lg:col-span-2 grid grid-cols-1 md:grid-cols-4 gap-6">
                            <div className="bg-white rounded-xl shadow-md p-6 border-l-4 border-blue-500">
                                <div className="text-3xl font-bold text-gray-900">{stats.total}</div>
                                <div className="text-gray-600 mt-1">Total Tasks</div>
                            </div>
                            
                            <div className="bg-white rounded-xl shadow-md p-6 border-l-4 border-green-500">
                                <div className="text-3xl font-bold text-gray-900">{stats.completed}</div>
                                <div className="text-gray-600 mt-1">Completed</div>
                            </div>
                            
                            <div className="bg-white rounded-xl shadow-md p-6 border-l-4 border-yellow-500">
                                <div className="text-3xl font-bold text-gray-900">{stats.inProgress}</div>
                                <div className="text-gray-600 mt-1">In Progress</div>
                            </div>
                            
                            <div className="bg-white rounded-xl shadow-md p-6 border-l-4 border-red-500">
                                <div className="text-3xl font-bold text-gray-900">{stats.pending}</div>
                                <div className="text-gray-600 mt-1">Pending</div>
                            </div>
                        </div>
                        
                        {/* Completion Rate */}
                        <div className="bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl shadow-lg p-6 text-white">
                            <div className="text-center">
                                <div className="text-4xl font-bold mb-2">{stats.completionRate}%</div>
                                <div className="text-blue-100">Completion Rate</div>
                                <div className="mt-4 w-full bg-blue-400 rounded-full h-2.5">
                                    <div 
                                        className="bg-white h-2.5 rounded-full" 
                                        style={{ width: `${stats.completionRate}%` }}
                                    ></div>
                                </div>
                            </div>
                        </div>
                        
                        {/* Upcoming Tasks */}
                        <div className="lg:col-span-3 bg-white rounded-xl shadow-md p-6">
                            <h2 className="text-xl font-bold text-gray-900 mb-4">Upcoming Tasks</h2>
                            {upcomingTasks.length === 0 ? (
                                <div className="text-center py-8 text-gray-500">
                                    No upcoming tasks. Great job staying on track!
                                </div>
                            ) : (
                                <div className="space-y-4">
                                    {upcomingTasks.map(task => (
                                        <div key={task.id} className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50">
                                            <div>
                                                <div className="font-medium text-gray-900">{task.title}</div>
                                                <div className="text-sm text-gray-600 mt-1">
                                                    {task.courseName && (
                                                        <span className="inline-block bg-blue-100 text-blue-800 text-xs px-2 py-0.5 rounded mr-2">
                                                            {task.courseName}
                                                        </span>
                                                    )}
                                                    {task.dueDate && (
                                                        <span className="text-gray-500">
                                                            Due: {new Date(task.dueDate).toLocaleDateString()}
                                                        </span>
                                                    )}
                                                </div>
                                            </div>
                                            <div className="flex items-center gap-2">
                                                <span className={`px-2 py-1 text-xs rounded-full ${
                                                    task.priority === 'high' ? 'bg-red-100 text-red-800' :
                                                    task.priority === 'medium' ? 'bg-yellow-100 text-yellow-800' :
                                                    'bg-green-100 text-green-800'
                                                }`}>
                                                    {task.priority}
                                                </span>
                                                <span className={`px-2 py-1 text-xs rounded-full ${
                                                    task.status === 'completed' ? 'bg-green-100 text-green-800' :
                                                    task.status === 'in-progress' ? 'bg-yellow-100 text-yellow-800' :
                                                    'bg-gray-100 text-gray-800'
                                                }`}>
                                                    {task.status.replace('-', ' ')}
                                                </span>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            )}
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