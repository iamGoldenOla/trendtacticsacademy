// Configuration for Trendtactics Academy
const AppConfig = {
    // Feature flags
    features: {
        aiEnabled: true,           // Toggle AI functionality on/off
        aiFallbackEnabled: true,   // Use fallback content when AI fails
        debugMode: false           // Enable detailed logging
    },
    
    // API configuration
    api: {
        puterjsEnabled: true,      // Enable Puter.js integration
        fallbackTimeout: 3000      // Timeout for AI requests (ms)
    }
};

// Utility function to check if a feature is enabled
function isFeatureEnabled(featureName) {
    const features = AppConfig.features;
    return features.hasOwnProperty(featureName) ? features[featureName] : false;
}

// Utility function for safe API calls with fallback
async function safeApiCall(apiFunction, fallbackFunction, timeoutMs = AppConfig.api.fallbackTimeout) {
    if (!isFeatureEnabled('aiEnabled')) {
        if (isFeatureEnabled('aiFallbackEnabled')) {
            return await fallbackFunction();
        }
        return null;
    }

    return new Promise((resolve) => {
        const timeoutId = setTimeout(() => {
            console.warn('API call timeout, using fallback');
            if (isFeatureEnabled('aiFallbackEnabled')) {
                fallbackFunction().then(resolve);
            } else {
                resolve(null);
            }
        }, timeoutMs);

        apiFunction()
            .then(result => {
                clearTimeout(timeoutId);
                resolve(result);
            })
            .catch(error => {
                console.error('API call failed:', error);
                clearTimeout(timeoutId);
                if (isFeatureEnabled('aiFallbackEnabled')) {
                    fallbackFunction().then(resolve);
                } else {
                    resolve(null);
                }
            });
    });
}