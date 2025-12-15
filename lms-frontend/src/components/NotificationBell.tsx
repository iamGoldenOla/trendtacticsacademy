import React, { useEffect, useState } from 'react';
import { Notification } from '../types/notification';
import { fetchNotifications, markNotificationAsRead } from '../services/notificationService';

interface NotificationBellProps {
  userId: string;
}

const NotificationBell: React.FC<NotificationBellProps> = ({ userId }) => {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [showDropdown, setShowDropdown] = useState(false);

  useEffect(() => {
    if (userId) {
      fetchNotifications(userId).then(setNotifications);
    }
  }, [userId]);

  const unreadCount = notifications.filter(n => !n.read).length;

  const handleBellClick = () => setShowDropdown(!showDropdown);

  const handleMarkAsRead = async (id: string) => {
    try {
      await markNotificationAsRead(id);
      setNotifications((prev) =>
        prev.map((n) => (n._id === id ? { ...n, read: true } : n))
      );
    } catch (error) {
      console.error('Failed to mark notification as read:', error);
    }
  };

  return (
    <div className="relative inline-block">
      <button className="relative" onClick={handleBellClick} aria-label="Notifications">
        <span className="text-2xl">🔔</span>
        {unreadCount > 0 && (
          <span className="absolute top-0 right-0 bg-red-500 text-white text-xs rounded-full px-1.5 py-0.5">
            {unreadCount}
          </span>
        )}
      </button>
      {showDropdown && (
        <div className="absolute right-0 mt-2 w-80 bg-white border rounded shadow-lg z-50 max-h-96 overflow-y-auto">
          <div className="p-3 border-b font-semibold">Notifications</div>
          {notifications.length === 0 ? (
            <div className="p-4 text-gray-500">No notifications</div>
          ) : (
            <ul>
              {notifications.map(n => (
                <li key={n._id} className={`p-3 border-b last:border-b-0 flex items-start gap-2 ${n.read ? 'bg-gray-50' : 'bg-blue-50'}`}>
                  <div className="flex-1">
                    <div className="font-medium">{n.message}</div>
                    <div className="text-xs text-gray-500">{new Date(n.createdAt).toLocaleString()}</div>
                    {n.link && <a href={n.link} className="text-blue-600 text-xs underline">View</a>}
                  </div>
                  {!n.read && (
                    <button className="ml-2 text-xs text-blue-600 hover:underline" onClick={() => handleMarkAsRead(n._id)}>Mark as read</button>
                  )}
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
};

export default NotificationBell;