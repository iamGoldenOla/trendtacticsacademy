// Script to update email service configuration
// Run this after setting environment variables

const fs = require('fs');
const path = require('path');

// Path to the email service file
const emailServicePath = path.join(__dirname, 'lms-backend/src/services/emailService.js');

// Read the current email service file
let emailServiceContent = fs.readFileSync(emailServicePath, 'utf8');

// Replace the sendEmail function with a real implementation
const newSendEmailFunction = `
/**
 * Send email using configured service
 * @param {Object} options - Email options
 * @param {string} options.to - Recipient email
 * @param {string} options.subject - Email subject
 * @param {string} options.text - Plain text content
 * @param {string} options.html - HTML content
 */
const sendEmail = async (options) => {
    try {
        // Check if we're using SendGrid
        if (process.env.SENDGRID_API_KEY) {
            const sgMail = require('@sendgrid/mail');
            sgMail.setApiKey(process.env.SENDGRID_API_KEY);
            
            const msg = {
                to: options.to,
                from: process.env.EMAIL_FROM || 'noreply@trendtactics.com',
                subject: options.subject,
                text: options.text,
                html: options.html,
            };
            
            await sgMail.send(msg);
            console.log('✅ Email sent successfully via SendGrid to:', options.to);
            return { success: true, messageId: 'sendgrid-' + Date.now() };
        }
        
        // Check if we're using AWS SES
        if (process.env.AWS_ACCESS_KEY_ID && process.env.AWS_SECRET_ACCESS_KEY) {
            const AWS = require('aws-sdk');
            const ses = new AWS.SES({
                accessKeyId: process.env.AWS_ACCESS_KEY_ID,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
                region: process.env.AWS_REGION || 'us-east-1'
            });
            
            const params = {
                Destination: {
                    ToAddresses: [options.to]
                },
                Message: {
                    Body: {
                        Html: {
                            Charset: "UTF-8",
                            Data: options.html || options.text
                        },
                        Text: {
                            Charset: "UTF-8",
                            Data: options.text
                        }
                    },
                    Subject: {
                        Charset: 'UTF-8',
                        Data: options.subject
                    }
                },
                Source: process.env.EMAIL_FROM || 'noreply@trendtactics.com'
            };
            
            await ses.sendEmail(params).promise();
            console.log('✅ Email sent successfully via AWS SES to:', options.to);
            return { success: true, messageId: 'ses-' + Date.now() };
        }
        
        // Default to SMTP if configured
        if (process.env.EMAIL_SERVICE === 'smtp' && process.env.EMAIL_HOST) {
            const nodemailer = require('nodemailer');
            
            const transporter = nodemailer.createTransporter({
                host: process.env.EMAIL_HOST,
                port: process.env.EMAIL_PORT || 587,
                secure: process.env.EMAIL_PORT == 465, // true for 465, false for other ports
                auth: {
                    user: process.env.EMAIL_USER,
                    pass: process.env.EMAIL_PASS
                }
            });
            
            const mailOptions = {
                from: process.env.EMAIL_FROM || 'noreply@trendtactics.com',
                to: options.to,
                subject: options.subject,
                text: options.text,
                html: options.html
            };
            
            await transporter.sendMail(mailOptions);
            console.log('✅ Email sent successfully via SMTP to:', options.to);
            return { success: true, messageId: 'smtp-' + Date.now() };
        }
        
        // Fallback to console logging (current behavior)
        console.log('📧 Sending email:', {
            to: options.to,
            subject: options.subject,
            text: options.text ? options.text.substring(0, 50) + '...' : '',
            html: options.html ? options.html.substring(0, 50) + '...' : ''
        });
        
        // Simulate async operation
        await new Promise(resolve => setTimeout(resolve, 100));
        
        console.log('✅ Email sent successfully to:', options.to);
        return { success: true, messageId: 'simulated-' + Date.now() };
    } catch (error) {
        console.error('❌ Failed to send email:', error);
        throw error;
    }
};
`;

// Replace the existing sendEmail function
emailServiceContent = emailServiceContent.replace(
    /\/\*\*\s*\*\s*Simulate sending an email[\s\S]*?exports\.sendEmail = sendEmail;/,
    newSendEmailFunction
);

// Write the updated content back to the file
fs.writeFileSync(emailServicePath, emailServiceContent);

console.log('✅ Email service updated successfully!');
console.log('\\nNext steps:');
console.log('1. Run: npm install @sendgrid/mail aws-sdk nodemailer');
console.log('2. Set your email environment variables');
console.log('3. Restart your backend server');