export interface Notification {
  _id: string;
  user: string;
  type: 'info' | 'success' | 'warning' | 'error';
  message: string;
  read: boolean;
  link?: string;
  createdAt: string;
  updatedAt: string;
}