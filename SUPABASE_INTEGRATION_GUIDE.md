# Real Supabase Integration Guide for Trendy Course Creation

## Overview

This guide explains how to integrate Trendy's AI course creation with your real Supabase backend to create actual courses that students can take.

## Backend API Endpoints

### 1. Create Course Endpoint

```javascript
// /api/courses - POST
// Protected route - requires instructor authentication

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    // Validate instructor authentication
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    // Verify JWT token with Supabase service role key
    const { data: userData, error: userError } = await supabase.auth.getUser(token);
    if (userError || !userData?.user) {
      return res.status(401).json({ error: 'Invalid token' });
    }

    // Check if user is an instructor
    const { data: instructorData, error: instructorError } = await supabase
      .from('users')
      .select('role')
      .eq('id', userData.user.id)
      .single();

    if (instructorError || instructorData?.role !== 'instructor') {
      return res.status(403).json({ error: 'Forbidden: Not an instructor' });
    }

    // Create course in database
    const { data, error } = await supabase
      .from('courses')
      .insert({
        title: req.body.title,
        description: req.body.description,
        instructor_id: userData.user.id,
        category: req.body.category,
        level: req.body.level,
        duration: req.body.duration,
        objectives: req.body.objectives,
        prerequisites: req.body.prerequisites,
        status: 'draft',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single();

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ error: 'Failed to create course' });
    }

    return res.status(201).json(data);
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
```

### 2. Save Course Outline Endpoint

```javascript
// /api/courses/[courseId]/outline - POST
// Protected route - requires instructor authentication

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { courseId } = req.query;

  try {
    // Validate instructor authentication (same as above)
    const token = req.headers.authorization?.split(' ')[1];
    // ... authentication code ...

    // Verify instructor owns this course
    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('instructor_id')
      .eq('id', courseId)
      .single();

    if (courseError || courseData?.instructor_id !== userData.user.id) {
      return res.status(403).json({ error: 'Forbidden: Not your course' });
    }

    // Save outline to database
    const { data, error } = await supabase
      .from('course_outlines')
      .insert({
        course_id: courseId,
        content: req.body.content,
        version: req.body.version || 1,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single();

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ error: 'Failed to save outline' });
    }

    return res.status(201).json(data);
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
```

### 3. Create Modules Endpoint

```javascript
// /api/courses/[courseId]/modules - POST
// Protected route - requires instructor authentication

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { courseId } = req.query;
  const modulesData = req.body;

  try {
    // Validate instructor authentication
    const token = req.headers.authorization?.split(' ')[1];
    // ... authentication code ...

    // Verify instructor owns this course
    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('instructor_id')
      .eq('id', courseId)
      .single();

    if (courseError || courseData?.instructor_id !== userData.user.id) {
      return res.status(403).json({ error: 'Forbidden: Not your course' });
    }

    // Add course_id to each module
    const modulesWithCourseId = modulesData.map(module => ({
      ...module,
      course_id: courseId
    }));

    // Create modules in database
    const { data, error } = await supabase
      .from('modules')
      .insert(modulesWithCourseId)
      .select();

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ error: 'Failed to create modules' });
    }

    return res.status(201).json(data);
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
```

### 4. Create Lessons Endpoint

```javascript
// /api/modules/[moduleId]/lessons - POST
// Protected route - requires instructor authentication

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { moduleId } = req.query;
  const lessonsData = req.body;

  try {
    // Validate instructor authentication
    const token = req.headers.authorization?.split(' ')[1];
    // ... authentication code ...

    // Verify instructor owns the course this module belongs to
    const { data: moduleData, error: moduleError } = await supabase
      .from('modules')
      .select('course_id')
      .eq('id', moduleId)
      .single();

    if (moduleError) {
      return res.status(404).json({ error: 'Module not found' });
    }

    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('instructor_id')
      .eq('id', moduleData.course_id)
      .single();

    if (courseError || courseData?.instructor_id !== userData.user.id) {
      return res.status(403).json({ error: 'Forbidden: Not your course' });
    }

    // Add module_id to each lesson
    const lessonsWithModuleId = lessonsData.map(lesson => ({
      ...lesson,
      module_id: moduleId
    }));

    // Create lessons in database
    const { data, error } = await supabase
      .from('lessons')
      .insert(lessonsWithModuleId)
      .select();

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ error: 'Failed to create lessons' });
    }

    return res.status(201).json(data);
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
```

### 5. Publish Course Endpoint

