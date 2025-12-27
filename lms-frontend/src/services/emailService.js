import { supabase } from './supabaseClient';

class EmailService {
  // Send a test email
  static async sendTestEmail(to, subject, html) {
    try {
      const response = await fetch('/api/emails/test', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ to, subject, html }),
      });

      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error sending test email:', error);
      return { success: false, error: error.message };
    }
  }

  // Send welcome email
  static async sendWelcomeEmail(email, name) {
    try {
      const response = await fetch('/api/emails/welcome', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, name }),
      });

      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error sending welcome email:', error);
      return { success: false, error: error.message };
    }
  }

  // Send enrollment confirmation email
  static async sendEnrollmentConfirmation(email, studentName, courseTitle) {
    try {
      const response = await fetch('/api/emails/enrollment', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, studentName, courseTitle }),
      });

      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error sending enrollment confirmation email:', error);
      return { success: false, error: error.message };
    }
  }

  // Send password reset email
  static async sendPasswordReset(email, resetLink) {
    try {
      const response = await fetch('/api/emails/password-reset', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, resetLink }),
      });

      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error sending password reset email:', error);
      return { success: false, error: error.message };
    }
  }
}

export default EmailService;