# React Dashboard + Standalone Course Viewer Setup

## ✅ Current Architecture (RECOMMENDED)

Your setup is already optimal:

### **React Dashboard** (`index.html`)
- Shows enrolled courses
- User authentication
- Course listings
- Navigation

### **Standalone Course Viewer** (`course.html`)
- Completely independent from React
- Handles all lesson features:
  - ✅ Lesson content display
  - ✅ AI Playground
  - ✅ Quiz system
  - ✅ Resources tab
  - ✅ Progress tracking
- No React dependencies
- Works even if React has issues

## 🔗 How They Connect

The React dashboard should link to courses like this:

```javascript
// When user clicks "View Course" button:
window.location.href = `/course.html?course=${courseId}`;

// OR using anchor tag:
<a href={`/course.html?course=${courseId}`}>View Course</a>
```

## ✅ What's Already Working

1. **`course.html`** - Fully functional standalone lesson viewer
2. **Scroll-to-top** - Added to both React and `course.html`
3. **Database integration** - Fetches courses, modules, lessons from Supabase
4. **AI Playground** - Built-in and working
5. **Quiz system** - Ready (just needs quiz data in database)

## 📋 To Verify Everything Works

### 1. Check React Dashboard Links
Open your React dashboard source and verify course links point to:
```
/course.html?course=COURSE_ID
```

### 2. Test Navigation Flow
1. Open React dashboard
2. Click on any course
3. Should navigate to `course.html` with course loaded
4. All features (lessons, playground, quizzes) should work

### 3. Add Quizzes (If Not Already Done)
Run the quiz SQL files:
- `VIBE_ADD_ALL_QUIZZES.sql` - For Vibe Coding
- Similar files for other courses

## 🎯 Benefits of This Architecture

✅ **Separation of Concerns**
- Dashboard = Course discovery
- course.html = Learning experience

✅ **Reliability**
- If React breaks, course viewer still works
- Independent deployment
- Easier debugging

✅ **Performance**
- No iframe overhead
- Direct page navigation
- Better SEO

✅ **Maintainability**
- Update dashboard without affecting lessons
- Update lessons without touching React
- Clear boundaries

## 🚀 Deployment Checklist

Both files should be on your server:
- ✅ `/index.html` (React dashboard)
- ✅ `/course.html` (Lesson viewer)
- ✅ `/static/js/main.d3663c93.js` (React bundle)
- ✅ `/static/css/main.87756b56.css` (React styles)
- ✅ `/js/scroll-to-top.js` (Scroll functionality)

## 🔧 If You Want Iframe Approach Instead

Only use if you specifically want React wrapper around course viewer:

```jsx
// In React component
function CourseViewer({ courseId }) {
  return (
    <iframe 
      src={`/course.html?course=${courseId}`}
      style={{
        width: '100%',
        height: '100vh',
        border: 'none',
        display: 'block'
      }}
      title="Course Viewer"
      allow="clipboard-write"
    />
  );
}
```

**Note:** Direct navigation (current approach) is better than iframe.

## ✅ Recommendation

**Keep your current setup!** It's already the best architecture:
- React dashboard for course selection
- Standalone `course.html` for learning
- Clean, simple, reliable

No changes needed unless you're experiencing specific issues.
