// Script to verify what the live site is actually serving
const https = require('https');
const fs = require('fs');
const path = require('path');

async function verifyLiveSite() {
  console.log('🔍 Verifying live site content...\n');
  
  try {
    // Check if we can access the live site
    console.log('1. Checking if live site is accessible...');
    
    const url = 'https://academy.trendtacticsdigital.com';
    
    // Make a request to get the homepage
    const homepageHtml = await new Promise((resolve, reject) => {
      https.get(url, (res) => {
        let data = '';
        res.on('data', (chunk) => {
          data += chunk;
        });
        res.on('end', () => {
          resolve(data);
        });
      }).on('error', (err) => {
        reject(err);
      });
    });
    
    console.log(`✅ Live site is accessible (${homepageHtml.length} bytes)`);
    
    // Check if it contains references to our updated bundles
    if (homepageHtml.includes('main.') && homepageHtml.includes('.js')) {
      const jsMatch = homepageHtml.match(/src="(\/static\/js\/main\.[a-f0-9]+\.js)"/);
      if (jsMatch) {
        console.log(`✅ Found JS bundle: ${jsMatch[1]}`);
        
        // Try to fetch the JS bundle to see when it was built
        const jsUrl = `${url}${jsMatch[1]}`;
        console.log(`\n2. Checking JS bundle timestamp...`);
        
        try {
          const jsContent = await new Promise((resolve, reject) => {
            https.get(jsUrl, (res) => {
              let data = '';
              res.on('data', (chunk) => {
                data += chunk;
              });
              res.on('end', () => {
                resolve(data);
              });
            }).on('error', (err) => {
              reject(err);
            });
          });
          
          console.log(`✅ JS bundle fetched (${jsContent.length} bytes)`);
          
          // Check if it contains our courseService fixes
          if (jsContent.includes('fk_modules_course_id')) {
            console.log('✅ Bundle contains fk_modules_course_id fix');
          } else {
            console.log('❌ Bundle does NOT contain fk_modules_course_id fix');
          }
          
          if (jsContent.includes('fk_lessons_module_id')) {
            console.log('✅ Bundle contains fk_lessons_module_id fix');
          } else {
            console.log('❌ Bundle does NOT contain fk_lessons_module_id fix');
          }
          
          // Check if it still contains mock data references
          if (jsContent.includes('dm-1') || jsContent.includes('dm-2')) {
            console.log('❌ Bundle STILL contains mock course IDs (dm-1, dm-2)');
          } else {
            console.log('✅ Bundle does NOT contain mock course IDs');
          }
          
        } catch (error) {
          console.log(`❌ Could not fetch JS bundle: ${error.message}`);
        }
      } else {
        console.log('❌ Could not find JS bundle reference');
      }
    } else {
      console.log('❌ Homepage does not contain expected bundle references');
    }
    
    // Check for specific error patterns that would indicate old code
    if (homepageHtml.includes('No Courses Available')) {
      console.log('❌ Homepage still shows "No Courses Available" - old code likely still deployed');
    } else {
      console.log('✅ Homepage does not show "No Courses Available" message');
    }
    
    // Save the homepage HTML for inspection
    const outputPath = path.join(__dirname, 'live_site_homepage.html');
    fs.writeFileSync(outputPath, homepageHtml);
    console.log(`\n📄 Homepage HTML saved to: ${outputPath}`);
    
    console.log('\n📋 Summary:');
    console.log('===========');
    console.log('If the live site still shows old content:');
    console.log('1. The GitHub Actions deployment may still be pending');
    console.log('2. There may be CDN/server caching that needs to be cleared');
    console.log('3. The FTP deployment may have failed');
    
  } catch (error) {
    console.error('❌ Error verifying live site:', error.message);
    console.log('\n🔧 Troubleshooting steps:');
    console.log('1. Check GitHub Actions workflow status');
    console.log('2. Verify FTP deployment credentials');
    console.log('3. Contact hosting provider about caching');
  }
}

verifyLiveSite();