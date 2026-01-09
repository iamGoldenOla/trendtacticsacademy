// Auto Image Compression Script for Trendtactics Academy
// Automatically compresses images when they are added to the project

const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

// Configuration for image compression
const CONFIG = {
    quality: 80,           // Compression quality (1-100)
    maxWidth: 1920,        // Maximum width for images
    maxHeight: 1080,       // Maximum height for images
    maxSizeKB: 500,        // Maximum file size in KB before compression
    formats: ['jpg', 'jpeg', 'png', 'webp'], // Supported formats
    watchDirs: [          // Directories to monitor for new images
        './images',
        './docs/images',
        './assets',
        './public/images'
    ]
};

class AutoImageCompressor {
    constructor() {
        this.setupDirectories();
        this.ensureSharpInstallation();
    }

    setupDirectories() {
        // Create common image directories if they don't exist
        CONFIG.watchDirs.forEach(dir => {
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, { recursive: true });
                console.log(`📁 Created directory: ${dir}`);
            }
        });
    }

    async ensureSharpInstallation() {
        try {
            require.resolve('sharp');
        } catch (error) {
            console.log('📦 Installing Sharp library...');
            const { execSync } = require('child_process');
            execSync('npm install sharp', { stdio: 'inherit' });
        }
    }

    async compressImage(inputPath, outputPath = null) {
        try {
            const originalStats = fs.statSync(inputPath);
            const originalSize = originalStats.size;

            // Only compress if the image is larger than our threshold
            if (originalSize <= CONFIG.maxSizeKB * 1024) {
                console.log(`✅ ${path.basename(inputPath)} is already optimized (${Math.round(originalSize/1024)}KB)`);
                return true;
            }

            // If no output path specified, create a temporary file first
            if (!outputPath) {
                const tempPath = inputPath + '.temp';
                
                // Resize and compress the image to temporary file
                await sharp(inputPath)
                    .resize({
                        width: CONFIG.maxWidth,
                        height: CONFIG.maxHeight,
                        fit: 'inside',
                        withoutEnlargement: true
                    })
                    .jpeg({ quality: CONFIG.quality, progressive: true })
                    .png({ quality: CONFIG.quality })
                    .webp({ quality: CONFIG.quality })
                    .toFile(tempPath);
                
                // Replace original with compressed version
                try {
                    fs.unlinkSync(inputPath);
                    fs.renameSync(tempPath, inputPath);
                } catch (error) {
                    // If file is locked, just log and continue
                    console.error(`⚠️  Could not replace ${inputPath} - file may be in use:`, error.message);
                    // Clean up temp file
                    try {
                        fs.unlinkSync(tempPath);
                    } catch (e) {
                        // Ignore error if temp file cleanup fails
                    }
                    return false;
                }
                
                outputPath = inputPath;
            } else {
                // Resize and compress the image to specified output
                await sharp(inputPath)
                    .resize({
                        width: CONFIG.maxWidth,
                        height: CONFIG.maxHeight,
                        fit: 'inside',
                        withoutEnlargement: true
                    })
                    .jpeg({ quality: CONFIG.quality, progressive: true })
                    .png({ quality: CONFIG.quality })
                    .webp({ quality: CONFIG.quality })
                    .toFile(outputPath);
            }

            const newStats = fs.statSync(outputPath);
            const newSize = newStats.size;
            const reduction = Math.round(((originalSize - newSize) / originalSize) * 100);

            console.log(`✅ Compressed ${path.basename(inputPath)}: ${Math.round(originalSize/1024)}KB → ${Math.round(newSize/1024)}KB (${reduction}% reduction)`);

            return true;
        } catch (error) {
            console.error(`❌ Error compressing ${inputPath}:`, error.message);
            return false;
        }
    }

    async compressAllImagesInDir(dirPath) {
        try {
            const files = fs.readdirSync(dirPath);
            let processed = 0;

            for (const file of files) {
                const fullPath = path.join(dirPath, file);
                const stat = fs.statSync(fullPath);

                if (stat.isDirectory()) {
                    // Recursively process subdirectories
                    processed += await this.compressAllImagesInDir(fullPath);
                } else if (this.isImageFile(file)) {
                    const success = await this.compressImage(fullPath);
                    if (success) processed++;
                }
            }

            return processed;
        } catch (error) {
            console.error(`❌ Error processing directory ${dirPath}:`, error.message);
            return 0;
        }
    }

    isImageFile(filename) {
        const ext = path.extname(filename).toLowerCase().substring(1);
        return CONFIG.formats.includes(ext);
    }

    async processNewImage(filePath) {
        if (this.isImageFile(filePath)) {
            console.log(`📸 New image detected: ${filePath}`);
            await this.compressImage(filePath);
        }
    }

    async compressAllExistingImages() {
        console.log('🔄 Starting compression of all existing images...');
        
        let totalProcessed = 0;
        
        for (const dir of CONFIG.watchDirs) {
            if (fs.existsSync(dir)) {
                console.log(`📂 Processing directory: ${dir}`);
                const processed = await this.compressAllImagesInDir(dir);
                totalProcessed += processed;
            }
        }
        
        console.log(`\n🎉 Compression complete! ${totalProcessed} images processed.`);
        return totalProcessed;
    }

    // Method to set up file watching (optional - requires additional setup)
    setupFileWatcher() {
        console.log('🔧 Setting up file watcher for automatic compression...');
        
        CONFIG.watchDirs.forEach(dir => {
            if (fs.existsSync(dir)) {
                fs.watch(dir, { recursive: true }, (eventType, filename) => {
                    if (eventType === 'rename' && this.isImageFile(filename)) {
                        const fullPath = path.join(dir, filename);
                        if (fs.existsSync(fullPath)) {
                            console.log(`🆕 New image detected in ${dir}: ${filename}`);
                            setTimeout(() => {
                                this.processNewImage(fullPath);
                            }, 1000); // Small delay to ensure file is completely written
                        }
                    }
                });
                console.log(`👀 Watching directory: ${dir}`);
            }
        });
    }

    // Method to integrate with build process
    async runBuildHook() {
        console.log('🏗️  Running build-time image optimization...');
        await this.compressAllExistingImages();
    }
}

