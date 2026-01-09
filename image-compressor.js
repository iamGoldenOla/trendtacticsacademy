// Image Compression Script for Trendtactics Academy
// This script provides basic image compression functionality similar to TinyPNG/Squoosh but simpler

const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

async function compressImage(inputPath, outputPath, quality = 80) {
    try {
        await sharp(inputPath)
            .jpeg({ quality: quality })
            .png({ quality: quality })
            .webp({ quality: quality })
            .toFile(outputPath);
        
        console.log(`✓ Compressed: ${inputPath} -> ${outputPath}`);
        return true;
    } catch (error) {
        console.error(`✗ Error compressing ${inputPath}:`, error.message);
        return false;
    }
}

async function findLargeImages(dir, maxSize = 500 * 1024) { // 500KB default
    const files = [];
    const items = fs.readdirSync(dir);

    for (const item of items) {
        const fullPath = path.join(dir, item);
        const stat = fs.statSync(fullPath);

        if (stat.isDirectory()) {
            files.push(...await findLargeImages(fullPath, maxSize));
        } else if (/\.(jpg|jpeg|png|gif|webp)$/i.test(item)) {
            const fileSize = stat.size;
            if (fileSize > maxSize) {
                files.push({
                    path: fullPath,
                    size: fileSize,
                    sizeInKB: Math.round(fileSize / 1024)
                });
            }
        }
    }

    return files;
}

async function compressAllLargeImages() {
    console.log("🔍 Scanning for large images...");
    
    // Find all images larger than 500KB
    const largeImages = await findLargeImages(process.cwd(), 500 * 1024);
    
    if (largeImages.length === 0) {
        console.log("✅ No large images found to compress!");
        return;
    }
    
    console.log(`📊 Found ${largeImages.length} large images to compress:`);
    
    let successCount = 0;
    let failureCount = 0;
    
    for (const image of largeImages) {
        console.log(`📄 Processing: ${image.path} (${image.sizeInKB}KB)`);
        
        const dir = path.dirname(image.path);
        const fileName = path.basename(image.path, path.extname(image.path));
        const ext = path.extname(image.path);
        const outputPath = path.join(dir, `${fileName}-compressed${ext}`);
        
        // Compress with medium quality (adjust as needed)
        const success = await compressImage(image.path, outputPath, 70);
        
        if (success) {
            const originalSize = image.sizeInKB;
            const stats = fs.statSync(outputPath);
            const newSize = Math.round(stats.size / 1024);
            const reduction = Math.round(((originalSize - newSize) / originalSize) * 100);
            
            console.log(`   ✅ Compressed from ${originalSize}KB to ${newSize}KB (${reduction}% reduction)`);
            
            // Optionally replace original with compressed version
            if (newSize < originalSize) {
                try {
                    fs.unlinkSync(image.path); // Remove original file first
                    fs.renameSync(outputPath, image.path); // Rename compressed file to original name
                    console.log(`   🔄 Replaced original file`);
                } catch (error) {
                    console.error(`   ⚠️  Could not replace original file: ${error.message}`);
                    console.log(`   💡 Compressed file saved as: ${outputPath}`);
                }
            } else {
                // If compression didn't reduce size, remove the compressed file
                fs.unlinkSync(outputPath);
            }
            
            successCount++;
        } else {
            failureCount++;
        }
    }
    
    console.log(`\n📈 Compression Summary:`);
    console.log(`   ✓ Successfully compressed: ${successCount}`);
    console.log(`   ✗ Failed to compress: ${failureCount}`);
    console.log(`   📊 Total processed: ${largeImages.length}`);
}

async function convertToWebP() {
    console.log("\n🔄 Converting images to WebP format for better compression...");
    
    const images = await findLargeImages(process.cwd());
    let convertedCount = 0;
    
    for (const image of images) {
        const webpPath = image.path.replace(/\.\w+$/, '.webp');
        
        try {
            await sharp(image.path)
                .webp({ quality: 80 })
                .toFile(webpPath);
                
            const originalStats = fs.statSync(image.path);
            const webpStats = fs.statSync(webpPath);
            const reduction = Math.round(((originalStats.size - webpStats.size) / originalStats.size) * 100);
            
            console.log(`   ✅ Converted to WebP: ${webpPath} (${reduction}% smaller)`);
            convertedCount++;
        } catch (error) {
            console.error(`   ✗ Error converting ${image.path} to WebP:`, error.message);
        }
    }
    
    console.log(`   📊 WebP conversions completed: ${convertedCount}`);
}

// Main execution
async function main() {
    console.log("🚀 Trendtactics Academy Image Compression Tool");
    console.log("=============================================\n");
    
    await compressAllLargeImages();
    await convertToWebP();
    
    console.log("\n🎉 Image compression completed!");
    console.log("💡 Tip: You can now update your HTML files to use the compressed images for better performance.");
}

// Run the compression tool
if (require.main === module) {
    // First, install sharp if not already installed
    const { execSync } = require('child_process');
    
    try {
        // Check if sharp is installed
        require.resolve('sharp');
        main();
    } catch (error) {
        console.log("📦 Installing Sharp library for image processing...");
        execSync('npm install sharp', { stdio: 'inherit' });
        main();
    }
}

module.exports = {
    compressImage,
    findLargeImages,
    compressAllLargeImages,
    convertToWebP
};