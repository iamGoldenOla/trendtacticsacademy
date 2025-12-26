const { Client } = require('basic-ftp');

async function deployAuthFix() {
    const client = new Client();
    client.ftp.verbose = true; // Enable verbose logging

    try {
        console.log('Connecting to FTP server...');
        await client.access({
            host: 'trendtacticsdigital.com',
            user: 'trendtacticsdigital',
            password: 'Dreycol123456789@',
            secure: false // Use explicit FTP (not FTPS)
        });

        console.log('Connected to FTP server');

        // Upload the updated build files
        console.log('Uploading updated build files...');
        await client.ensureDir('/public_html');
        
        // Upload the entire build directory contents
        await client.uploadFromDir('c:/Users/Akinola Olujobi/Documents/Trendtactics Academy/lms-frontend/build', '/public_html');
        
        console.log('Upload completed successfully!');
        
        // List the uploaded files to verify
        console.log('Verifying uploaded files...');
        const files = await client.list('/public_html/static/js');
        console.log('JS files in /public_html/static/js:', files.map(f => f.name));
        
    } catch (err) {
        console.error('FTP Error:', err);
        throw err;
    } finally {
        client.close();
    }
}

// Run the deployment
deployAuthFix().then(() => {
    console.log('Deployment completed successfully!');
}).catch(err => {
    console.error('Deployment failed:', err);
});