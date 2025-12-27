const fs = require('fs');
const path = require('path');
const ftp = require('basic-ftp');

async function deployEmailFeatures() {
    const client = new ftp.Client();
    client.ftp.verbose = true;
    client.ftp.timeout = 1200000; // 20 minutes timeout

    try {
        // Configuration - replace with your actual cPanel/FTP details
        const config = {
            host: process.env.FTP_HOST || '193.227.129.17', // Your server IP
            user: process.env.FTP_USER || 'your_ftp_username',
            password: process.env.FTP_PASS || 'your_ftp_password',
            port: process.env.FTP_PORT || 21,
            remotePath: process.env.BACKEND_FTP_PATH || '/public_html/api' // Backend API directory on server
        };

        console.log('Connecting to FTP server for email features deployment...');
        await client.access(config);

        console.log('Connected to FTP server successfully!');

        // Define the specific files and directories to deploy for email functionality
        const emailFeatureFiles = [
            {
                local: path.join(__dirname, 'lms-backend', 'src', 'services', 'emailService.ts'),
                remote: '/src/services/emailService.ts'
            },
            {
                local: path.join(__dirname, 'lms-backend', 'src', 'routes', 'emailRoutes.ts'),
                remote: '/src/routes/emailRoutes.ts'
            },
            {
                local: path.join(__dirname, 'lms-backend', 'package.json'),
                remote: '/package.json'
            },
            {
                local: path.join(__dirname, 'lms-backend', '.env'),
                remote: '/.env'
            }
        ];

        // Upload each file
        for (const fileObj of emailFeatureFiles) {
            if (fs.existsSync(fileObj.local)) {
                console.log(`Uploading ${fileObj.local} to ${config.remotePath}${fileObj.remote}...`);
                
                // Ensure the remote directory exists
                const remoteDir = path.posix.dirname(config.remotePath + fileObj.remote);
                await client.ensureDir(remoteDir);
                
                // Upload the file
                await client.uploadFrom(fileObj.local, config.remotePath + fileObj.remote);
                console.log(`✓ Uploaded ${fileObj.remote}`);
            } else {
                console.log(`⚠ Skipping ${fileObj.local} - file does not exist`);
            }
        }

        console.log('Email features deployment completed successfully!');
        
        // Provide instructions for the user
        console.log('\nNext steps:');
        console.log('1. Ensure your server has the resend package installed: npm install resend');
        console.log('2. Restart your backend server to load the new email functionality');
        console.log('3. The email endpoints are now available at:');
        console.log('   - POST /api/emails/welcome');
        console.log('   - POST /api/emails/enrollment');
        console.log('   - POST /api/emails/password-reset');
        console.log('   - POST /api/emails/test');
        
    } catch (err) {
        console.error('Email features deployment failed:', err);
        process.exit(1);
    } finally {
        client.close();
    }
}

// Run deployment
if (require.main === module) {
    deployEmailFeatures();
}

module.exports = deployEmailFeatures;