// CLI Interface
async function main() {
    const compressor = new AutoImageCompressor();
    
    const args = process.argv.slice(2);
    
    if (args.includes('--watch')) {
        // Watch mode - continuously monitor for new images
        console.log('👀 Auto-compression mode enabled (watch mode)');
        compressor.setupFileWatcher();
        console.log('Press Ctrl+C to stop watching...');
        
        // Keep the process alive
        process.on('SIGINT', () => {
            console.log('\n🛑 Stopping image watcher...');
            process.exit(0);
        });
    } else if (args.includes('--build')) {
        // Build hook mode - compress all images for production
        await compressor.runBuildHook();
    } else if (args.includes('--compress-all')) {
        // Compress all existing images
        await compressor.compressAllExistingImages();
    } else if (args.length > 0 && fs.existsSync(args[0])) {
        // Compress a specific image
        await compressor.compressImage(args[0]);
    } else {
        // Default: compress all existing images
        console.log('🚀 Trendtactics Academy Auto Image Compressor');
        console.log('===========================================');
        console.log('Options:');
        console.log('  node auto-compress.js                 - Compress all existing images');
        console.log('  node auto-compress.js --compress-all  - Compress all existing images');
        console.log('  node auto-compress.js --watch         - Watch mode for automatic compression');
        console.log('  node auto-compress.js --build         - Build hook mode');
        console.log('  node auto-compress.js <image-path>    - Compress specific image');
        console.log('');
        
        await compressor.compressAllExistingImages();
    }
}

// Export for use as module
module.exports = {
    AutoImageCompressor,
    CONFIG
};

// Run if this file is executed directly
if (require.main === module) {
    main().catch(console.error);
}