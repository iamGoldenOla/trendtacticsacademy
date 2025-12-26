const fs = require('fs');
const path = require('path');
const ftp = require('basic-ftp');

async function deployBackendToFTP() {
    const client = new ftp.Client();
    client.ftp.verbose = true;
    client.ftp.timeout = 1200000; // 20 minutes timeout

    try {
        // Configuration - replace with your actual cPanel/FTP details for backend
        const config = {
            host: process.env.FTP_HOST || '193.227.129.17', // Your server IP
            user: process.env.FTP_USER || 'your_ftp_username',
            password: process.env.FTP_PASS || 'your_ftp_password',
            port: process.env.FTP_PORT || 21,
            remotePath: process.env.BACKEND_FTP_PATH || '/backend' // Backend directory on server
        };

        console.log('Connecting to FTP server for backend deployment...');
        await client.access(config);

        console.log('Connected to FTP server successfully!');

        // Upload backend directory contents
        const backendDir = path.join(__dirname, 'lms-backend');
        
        if (!fs.existsSync(backendDir)) {
            throw new Error(`Backend directory does not exist: ${backendDir}`);
        }

        console.log(`Uploading backend files from ${backendDir} to ${config.remotePath}...`);
        
        // Create remote directory if it doesn't exist
        await client.ensureDir(config.remotePath);
        
        // Upload all backend files
        await client.uploadFromDir(backendDir, config.remotePath);

        console.log('Backend upload completed successfully!');
        
        // Also upload the root package.json and package-lock.json if they exist
        const rootFiles = ['package.json', 'package-lock.json'];
        for (const file of rootFiles) {
            const filePath = path.join(__dirname, file);
            if (fs.existsSync(filePath)) {
                console.log(`Uploading ${file}...`);
                await client.uploadFrom(filePath, `${config.remotePath}/${file}`);
            }
        }
        
    } catch (err) {
        console.error('Backend deployment failed:', err);
        process.exit(1);
    } finally {
        client.close();
    }
}

// Run deployment
if (require.main === module) {
    deployBackendToFTP();
}

module.exports = deployBackendToFTP;