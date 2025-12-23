const fs = require('fs');
const path = require('path');
const ftp = require('basic-ftp');

async function deployToCPanel() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        // Configuration - replace with your actual cPanel/FTP details
        const config = {
            host: process.env.FTP_HOST || 'your-domain.com',
            user: process.env.FTP_USER || 'your_ftp_username',
            password: process.env.FTP_PASS || 'your_ftp_password',
            port: process.env.FTP_PORT || 21,
            remotePath: process.env.FTP_PATH || '/public_html' // Adjust this to your web root
        };

        console.log('Connecting to FTP server...');
        await client.access(config);

        console.log('Connected to FTP server successfully!');

        // Upload build directory contents
        const buildDir = path.join(__dirname, 'lms-frontend', 'build');
        
        if (!fs.existsSync(buildDir)) {
            throw new Error(`Build directory does not exist: ${buildDir}`);
        }

        console.log(`Uploading files from ${buildDir} to ${config.remotePath}...`);
        await client.uploadFromDir(buildDir, config.remotePath);

        console.log('Upload completed successfully!');
        
    } catch (err) {
        console.error('Deployment failed:', err);
        process.exit(1);
    } finally {
        client.close();
    }
}

// Run deployment
if (require.main === module) {
    deployToCPanel();
}

module.exports = deployToCPanel;