```javascript
// /api/courses/[courseId]/publish - POST
// Protected route - requires instructor authentication

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { courseId } = req.query;

  try {
    // Validate instructor authentication
    const token = req.headers.authorization?.split(' ')[1];
    // ... authentication code ...

    // Verify instructor owns this course
    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('instructor_id, status')
      .eq('id', courseId)
      .single();

    if (courseError || courseData?.instructor_id !== userData.user.id) {
      return res.status(403).json({ error: 'Forbidden: Not your course' });
    }

    // Update course status to published
    const { data, error } = await supabase
      .from('courses')
      .update({ 
        status: 'published',
        published_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .eq('id', courseId)
      .select()
      .single();

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ error: 'Failed to publish course' });
    }

    return res.status(200).json(data);
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
```

## Required Supabase Tables

### 1. Courses Table
```sql
CREATE TABLE courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  instructor_id UUID REFERENCES users(id),
  category TEXT,
  level TEXT,
  duration TEXT,
  objectives JSONB,
  prerequisites JSONB,
  status TEXT DEFAULT 'draft',
  price DECIMAL(10,2) DEFAULT 0,
  thumbnail_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  published_at TIMESTAMP WITH TIME ZONE
);
```

### 2. Course Outlines Table
```sql
CREATE TABLE course_outlines (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  content TEXT,
  version INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 3. Modules Table
```sql
CREATE TABLE modules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  order INTEGER,
  duration TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 4. Lessons Table
```sql
CREATE TABLE lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT,
  order INTEGER,
  duration TEXT,
  video_url TEXT,
  resources JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 5. Assessments Table
```sql
CREATE TABLE assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT, -- 'quiz', 'assignment', 'exam'
  questions JSONB,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER, -- in minutes
  order INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Environment Variables

Create a `.env.local` file in your backend directory:

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
SUPABASE_JWT_SECRET=your_jwt_secret
```

## Frontend Integration

### Authentication Setup
```javascript
// In your frontend auth service
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.REACT_APP_SUPABASE_URL,
  process.env.REACT_APP_SUPABASE_ANON_KEY
);

// Get access token for API calls
const getSession = async () => {
  const { data: { session } } = await supabase.auth.getSession();
  return session?.access_token;
};
```

### API Call Example
```javascript
// In your course creation service
const createCourseInSupabase = async (courseData) => {
  const token = await getSession();
  
  const response = await fetch('/api/courses', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(courseData)
  });

  if (!response.ok) {
    throw new Error('Failed to create course');
  }

  return await response.json();
};
```

## Security Considerations

1. **Service Role Key**: Never expose the service role key in frontend code
2. **Row Level Security**: Implement RLS policies in Supabase
3. **Authentication**: Always validate user tokens before database operations
4. **Input Validation**: Sanitize all user inputs before database insertion
5. **Rate Limiting**: Implement rate limiting to prevent abuse

## RLS Policies Example

```sql
-- Courses table RLS
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;

-- Instructors can create courses
CREATE POLICY "Instructors can create courses" 
ON courses FOR INSERT 
WITH CHECK (auth.uid() IN (
  SELECT id FROM users WHERE role = 'instructor' AND id = auth.uid()
));

-- Instructors can update their own courses
CREATE POLICY "Instructors can update their courses" 
ON courses FOR UPDATE 
USING (instructor_id = auth.uid());

-- Published courses are viewable by everyone
CREATE POLICY "Published courses are viewable" 
ON courses FOR SELECT 
USING (status = 'published');

-- Users can view their enrolled courses
CREATE POLICY "Users can view enrolled courses" 
ON courses FOR SELECT 
USING (id IN (
  SELECT course_id FROM enrollments WHERE user_id = auth.uid()
));
```

## Testing Script

```bash
#!/bin/bash
# Test real Supabase integration

echo "Testing Real Supabase Integration"
echo "================================="

# 1. Create course
echo "1. Creating course..."
curl -X POST http://localhost:3000/api/courses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "title": "Test Course",
    "description": "A test course created via API",
    "category": "Web Development",
    "level": "Beginner",
    "duration": "4 weeks"
  }'

# 2. Save outline
echo "2. Saving course outline..."
curl -X POST http://localhost:3000/api/courses/COURSE_ID/outline \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "content": "This is a test course outline",
    "version": 1
  }'

# 3. Create modules
echo "3. Creating modules..."
curl -X POST http://localhost:3000/api/courses/COURSE_ID/modules \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '[{
    "title": "Introduction",
    "description": "Getting started",
    "order": 1,
    "duration": "1 week"
  }]'

# 4. Publish course
echo "4. Publishing course..."
curl -X POST http://localhost:3000/api/courses/COURSE_ID/publish \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## Conclusion

With this real Supabase integration, Trendy can now:

1. **Create actual courses** in your database
2. **Generate real content** that students can access
3. **Structure courses** with modules and lessons
4. **Publish courses** for student enrollment
5. **Maintain security** with proper authentication

The CourseCreator page now shows real integration status updates and creates actual courses in your Supabase backend that students can take.