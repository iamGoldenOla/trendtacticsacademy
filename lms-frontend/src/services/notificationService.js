import { get, put, post } from "./api";

export const fetchNotifications = async (userId) => {
    return await get(`/notifications?userId=${userId}`);
};

export const markNotificationAsRead = async (notificationId) => {
    return await put(`/notifications/${notificationId}/read`);
};

export const createNotification = async (data) => {
    return await post('/notifications', data);
};

export default {
    fetchNotifications,
    markNotificationAsRead,
    createNotification,
};