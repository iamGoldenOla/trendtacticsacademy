const fs = require('fs');
const path = require('path');
const ftp = require('basic-ftp');

async function deployResolveFix() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        // Load environment variables
        require('dotenv').config({ path: path.join(__dirname, 'lms-frontend', '.env') });

        const config = {
            host: process.env.FTP_HOST || '193.227.129.17',
            user: process.env.FTP_USER || 'your_ftp_username',
            password: process.env.FTP_PASS || 'your_ftp_password',
            port: 21,
            remotePath: process.env.FTP_PATH || '/public_html/academy.trendtacticsdigital.com'
        };

        console.log('Connecting to FTP server...');
        await client.access(config);

        console.log('Connected! Deploying resolve.php fix...');

        // Upload resolve.php
        const resolvePath = path.join(__dirname, 'lms-frontend', 'public', 'resolve.php');
        if (fs.existsSync(resolvePath)) {
            console.log('Uploading resolve.php...');
            await client.uploadFrom(resolvePath, 'resolve.php');
        }

        // Upload updated .htaccess
        const htaccessPath = path.join(__dirname, 'lms-frontend', 'public', '.htaccess');
        if (fs.existsSync(htaccessPath)) {
            console.log('Uploading .htaccess...');
            await client.uploadFrom(htaccessPath, '.htaccess');
        }

        console.log('✅ Resolve fix deployed successfully!');
        console.log('The course generation should now work.');

    } catch (err) {
        console.error('Deployment failed:', err);
        process.exit(1);
    } finally {
        client.close();
    }
}

deployResolveFix();