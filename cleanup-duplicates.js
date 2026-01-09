// Script to identify and remove duplicate image files across the project
const fs = require('fs');
const path = require('path');

function findDuplicateImages() {
    const duplicates = {};
    const imageMap = {};
    
    function scanDirectory(dir) {
        const items = fs.readdirSync(dir);
        
        for (const item of items) {
            const fullPath = path.join(dir, item);
            const stat = fs.statSync(fullPath);
            
            if (stat.isDirectory()) {
                // Skip node_modules to avoid unnecessary scanning
                if (item !== 'node_modules') {
                    scanDirectory(fullPath);
                }
            } else if (/\.(jpg|jpeg|png|gif|webp)$/i.test(item)) {
                const fileName = item.toLowerCase();
                
                if (!imageMap[fileName]) {
                    imageMap[fileName] = [];
                }
                
                imageMap[fileName].push(fullPath);
            }
        }
    }
    
    scanDirectory(process.cwd());
    
    // Find files that appear in multiple locations
    for (const [fileName, filePaths] of Object.entries(imageMap)) {
        if (filePaths.length > 1) {
            duplicates[fileName] = filePaths;
        }
    }
    
    return duplicates;
}

function removeDuplicates(duplicates) {
    console.log("🗑️  Removing duplicate image files...\n");
    
    let removedCount = 0;
    
    for (const [fileName, filePaths] of Object.entries(duplicates)) {
        console.log(`📸 Found ${filePaths.length} copies of: ${fileName}`);
        
        // Keep the first occurrence and remove the rest
        for (let i = 1; i < filePaths.length; i++) {
            try {
                fs.unlinkSync(filePaths[i]);
                console.log(`   ✅ Removed: ${filePaths[i]}`);
                removedCount++;
            } catch (error) {
                console.error(`   ❌ Error removing ${filePaths[i]}: ${error.message}`);
            }
        }
        console.log('');
    }
    
    return removedCount;
}

function main() {
    console.log("🔍 Scanning for duplicate images across the project...\n");
    
    const duplicates = findDuplicateImages();
    
    if (Object.keys(duplicates).length === 0) {
        console.log("✅ No duplicate images found!");
        return;
    }
    
    console.log(`📊 Found ${Object.keys(duplicates).length} duplicate image sets:\n`);
    
    for (const [fileName, filePaths] of Object.entries(duplicates)) {
        console.log(`${fileName}:`);
        filePaths.forEach(filePath => console.log(`  - ${filePath}`));
        console.log('');
    }
    
    // Ask for confirmation before removing
    console.log("🗑️  Removing duplicates (keeping one copy of each)...\n");
    const removedCount = removeDuplicates(duplicates);
    
    console.log(`\n🎉 Duplicate cleanup completed!`);
    console.log(`📊 ${removedCount} duplicate files removed.`);
    console.log(`💡 This should significantly reduce your project size.`);
}

main();