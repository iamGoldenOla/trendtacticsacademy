const ftp = require('basic-ftp');
const path = require('path');

async function deployAuthFile() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        console.log('Connecting to FTP server...');
        await client.access({
            host: '193.227.129.17',
            user: 'Trendta1',
            password: '2jWO6x][Oa6M4x',
            port: 21
        });

        console.log('Connected! Uploading auth-test-v2.html...');

        const localFile = path.join(__dirname, 'auth-test-v2.html');
        const remotePath = '/public_html/academy.trendtacticsdigital.com/signup-test.html';

        await client.uploadFrom(localFile, remotePath);

        console.log('✅ Upload successful!');
        console.log('Visit: https://academy.trendtacticsdigital.com/signup-test.html');

    } catch (err) {
        console.error('❌ Deployment failed:', err);
    } finally {
        client.close();
    }
}

deployAuthFile();
