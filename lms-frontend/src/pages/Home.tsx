import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Course } from '../types';
import * as supabaseCourseService from '../services/supabaseCourseService';

/*
<style jsx global>{`
@keyframes testimonial-scroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}
.testimonial-carousel {
  animation: testimonial-scroll 40s linear infinite;
}
.testimonial-carousel:hover {
  animation-play-state: paused;
}
@keyframes stats-scroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}
.stats-carousel {
  animation: stats-scroll 30s linear infinite;
  perspective: 800px;
}
.stats-card {
  transform: rotateY(-8deg) scale(1.05);
  transition: transform 0.3s cubic-bezier(.4,2,.6,1);
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
}
.stats-card:hover {
  transform: rotateY(0deg) scale(1.12);
  box-shadow: 0 16px 40px 0 rgba(31, 38, 135, 0.22);
}
`}</style>
*/

const Home: React.FC = () => {
  const [featuredCourses, setFeaturedCourses] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchFeaturedCourses = async () => {
      try {
        setLoading(true);
        // Fetch courses from Supabase
        const courses = await supabaseCourseService.getAllCourses();
        setFeaturedCourses(courses);
      } catch (error) {
        console.error('Error fetching featured courses:', error);
        setFeaturedCourses([]);
      } finally {
        setLoading(false);
      }
    };

    fetchFeaturedCourses();
  }, []);

  const features = [
    {
      icon: '🎓',
      title: 'Expert Instructors',
      description: 'Learn from industry professionals with years of real-world experience.'
    },
    {
      icon: '📱',
      title: 'Mobile Learning',
      description: 'Access your courses anywhere, anytime with our mobile-optimized platform.'
    },
    {
      icon: '🏆',
      title: 'Certification',
      description: 'Earn certificates upon completion to boost your professional credentials.'
    },
    {
      icon: '👥',
      title: 'Community',
      description: 'Join a community of learners and network with like-minded professionals.'
    }
  ];

  const stats = [
    { number: '50K+', label: 'Students Enrolled' },
    { number: '200+', label: 'Expert Courses' },
    { number: '95%', label: 'Completion Rate' },
    { number: '4.8', label: 'Average Rating' }
  ];

  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="relative bg-gradient-to-br from-brand-navy via-blue-900 to-brand-navy text-white">
        <div className="absolute inset-0 bg-black opacity-20"></div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 lg:py-32">
          <div className="text-center">
            <h1 className="text-4xl md:text-6xl font-heading font-bold mb-6 leading-tight">
              Transform Your Career with
              <span className="text-brand-cyan block">Digital Excellence</span>
            </h1>
            <p className="text-xl md:text-2xl text-gray-200 mb-8 max-w-3xl mx-auto">
              Master in-demand digital skills with expert-led courses designed for the modern workforce. 
              Start your journey to success today.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Link to="/courses" className="btn-secondary text-lg px-8 py-4 inline-block text-center">
                Explore Courses
              </Link>
              <button className="bg-white text-brand-navy px-8 py-4 rounded-lg font-medium hover:bg-gray-100 transition-colors duration-200 text-lg">
                Watch Demo
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <div className="my-12">
        <div className="overflow-x-hidden pb-4 relative">
          <div
            className="flex flex-nowrap gap-6 stats-carousel"
            style={{
              animation: 'stats-scroll 30s linear infinite',
              width: 'max-content',
            }}
          >
            {[...Array(2)].flatMap((_, repeatIdx) => [
              <div key={`stat1-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-8 flex flex-col items-center min-w-[220px] max-w-[220px] h-[140px] mx-2">
                <span className="text-3xl font-bold text-blue-700 mb-1">50K+</span>
                <span className="text-sm text-gray-600">Students Enrolled</span>
              </div>,
              <div key={`stat2-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-8 flex flex-col items-center min-w-[220px] max-w-[220px] h-[140px] mx-2">
                <span className="text-3xl font-bold text-green-600 mb-1">24</span>
                <span className="text-sm text-gray-600">Expert Courses</span>
              </div>,
              <div key={`stat3-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-8 flex flex-col items-center min-w-[220px] max-w-[220px] h-[140px] mx-2">
                <span className="text-3xl font-bold text-yellow-600 mb-1">95%</span>
                <span className="text-sm text-gray-600">Completion Rate</span>
              </div>,
              <div key={`stat4-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-8 flex flex-col items-center min-w-[220px] max-w-[220px] h-[140px] mx-2">
                <span className="text-3xl font-bold text-pink-600 mb-1">4.8</span>
                <span className="text-sm text-gray-600">Average Rating</span>
              </div>,
            ])}
          </div>
        </div>
      </div>

      {/* Features Section */}
      <div className="my-12">
        <h2 className="text-3xl font-bold text-center mb-2">Why Choose Trendtactics Academy?</h2>
        <p className="text-center text-gray-600 mb-8">We provide everything you need to succeed in the digital economy.</p>
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="bg-gradient-to-br from-blue-100 to-blue-200 rounded-xl p-6 flex flex-col items-center shadow-md">
            <span className="text-3xl mb-2">🚀</span>
            <h3 className="font-bold text-lg mb-1">Expert Instructors</h3>
            <p className="text-sm text-gray-600 text-center">Learn from industry professionals with years of real-world experience.</p>
          </div>
          <div className="bg-gradient-to-br from-green-100 to-green-200 rounded-xl p-6 flex flex-col items-center shadow-md">
            <span className="text-3xl mb-2">📱</span>
            <h3 className="font-bold text-lg mb-1">Mobile Learning</h3>
            <p className="text-sm text-gray-600 text-center">Access your courses anywhere, anytime with our mobile-optimized platform.</p>
          </div>
          <div className="bg-gradient-to-br from-yellow-100 to-yellow-200 rounded-xl p-6 flex flex-col items-center shadow-md">
            <span className="text-3xl mb-2">🏆</span>
            <h3 className="font-bold text-lg mb-1">Certification</h3>
            <p className="text-sm text-gray-600 text-center">Earn certificates upon completion to boost your professional credentials.</p>
          </div>
          <div className="bg-gradient-to-br from-pink-100 to-pink-200 rounded-xl p-6 flex flex-col items-center shadow-md">
            <span className="text-3xl mb-2">🤝</span>
            <h3 className="font-bold text-lg mb-1">Community</h3>
            <p className="text-sm text-gray-600 text-center">Join a community of learners and network with like-minded professionals.</p>
          </div>
        </div>
      </div>

      {/* Featured Courses Section */}
      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-heading font-bold text-gray-900 mb-4">
              Featured Courses
            </h2>
            <p className="text-xl text-gray-600 max-w-2xl mx-auto">
              Start with our most popular courses and build your digital skills
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {featuredCourses.map((course) => (
              <div key={course.id} className="card hover:shadow-xl transition-shadow duration-300">
                <div className="relative mb-4">
                  <img
                    src={course.thumbnail_url || course.thumbnail || 'https://placehold.co/400x200'}
                    alt={course.title}
                    className="w-full h-48 object-cover rounded-lg"
                  />
                  <div className="absolute top-3 right-3 bg-brand-cyan text-white px-2 py-1 rounded text-sm font-medium">
                    {course.level}
                  </div>
                </div>
                
                <div className="mb-4">
                  <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                    {course.title}
                  </h3>
                  <p className="text-gray-600 text-sm mb-3">
                    {course.description}
                  </p>
                  
                  <div className="flex items-center justify-between text-sm text-gray-500 mb-4">
                    <span>By {course.instructor?.name || 'Instructor'}</span>
                    <span>{course.duration}</span>
                  </div>
                  
                  <div className="flex items-center justify-between mb-4">
                    <div className="flex items-center">
                      <div className="flex text-yellow-400">
                        {[...Array(5)].map((_, i) => (
                          <svg key={i} className={`w-4 h-4 ${i < Math.floor(course.rating || 4.5) ? 'fill-current' : 'fill-gray-300'}`} viewBox="0 0 20 20">
                            <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                          </svg>
                        ))}
                      </div>
                      <span className="ml-2 text-sm text-gray-600">({course.rating || 4.5})</span>
                    </div>
                    <span className="text-sm text-gray-500">{course.enrolledStudents || course.enrolled_students || 0} students</span>
                  </div>
                </div>
                
                <div className="flex items-center justify-between">
                  <span className="text-2xl font-heading font-bold text-brand-navy">
                    ${course.price || 0}
                  </span>
                  <Link to={`/course/${course.id}`} className="btn-primary">
                    View Course
                  </Link>
                </div>
              </div>
            ))}
          </div>
          
          <div className="text-center mt-12">
            <Link to="/courses" className="btn-secondary">
              View All Courses
            </Link>
          </div>
        </div>
      </section>

      {/* Testimonial Section */}
      <div className="my-16">
        <h2 className="text-2xl font-bold text-center mb-8">What Our Learners Say</h2>
        <div className="overflow-x-hidden pb-4 relative">
          <div
            className="flex flex-nowrap gap-8 testimonial-carousel"
            style={{
              animation: 'stats-scroll 40s linear infinite',
              width: 'max-content',
            }}
          >
            {[...Array(2)].flatMap((_, repeatIdx) => [
              <div key={`t1-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Testimonial 1" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“This platform transformed my career! The courses are practical and the instructors are top-notch.”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">Aisha Bello</span>
                <span className="text-xs text-gray-500">Digital Marketer</span>
              </div>,
              <div key={`t2-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Testimonial 2" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“I landed my dream job after completing the advanced courses. Highly recommended!”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">James Okoro</span>
                <span className="text-xs text-gray-500">SEO Specialist</span>
              </div>,
              <div key={`t3-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Testimonial 3" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“The community and support are amazing. I never felt lost, even as a beginner.”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">Maria Lopez</span>
                <span className="text-xs text-gray-500">Content Creator</span>
              </div>,
              <div key={`t4-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Testimonial 4" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“The hands-on projects made all the difference. I could apply what I learned right away.”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">Samuel Green</span>
                <span className="text-xs text-gray-500">PPC Specialist</span>
              </div>,
              <div key={`t5-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Testimonial 5" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“I loved the mobile learning experience. I could study on the go!”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">Fatima Musa</span>
                <span className="text-xs text-gray-500">Content Strategist</span>
              </div>,
              <div key={`t6-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                <img src="https://randomuser.me/api/portraits/men/77.jpg" alt="Testimonial 6" className="w-14 h-14 rounded-full mb-2" />
                <p className="text-gray-700 text-center mb-2 text-sm">“Certification from Trendtactics helped me get a promotion at work!”</p>
                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                <span className="font-semibold text-xs text-blue-700">David Chen</span>
                <span className="text-xs text-gray-500">Marketing Manager</span>
              </div>,
            ])}
          </div>
        </div>
      </div>

      {/* CTA Section */}
      <section className="py-20 bg-brand-navy text-white mb-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl md:text-4xl font-heading font-bold mb-6">
            Ready to Transform Your Career?
          </h2>
          <p className="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
            Join thousands of learners who have already taken the first step towards their digital future.
          </p>
          <Link to="/courses" className="btn-secondary text-lg px-8 py-4 inline-block">
            Get Started Today
          </Link>
        </div>
      </section>

      {/* Footer Section */}
      <footer className="bg-brand-navy text-white mt-8">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          {/* Email Subscriber Form */}
          <div className="mb-8 flex flex-col items-center">
            <h3 className="text-lg font-semibold mb-2">Subscribe to our Newsletter</h3>
            <p className="text-sm text-gray-200 mb-4 text-center max-w-md">Get updates on new courses, exclusive offers, and digital marketing tips delivered to your inbox.</p>
            <form className="flex flex-col sm:flex-row gap-2 w-full max-w-md" onSubmit={e => { e.preventDefault(); alert('Thank you for subscribing!'); }}>
              <input
                type="email"
                required
                placeholder="Enter your email"
                className="rounded-l-md rounded-r-md sm:rounded-r-none px-4 py-2 w-full text-gray-900 focus:outline-none focus:ring-2 focus:ring-cyan-400"
              />
              <button
                type="submit"
                className="bg-cyan-500 hover:bg-cyan-600 text-white font-semibold px-6 py-2 rounded-md sm:rounded-l-none transition-colors"
              >
                Subscribe
              </button>
            </form>
          </div>
          {/* Existing footer content here */}
        </div>
      </footer>
    </div>
  );
};

export default Home; 