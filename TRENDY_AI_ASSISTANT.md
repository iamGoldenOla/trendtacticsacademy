# Trendy AI Assistant Integration Guide

This document explains how to use the Trendy AI Assistant in your Trendtactics Academy LMS.

## Features

1. **Live Chat Interface** - A floating chat widget that users can interact with
2. **Conversational Course Creation** - Create courses through natural dialogue
3. **Course Recommendations** - Suggest courses based on user interests
4. **Content Generation** - Automatically generate course outlines and materials

## Components

### 1. TrendyAssistant Component
Located at: `src/components/TrendyAssistant.js`

This is the main chat interface that appears as a floating widget in the bottom-right corner of the screen.

### 2. AI Service
Located at: `src/services/aiService.js`

This service handles all interactions with the AI capabilities.

### 3. Course Creator Page
Located at: `src/pages/CourseCreator.js`

A dedicated page for creating courses through conversational AI.

## Setup Instructions

### 1. AI Service Integration
The AI service is already integrated in `src/services/aiService.js`.

### 2. Initialize the Service
The service automatically initializes when the TrendyAssistant component mounts.

### 3. Using the Components

#### For Live Chat
The TrendyAssistant is automatically included in App.js and will appear on all pages.

#### For Course Creation
Navigate to `/course-creator` to access the dedicated course creation interface.

## API Methods

### aiService.initialize()
Initializes the AI service connection.

### aiService.generateCourseContent(topic, userDetails)
Generates a course outline based on a topic and user details.

### aiService.createConversationalCourse(initialPrompt)
Starts a conversational course creation flow.

### aiService.processFeedback(courseContent, feedback)
Processes user feedback to improve course content.

### aiService.getCourseRecommendations(interests, skillLevel)
Gets personalized course recommendations.

## Customization

### Changing the Assistant Name
Modify the component name in `TrendyAssistant.js`.

### Adjusting the Chat Position
Edit the CSS classes in `TrendyAssistant.js` to change position.

### Modifying Course Topics
Update the `courses` array in `TrendyAssistant.js`.

## Testing

Run the demo script to see how the conversational course creation works:
```bash
cd lms-frontend
node src/demo/courseCreationDemo.js
```

## Troubleshooting

### "AI Service not found" Error
Ensure the service is properly imported in your component.

### "Invalid API key" Error
Check that your AI service API key is properly configured.

### Initialization Failures
Verify network connectivity and that the AI service is available.

## Security Notes

- Never expose API keys in client-side code
- Use environment variables for sensitive configuration
- Validate all user inputs before sending to AI services

## Future Enhancements

1. Integration with course database
2. Voice-to-text capabilities
3. Multi-language support
4. Advanced personalization algorithms
5. Integration with learning analytics

## Support

For issues with the Trendy AI Assistant integration, contact the development team.