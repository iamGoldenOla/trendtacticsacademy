import { Notification } from '../types/notification';
import { get, post, put } from './api';

export const fetchNotifications = async (userId: string): Promise<Notification[]> => {
  return get<Notification[]>(`/notifications?userId=${userId}`);
};

export const markNotificationAsRead = async (notificationId: string): Promise<Notification> => {
  return put<Notification>(`/notifications/${notificationId}/read`);
};

export const createNotification = async (data: Partial<Notification>): Promise<Notification> => {
  return post<Notification>('/notifications', data);
};