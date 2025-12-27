import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
// Removed mock data import to prevent using invalid course IDs
import { courseService } from "../services";

const Home = () => {
    const [realCourses, setRealCourses] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchRealCourses = async () => {
            try {
                setLoading(true);
                setError(null);
                
                // Always try to fetch real courses first
                const courses = await courseService.getAllCourses();
                
                // Validate that we got real courses with proper UUIDs
                if (courses && Array.isArray(courses) && courses.length > 0) {
                    // Filter out any courses without proper UUIDs
                    const validCourses = courses.filter(course => {
                        // Check if course.id looks like a UUID
                        return course.id && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
                    });
                    
                    // Prioritize featured courses if they exist, otherwise take first 3 valid courses
                    const featuredCourses = validCourses.filter(course => course.featured || course.is_featured || course.category === 'featured');
                    
                    if (featuredCourses.length > 0) {
                        // If we have featured courses, show up to 3 of them
                        setRealCourses(featuredCourses.slice(0, 3));
                    } else {
                        // Otherwise, show first 3 valid courses
                        setRealCourses(validCourses.slice(0, 3));
                    }
                } else {
                    console.warn('No valid courses found in Supabase');
                    setRealCourses([]); // Show empty state instead of mock data
                }
            } catch (error) {
                console.error('Error fetching real courses from Supabase:', error);
                setError(error.message);
                setRealCourses([]); // Show empty state instead of mock data
            } finally {
                setLoading(false);
            }
        };

        fetchRealCourses();
    }, []);

    // Only show courses if we have real ones from Supabase
    const coursesToShow = realCourses.length > 0 ? realCourses : [];

    const features = [
        {
            icon: (
                <svg className="w-8 h-8 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
            ),
            title: 'Expert Instructors',
            description: 'Learn from industry professionals with years of real-world experience.'
        },
        {
            icon: (
                <svg className="w-8 h-8 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 18h.01M8 21h8a1 1 0 001-1V4a1 1 0 00-1-1H8a1 1 0 00-1 1v16a1 1 0 001 1z" />
                </svg>
            ),
            title: 'Mobile Learning',
            description: 'Access your courses anywhere, anytime with our mobile-optimized platform.'
        },
        {
            icon: (
                <svg className="w-8 h-8 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
                </svg>
            ),
            title: 'Certification',
            description: 'Earn certificates upon completion to boost your professional credentials.'
        },
        {
            icon: (
                <svg className="w-8 h-8 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
            ),
            title: 'Community',
            description: 'Join a community of learners and network with like-minded professionals.'
        }
    ];

    if (loading) {
        return (
            <div className="min-h-screen bg-white flex items-center justify-center">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto mb-4"></div>
                    <p className="text-gray-600">Loading courses...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-white">
            {/* Hero Section with Parallax */}
            <section className="relative h-screen flex items-center justify-center overflow-hidden">
                <div 
                    className="absolute inset-0 bg-cover bg-center bg-fixed"
                    style={{ 
                        backgroundImage: "url('/images/homepage-parallex.jpg')",
                        backgroundAttachment: 'fixed'
                    }}
                ></div>
                <div className="absolute inset-0 bg-black opacity-60"></div>
                <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 lg:py-32 text-center">
                    <h1 className="text-4xl md:text-6xl font-heading font-bold mb-6 leading-tight text-white">
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
            </section>
            {/* Stats Section */}
            <div className="my-12">
                <div className="overflow-x-hidden pb-4 relative">
                    <div className="flex flex-nowrap gap-6 stats-carousel" style={{
                        animation: 'stats-scroll 30s linear infinite',
                        width: 'max-content',
                    }}>
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
                    {features.map((feature, index) => (
                        <div key={index} className="bg-gradient-to-br from-blue-100 to-blue-200 rounded-xl p-6 flex flex-col items-center shadow-md">
                            <div className="mb-4">{feature.icon}</div>
                            <h3 className="font-bold text-lg mb-1">{feature.title}</h3>
                            <p className="text-sm text-gray-600 text-center">{feature.description}</p>
                        </div>
                    ))}
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
                    
                    {coursesToShow.length > 0 ? (
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                            {coursesToShow.map((course) => (
                                <div key={course.id} className="card hover:shadow-xl transition-shadow duration-300">
                                    <div className="relative mb-4">
                                        <img 
                                            src={course.thumbnail || course.thumbnail_url || 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=250&fit=crop'} 
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
                                                        <svg 
                                                            key={i} 
                                                            className={`w-4 h-4 ${i < Math.floor(course.rating || 4.5) ? 'fill-current' : 'fill-gray-300'}`} 
                                                            viewBox="0 0 20 20"
                                                        >
                                                            <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                                        </svg>
                                                    ))}
                                                </div>
                                                <span className="ml-2 text-sm text-gray-600">({course.rating || 4.5})</span>
                                            </div>
                                            <span className="text-sm text-gray-500">
                                                {course.enrolledStudents || course.enrolled_students || 0} students
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div className="flex items-center justify-between">
                                        <span className="text-2xl font-heading font-bold text-brand-navy">
                                            ${course.price || 0}
                                        </span>
                                        <Link 
                                            to={`/course/${course.id}/overview`} 
                                            className="btn-primary"
                                        >
                                            View Course
                                        </Link>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <div className="text-center py-12">
                            <div className="text-4xl mb-4">📚</div>
                            <h3 className="text-xl font-medium text-gray-900 mb-2">No Courses Available</h3>
                            <p className="text-gray-600">We're working on adding new courses. Please check back soon!</p>
                        </div>
                    )}
                    
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
                    <div className="flex flex-nowrap gap-8 testimonial-carousel" style={{
                        animation: 'stats-scroll 40s linear infinite',
                        width: 'max-content',
                    }}>
                        {[...Array(2)].flatMap((_, repeatIdx) => [
                            <div key={`t1-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Testimonial 1" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"This platform transformed my career! The courses are practical and the instructors are top-notch."</p>
                                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                                <span className="font-semibold text-xs text-blue-700">Aisha Bello</span>
                                <span className="text-xs text-gray-500">Digital Marketer</span>
                            </div>,
                            <div key={`t2-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Testimonial 2" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"I landed my dream job after completing the advanced courses. Highly recommended!"</p>
                                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                                <span className="font-semibold text-xs text-blue-700">James Okoro</span>
                                <span className="text-xs text-gray-500">SEO Specialist</span>
                            </div>,
                            <div key={`t3-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Testimonial 3" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"The community and support are amazing. I never felt lost, even as a beginner."</p>
                                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                                <span className="font-semibold text-xs text-blue-700">Maria Lopez</span>
                                <span className="text-xs text-gray-500">Content Creator</span>
                            </div>,
                            <div key={`t4-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Testimonial 4" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"The hands-on projects made all the difference. I could apply what I learned right away."</p>
                                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                                <span className="font-semibold text-xs text-blue-700">Samuel Green</span>
                                <span className="text-xs text-gray-500">PPC Specialist</span>
                            </div>,
                            <div key={`t5-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Testimonial 5" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"I loved the mobile learning experience. I could study on the go!"</p>
                                <div className="flex items-center mb-1">{[...Array(5)].map((_, i) => <span key={i} className="text-yellow-400 text-base">★</span>)}</div>
                                <span className="font-semibold text-xs text-blue-700">Fatima Musa</span>
                                <span className="text-xs text-gray-500">Content Strategist</span>
                            </div>,
                            <div key={`t6-${repeatIdx}`} className="stats-card bg-white rounded-xl shadow-lg p-6 flex flex-col items-center min-w-[320px] max-w-[320px] h-[260px]">
                                <img src="https://randomuser.me/api/portraits/men/77.jpg" alt="Testimonial 6" className="w-14 h-14 rounded-full mb-2"/>
                                <p className="text-gray-700 text-center mb-2 text-sm">"Certification from Trendtactics helped me get a promotion at work!"</p>
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
                            <input type="email" required placeholder="Enter your email" className="rounded-l-md rounded-r-md sm:rounded-r-none px-4 py-2 w-full text-gray-900 focus:outline-none focus:ring-2 focus:ring-cyan-400"/>
                            <button type="submit" className="bg-cyan-500 hover:bg-cyan-600 text-white font-semibold px-6 py-2 rounded-md sm:rounded-l-none transition-colors">
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