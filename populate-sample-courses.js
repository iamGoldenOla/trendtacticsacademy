// Script to populate the database with sample courses
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Sample courses data
const sampleCourses = [
  {
    title: 'Introduction to Digital Marketing',
    description: 'Learn the fundamentals of digital marketing including SEO, social media, and email marketing.',
    instructor_id: 'demo_instructor_id', // This should be replaced with a real instructor ID
    category: 'Digital Marketing',
    level: 'beginner',
    duration: '4 weeks',
    price: 49,
    thumbnail_url: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400&h=250&fit=crop',
    is_published: true,
    objectives: [
      'Understand core digital marketing concepts',
      'Learn SEO fundamentals',
      'Master social media marketing strategies',
      'Create effective email campaigns'
    ],
    prerequisites: ['Basic computer skills']
  },
  {
    title: 'Advanced Web Development',
    description: 'Deep dive into modern web development technologies including React, Node.js, and databases.',
    instructor_id: 'demo_instructor_id', // This should be replaced with a real instructor ID
    category: 'Web Development',
    level: 'advanced',
    duration: '8 weeks',
    price: 99,
    thumbnail_url: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400&h=250&fit=crop',
    is_published: true,
    objectives: [
      'Build full-stack web applications',
      'Master React and state management',
      'Work with REST APIs and databases',
      'Deploy applications to production'
    ],
    prerequisites: ['Intermediate JavaScript knowledge', 'HTML/CSS basics']
  },
  {
    title: 'Data Science Fundamentals',
    description: 'Introduction to data science concepts, Python programming, and machine learning basics.',
    instructor_id: 'demo_instructor_id', // This should be replaced with a real instructor ID
    category: 'Data Science',
    level: 'intermediate',
    duration: '6 weeks',
    price: 79,
    thumbnail_url: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&h=250&fit=crop',
    is_published: true,
    objectives: [
      'Understand data science workflow',
      'Learn Python for data analysis',
      'Work with pandas and numpy',
      'Create data visualizations'
    ],
    prerequisites: ['Basic mathematics', 'Programming fundamentals']
  }
];

async function populateCourses() {
  try {
    console.log('Populating database with sample courses...');
    
    // Insert courses
    const { data, error } = await supabase
      .from('courses')
      .insert(sampleCourses)
      .select();
    
    if (error) {
      console.error('Error inserting courses:', error);
      return;
    }
    
    console.log('Successfully inserted courses:');
    data.forEach(course => {
      console.log(`- ${course.title} (ID: ${course.id})`);
    });
    
    // Create sample modules and lessons for the first course
    if (data.length > 0) {
      const firstCourseId = data[0].id;
      
      // Sample modules
      const modules = [
        {
          course_id: firstCourseId,
          title: 'Getting Started with Digital Marketing',
          description: 'Introduction to digital marketing concepts and tools',
          ordering: 1,
          duration: '1 week'
        },
        {
          course_id: firstCourseId,
          title: 'Search Engine Optimization',
          description: 'Learn how to optimize websites for search engines',
          ordering: 2,
          duration: '1 week'
        },
        {
          course_id: firstCourseId,
          title: 'Social Media Marketing',
          description: 'Strategies for effective social media marketing',
          ordering: 3,
          duration: '1 week'
        }
      ];
      
      // Insert modules
      const { data: modulesData, error: modulesError } = await supabase
        .from('modules')
        .insert(modules)
        .select();
      
      if (modulesError) {
        console.error('Error inserting modules:', modulesError);
        return;
      }
      
      console.log('Successfully inserted modules:');
      modulesData.forEach(module => {
        console.log(`- ${module.title} (ID: ${module.id})`);
      });
      
      // Sample lessons for the first module
      if (modulesData.length > 0) {
        const firstModuleId = modulesData[0].id;
        
        const lessons = [
          {
            module_id: firstModuleId,
            title: 'What is Digital Marketing?',
            content: '<h2>Introduction to Digital Marketing</h2><p>Digital marketing refers to advertising delivered through digital channels such as search engines, websites, social media, email, and mobile apps.</p>',
            ordering: 1,
            duration: '30 minutes'
          },
          {
            module_id: firstModuleId,
            title: 'Digital Marketing Channels',
            content: '<h2>Digital Marketing Channels</h2><p>There are many digital marketing channels including SEO, SEM, social media, email marketing, and content marketing.</p>',
            ordering: 2,
            duration: '45 minutes'
          }
        ];
        
        // Insert lessons
        const { data: lessonsData, error: lessonsError } = await supabase
          .from('lessons')
          .insert(lessons)
          .select();
        
        if (lessonsError) {
          console.error('Error inserting lessons:', lessonsError);
          return;
        }
        
        console.log('Successfully inserted lessons:');
        lessonsData.forEach(lesson => {
          console.log(`- ${lesson.title} (ID: ${lesson.id})`);
        });
      }
    }
    
    console.log('Database population completed successfully!');
  } catch (error) {
    console.error('Error populating database:', error);
  }
}

// Run the script
populateCourses();