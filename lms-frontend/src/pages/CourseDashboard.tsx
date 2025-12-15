import React from 'react';
import { useParams, Link } from 'react-router-dom';
import { digitalMarketingCourses } from '../data/digitalMarketingCourses';

// Mock course data (should match MyCourses mock data)
const mockCourses = [
  {
    id: 'dm-1',
    title: 'Fundamentals of Digital Marketing',
    instructor: 'Jane Doe',
    thumbnail: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=250&fit=crop',
    progress: 80,
    community: true,
    lessons: [
      { id: 'l1', title: 'Introduction', completed: true },
      { id: 'l2', title: 'SEO Basics', completed: true },
      { id: 'l3', title: 'Social Media', completed: false },
      { id: 'l4', title: 'Email Marketing', completed: false },
    ],
  },
  {
    id: 'dm-2',
    title: 'Website Design for Beginners',
    instructor: 'John Smith',
    thumbnail: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=250&fit=crop',
    progress: 100,
    community: false,
    lessons: [
      { id: 'l1', title: 'Getting Started', completed: true },
      { id: 'l2', title: 'Design Principles', completed: true },
      { id: 'l3', title: 'Responsive Design', completed: true },
    ],
  },
];

const CourseDashboard: React.FC = () => {
  const { courseId } = useParams<{ courseId: string }>();
  const course = digitalMarketingCourses.find((c) => c.id === courseId);

  if (!course) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center bg-gray-50 py-12 px-4">
        <h1 className="text-2xl font-bold text-brand-navy mb-4">Course Not Found</h1>
        <Link to="/my-courses" className="btn-secondary text-lg px-8 py-3 inline-block">
          Back to My Courses
        </Link>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex flex-col items-center bg-gray-50 py-12 px-4">
      <div className="bg-white rounded-xl shadow-lg p-8 w-full max-w-2xl mb-8">
        <div className="flex flex-col md:flex-row gap-6 items-center">
          <img
            src={course.thumbnail}
            alt={course.title}
            className="w-40 h-28 object-cover rounded-lg shadow-md"
            loading="lazy"
          />
          <div className="flex-1">
            <h1 className="text-2xl md:text-3xl font-heading font-bold text-brand-navy mb-1">{course.title}</h1>
            <p className="text-gray-500 text-sm mb-2">By {typeof course.instructor === 'object' ? course.instructor.name : course.instructor}</p>
            {/* Progress bar and completion status removed due to missing 'progress' property */}
            <div className="flex gap-2 mt-2">
              <button className="btn-primary flex-1 text-center text-sm">Continue Learning</button>
              {/* Community button removed due to missing 'community' property */}
            </div>
          </div>
        </div>
      </div>
      <div className="w-full max-w-2xl bg-white rounded-xl shadow p-6 mb-8">
        <h2 className="text-lg font-semibold text-brand-navy mb-4">Lessons</h2>
        <ul className="divide-y divide-gray-200">
          {course.lessons.map((lesson, idx) => (
            <li key={lesson.id} className="flex items-center justify-between py-3">
              <div className="flex items-center gap-2">
                <span className={`w-3 h-3 rounded-full ${lesson.isCompleted ? 'bg-green-400' : 'bg-gray-300'} inline-block`}></span>
                <span className={`text-base ${lesson.isCompleted ? 'text-gray-700 line-through' : 'text-brand-navy font-medium'}`}>{idx + 1}. {lesson.title}</span>
              </div>
              <Link to={`/course/${course.id}/lesson/${lesson.id}`} className="btn-secondary text-xs px-4 py-2">
                View Lesson
              </Link>
            </li>
          ))}
        </ul>
      </div>
      <div className="w-full max-w-2xl bg-white rounded-xl shadow p-6 mb-8">
        <h2 className="text-lg font-semibold text-brand-navy mb-4">Course Resources</h2>
        <ul className="list-disc pl-6 text-brand-navy">
          <li><a href="#" className="underline">Download Course PDF</a></li>
          <li><a href="#" className="underline">Marketing Templates</a></li>
          <li><a href="#" className="underline">Recommended Tools</a></li>
        </ul>
      </div>
      <div className="w-full max-w-2xl bg-white rounded-xl shadow p-6 mb-8">
        <h2 className="text-lg font-semibold text-brand-navy mb-4">Notes</h2>
        <textarea className="w-full border rounded p-2 min-h-[100px]" placeholder="Take your notes here..."></textarea>
      </div>
      <div className="w-full max-w-2xl bg-white rounded-xl shadow p-6 mb-8">
        <h2 className="text-lg font-semibold text-brand-navy mb-4">Quiz</h2>
        <p>Quiz section coming soon!</p>
      </div>
      <Link to="/my-courses" className="btn-secondary text-lg px-8 py-3 inline-block">
        Back to My Courses
      </Link>
    </div>
  );
};

export default CourseDashboard;