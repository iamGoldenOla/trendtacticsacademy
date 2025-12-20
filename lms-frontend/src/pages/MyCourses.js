import React from "react";
import { Link } from "react-router-dom";
// Removed digitalMarketingCourses import to use real course data
// TODO: Replace with real enrolled courses data
const enrolledCourses = [];
const MyCourses = () => (<div className="min-h-screen flex flex-col items-center bg-gray-50 py-12 px-4">
    <h1 className="text-3xl md:text-4xl font-heading font-bold text-brand-navy mb-4">My Courses</h1>
    {enrolledCourses.length === 0 ? (<>
        <p className="text-gray-600 mb-8 text-center max-w-md">
          You have not enrolled in any courses yet. When you enroll, your courses will appear here for easy access and progress tracking.
        </p>
        <Link to="/courses" className="btn-secondary text-lg px-8 py-3 inline-block">
          Browse Courses
        </Link>
      </>) : (<div className="w-full max-w-5xl grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mt-8">
        {enrolledCourses.map((course) => (<div key={course.id} className="bg-white rounded-xl shadow-lg p-6 flex flex-col">
            <img src={course.thumbnail} alt={course.title} className="w-full h-40 object-cover rounded-lg mb-4" loading="lazy"/>
            <h2 className="text-xl font-heading font-semibold text-brand-navy mb-1">{course.title}</h2>
            <div className="flex items-center mb-2">
              <span className="text-xs text-gray-600 font-medium w-10 text-right">{course.level}</span>
            </div>
            <div className="flex gap-2 mt-auto">
              <Link to={`/course/${course.id}/lesson/l1`} className="btn-primary flex-1 text-center text-sm">
                Continue
              </Link>
            </div>
          </div>))}
      </div>)}
  </div>);
export default MyCourses;
