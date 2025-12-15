import React, { useState } from "react";
import { Task } from "../types";

interface TodoListProps {
  tasks: Task[];
  onTaskAdd: (task: Task) => void;
  onTaskUpdate: (task: Task) => void;
  onTaskDelete: (taskId: string) => void;
}

const statusOptions = ["All", "Pending", "In Progress", "Completed"];

const TodoList: React.FC<TodoListProps> = ({ tasks, onTaskAdd, onTaskUpdate, onTaskDelete }) => {
  const [statusFilter, setStatusFilter] = useState<string>("All");
  const [showModal, setShowModal] = useState(false);
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [newTaskDescription, setNewTaskDescription] = useState("");
  const [newTaskPriority, setNewTaskPriority] = useState<"low"|"medium"|"high">("medium");
  const [newTaskType, setNewTaskType] = useState<"assignment"|"quiz"|"project"|"reading"|"personal">("assignment");
  const [newTaskDueDate, setNewTaskDueDate] = useState("");

  const filteredTasks = statusFilter === "All" ? tasks : tasks.filter(task => task.status === statusFilter.toLowerCase());
  const pendingTasks = tasks.filter(task => task.status === "pending");
  const inProgressTasks = tasks.filter(task => task.status === "in-progress");
  const completedTasks = tasks.filter(task => task.status === "completed");

  const handleAddTask = () => {
    if (!newTaskTitle.trim()) return;
    const newTask: Task = {
      id: Date.now().toString(),
      title: newTaskTitle,
      description: newTaskDescription,
      type: newTaskType,
      priority: newTaskPriority,
      status: "pending",
      dueDate: newTaskDueDate ? new Date(newTaskDueDate) : undefined,
      attachments: [],
      createdAt: new Date(),
    };
    onTaskAdd(newTask);
    setShowModal(false);
    setNewTaskTitle("");
    setNewTaskDescription("");
    setNewTaskPriority("medium");
    setNewTaskType("assignment");
    setNewTaskDueDate("");
  };

  return (
    <div className="bg-white rounded-lg shadow-2xl p-6 mb-6 transform transition-transform duration-200 hover:scale-105 border-t-4 border-blue-400" style={{boxShadow: '0 8px 24px rgba(0,0,0,0.18), 0 1.5px 4px rgba(60,60,255,0.10)', background: 'linear-gradient(135deg, #f8fafc 60%, #e0e7ff 100%)'}}>
      {/* Status Filter */}
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl font-bold text-gray-800 drop-shadow-lg">To-Do List</h2>
        <button
          className="bg-gradient-to-r from-blue-500 to-purple-500 text-white px-4 py-2 rounded-lg shadow-lg hover:shadow-2xl hover:scale-105 transition-all duration-200 font-semibold"
          onClick={() => setShowModal(true)}
        >
          Add Task
        </button>
      </div>
      {/* Modal for adding a new task */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50">
          <div className="bg-white p-6 rounded shadow-md w-full max-w-md">
            <h2 className="text-lg font-semibold mb-4">Add New Task</h2>
            <input
              className="border rounded w-full px-3 py-2 mb-3"
              type="text"
              placeholder="Title"
              value={newTaskTitle}
              onChange={e => setNewTaskTitle(e.target.value)}
            />
            <textarea
              className="border rounded w-full px-3 py-2 mb-3"
              placeholder="Description"
              value={newTaskDescription}
              onChange={e => setNewTaskDescription(e.target.value)}
            />
            <select
              className="border rounded w-full px-3 py-2 mb-3"
              value={newTaskType}
              onChange={e => setNewTaskType(e.target.value as Task["type"])}
            >
              {TASK_TYPES.map(type => (
                <option key={type} value={type}>{type.charAt(0).toUpperCase() + type.slice(1)}</option>
              ))}
            </select>
            <select
              className="border rounded w-full px-3 py-2 mb-3"
              value={newTaskPriority}
              onChange={e => setNewTaskPriority(e.target.value as Task["priority"])}
            >
              {PRIORITIES.map(priority => (
                <option key={priority} value={priority}>{priority.charAt(0).toUpperCase() + priority.slice(1)}</option>
              ))}
            </select>
            <input
              className="border rounded w-full px-3 py-2 mb-3"
              type="date"
              value={newTaskDueDate}
              onChange={e => setNewTaskDueDate(e.target.value)}
            />
            <div className="flex justify-end gap-2">
              <button className="bg-gray-300 px-4 py-2 rounded" onClick={() => setShowModal(false)}>Cancel</button>
              <button className="bg-blue-600 text-white px-4 py-2 rounded" onClick={handleAddTask}>Add</button>
            </div>
          </div>
        </div>
      )}
      <div className="flex gap-4 mb-6">
        <div className="flex-1 bg-blue-50 rounded p-4 text-center">
          <div className="text-2xl font-bold">{pendingTasks.length}</div>
          <div className="text-blue-700">Pending Tasks</div>
        </div>
        <div className="flex-1 bg-yellow-50 rounded p-4 text-center">
          <div className="text-2xl font-bold">{inProgressTasks.length}</div>
          <div className="text-yellow-700">In Progress</div>
        </div>
        <div className="flex-1 bg-green-50 rounded p-4 text-center">
          <div className="text-2xl font-bold">{completedTasks.length}</div>
          <div className="text-green-700">Completed</div>
        </div>
      </div>
      <div className="flex gap-4 mb-6">
        <select className="border rounded px-3 py-2" value={statusFilter} onChange={e => setStatusFilter(e.target.value)}>
          {statusOptions.map(option => (
            <option key={option} value={option}>{option}</option>
          ))}
        </select>
      </div>
      <div className="grid grid-cols-3 gap-6">
        <div>
          <h3 className="font-semibold mb-2">Pending ({pendingTasks.length})</h3>
          {pendingTasks.length === 0 ? (
            <div className="text-gray-400 flex flex-col items-center"><span className="text-3xl">✔️</span>No pending tasks</div>
          ) : (
            <ul>
              {pendingTasks.map(task => (
                <li key={task.id} className="mb-2 p-2 bg-white rounded shadow flex flex-col gap-1">
                  <span className="font-semibold">{task.title}</span>
                  <span className="text-gray-600 text-sm">{task.description}</span>
                  <div className="flex gap-2 text-xs mt-1">
                    <span className="bg-blue-100 text-blue-700 px-2 py-0.5 rounded">{task.type}</span>
                    <span className="bg-gray-100 text-gray-700 px-2 py-0.5 rounded">Priority: {task.priority}</span>
                    {task.dueDate && (
                      <span className="bg-red-100 text-red-700 px-2 py-0.5 rounded">Due: {new Date(task.dueDate).toLocaleDateString()}</span>
                    )}
                  </div>
                  {/* TODO: Add edit/delete actions */}
                </li>
              ))}
            </ul>
          )}
        </div>
        <div>
          <h3 className="font-semibold mb-2">In Progress ({inProgressTasks.length})</h3>
          {inProgressTasks.length === 0 ? (
            <div className="text-gray-400 flex flex-col items-center"><span className="text-3xl">🚀</span>No tasks in progress</div>
          ) : (
            <ul>
              {inProgressTasks.map(task => (
                <li key={task.id} className="mb-2 p-2 bg-white rounded shadow flex justify-between items-center">
                  <span>{task.title}</span>
                  {/* TODO: Add edit/delete actions */}
                </li>
              ))}
            </ul>
          )}
        </div>
        <div>
          <h3 className="font-semibold mb-2">Completed ({completedTasks.length})</h3>
          {completedTasks.length === 0 ? (
            <div className="text-gray-400 flex flex-col items-center"><span className="text-3xl">🎉</span>No completed tasks</div>
          ) : (
            <ul>
              {completedTasks.map(task => (
                <li key={task.id} className="mb-2 p-2 bg-white rounded shadow flex justify-between items-center">
                  <span>{task.title}</span>
                  {/* TODO: Add edit/delete actions */}
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
    </div>
  );
};

export default TodoList;
const TASK_TYPES = ["assignment", "quiz", "project", "reading", "personal"];
const PRIORITIES = ["low", "medium", "high"];