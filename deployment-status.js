// Check deployment status
const https = require('https');

function checkUrl(url) {
  return new Promise((resolve, reject) => {
    const req = https.get(url, (res) => {
      resolve({
        statusCode: res.statusCode,
        headers: res.headers
      });
    }).on('error', (err) => {
      reject(err);
    });
    
    req.setTimeout(10000, () => {
      req.destroy();
      reject(new Error('Request timeout'));
    });
  });
}

async function checkDeploymentStatus() {
  console.log('🔍 Checking deployment status...\n');
  
  try {
    // Check GitHub Pages deployment
    console.log('1. Checking GitHub Pages deployment...');
    const ghPagesResult = await checkUrl('https://iamgoldenola.github.io/trendtacticsacademy/');
    console.log(`   Status: ${ghPagesResult.statusCode}`);
    console.log(`   Location: ${ghPagesResult.headers.location || 'None'}`);
    
    // Check if there's a redirect to the custom domain
    if (ghPagesResult.headers.location) {
      console.log('   Redirect detected. Following redirect...');
      const redirectResult = await checkUrl(ghPagesResult.headers.location);
      console.log(`   Redirect status: ${redirectResult.statusCode}`);
    }
    
    // Check custom domain
    console.log('\n2. Checking custom domain...');
    try {
      const customDomainResult = await checkUrl('https://academy.trendtacticsdigital.com');
      console.log(`   Status: ${customDomainResult.statusCode}`);
    } catch (error) {
      console.log(`   Error: ${error.message}`);
    }
    
    // Check raw GitHub content to verify our changes are there
    console.log('\n3. Checking if changes are in repository...');
    const rawContentResult = await checkUrl('https://raw.githubusercontent.com/iamgoldenola/trendtacticsacademy/main/lms-frontend/src/services/courseService.js');
    console.log(`   Repository file status: ${rawContentResult.statusCode}`);
    
    if (rawContentResult.statusCode === 200) {
      console.log('   ✅ Changes should be in the repository');
    } else {
      console.log('   ❌ Changes may not be in the repository');
    }
    
  } catch (error) {
    console.error('Error checking deployment status:', error.message);
  }
  
  console.log('\n🏁 Deployment status check completed');
}

checkDeploymentStatus();