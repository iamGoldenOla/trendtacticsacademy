import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { courseService } from "../services";

const Courses = () => {
    const [courses, setCourses] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedLevel, setSelectedLevel] = useState('all');
    const [sortBy, setSortBy] = useState('popular');
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState(null);

    const levels = ['all', 'beginner', 'intermediate', 'advanced'];
    const sortOptions = [
        { value: 'popular', label: 'Most Popular' },
        { value: 'newest', label: 'Newest' },
        { value: 'price-low', label: 'Price: Low to High' },
        { value: 'price-high', label: 'Price: High to Low' },
        { value: 'rating', label: 'Highest Rated' }
    ];

    // Mock data as fallback with modules and lessons
    const mockCourses = [
        {
            id: '1',
            title: 'Complete Web Development Masterclass',
            description: 'Learn full-stack web development with HTML, CSS, JavaScript, React, Node.js, and more.',
            level: 'beginner',
            duration: '8 weeks',
            price: 99,
            thumbnail_url: 'https://placehold.co/400x200/2563eb/white?text=Web+Development',
            created_at: '2023-01-15T00:00:00Z',
            modules: [
                {
                    id: 'm1',
                    title: 'HTML & CSS Basics',
                    description: 'Learn the fundamentals of web development',
                    ordering: 1,
                    duration: '2 weeks',
                    lessons: [
                        { id: 'l1', title: 'Introduction to HTML', ordering: 1, duration: '30 mins' },
                        { id: 'l2', title: 'CSS Styling', ordering: 2, duration: '45 mins' }
                    ]
                },
                {
                    id: 'm2',
                    title: 'JavaScript Fundamentals',
                    description: 'Master JavaScript for interactive websites',
                    ordering: 2,
                    duration: '3 weeks',
                    lessons: [
                        { id: 'l3', title: 'Variables and Data Types', ordering: 1, duration: '40 mins' },
                        { id: 'l4', title: 'Functions and Scope', ordering: 2, duration: '50 mins' }
                    ]
                }
            ]
        },
        {
            id: '2',
            title: 'Mobile App Development with React Native',
            description: 'Build cross-platform mobile apps for iOS and Android using React Native.',
            level: 'intermediate',
            duration: '6 weeks',
            price: 129,
            thumbnail_url: 'https://placehold.co/400x200/2563eb/white?text=App+Development',
            created_at: '2023-02-20T00:00:00Z',
            modules: [
                {
                    id: 'm3',
                    title: 'React Native Basics',
                    description: 'Introduction to React Native framework',
                    ordering: 1,
                    duration: '3 weeks',
                    lessons: [
                        { id: 'l5', title: 'Setting up Environment', ordering: 1, duration: '35 mins' },
                        { id: 'l6', title: 'Components and Props', ordering: 2, duration: '45 mins' }
                    ]
                }
            ]
        },
        {
            id: '3',
            title: 'Digital Marketing Complete Course',
            description: 'Master digital marketing strategies including SEO, social media, email marketing, and more.',
            level: 'beginner',
            duration: '5 weeks',
            price: 79,
            thumbnail_url: 'https://placehold.co/400x200/2563eb/white?text=Digital+Marketing',
            created_at: '2023-03-10T00:00:00Z',
            modules: [
                {
                    id: 'm4',
                    title: 'SEO Fundamentals',
                    description: 'Learn search engine optimization basics',
                    ordering: 1,
                    duration: '2 weeks',
                    lessons: [
                        { id: 'l7', title: 'Keyword Research', ordering: 1, duration: '40 mins' },
                        { id: 'l8', title: 'On-page Optimization', ordering: 2, duration: '50 mins' }
                    ]
                }
            ]
        }
    ];

    // Fetch courses from API
    useEffect(() => {
        const fetchCourses = async () => {
            try {
                setIsLoading(true);
                setError(null);
                
                // Try to fetch from Supabase
                const data = await courseService.getAllCourses();
                
                // If we get data, use it
                if (data && data.length > 0) {
                    setCourses(data);
                } else {
                    // Fallback to mock data if no courses from API
                    console.warn('No courses from API, using mock data');
                    setCourses(mockCourses);
                }
            } catch (err) {
                console.error('Error fetching courses:', err);
                // Fallback to mock data on error
                setCourses(mockCourses);
                setError('Courses are being generated by AI. Showing sample data while we prepare your personalized courses.');
            } finally {
                setIsLoading(false);
            }
        };
        
        fetchCourses();
    }, []);

    // Filter and sort courses
    const filteredCourses = courses
        .filter(course => {
        const matchesSearch = course.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
            course.description.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesLevel = selectedLevel === 'all' || course.level === selectedLevel;
        return matchesSearch && matchesLevel;
    })
        .sort((a, b) => {
        switch (sortBy) {
            case 'popular':
                return ((b.lessons?.length) || 0) - ((a.lessons?.length) || 0);
            case 'newest':
                return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
            case 'price-low':
                return a.price - b.price;
            case 'price-high':
                return b.price - a.price;
            case 'rating':
                // If there's no rating field in the API response, we can use another field as a fallback
                return 0;
            default:
                return 0;
        }
    });

    return (<div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <section className="bg-brand-navy text-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h1 className="text-4xl md:text-5xl font-heading font-bold mb-6">
              Explore Our Courses
            </h1>
            <p className="text-xl text-gray-200 max-w-2xl mx-auto">
              Discover expert-led courses designed to accelerate your career in the digital economy
            </p>
          </div>
        </div>
      </section>

      {/* Filters and Search */}
      <section className="py-8 bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col lg:flex-row gap-4 items-center justify-between">
            {/* Search */}
            <div className="w-full lg:w-96">
              <div className="relative">
                <input type="text" placeholder="Search courses..." value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} className="input-field pl-10"/>
                <svg className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
              </div>
            </div>

            {/* Filters */}
            <div className="flex flex-wrap gap-4">
              {/* Level Filter */}
              <select value={selectedLevel} onChange={(e) => setSelectedLevel(e.target.value)} className="input-field w-auto">
                {levels.map(level => (<option key={level} value={level}>
                    {level === 'all' ? 'All Levels' : level.charAt(0).toUpperCase() + level.slice(1)}
                  </option>))}
              </select>

              {/* Sort */}
              <select value={sortBy} onChange={(e) => setSortBy(e.target.value)} className="input-field w-auto">
                {sortOptions.map(option => (<option key={option.value} value={option.value}>
                    {option.label}
                  </option>))}
              </select>
            </div>
          </div>
        </div>
      </section>

      {/* Courses Grid */}
      <section className="py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Results Count */}
          <div className="mb-8">
            <p className="text-gray-600">
              Showing {filteredCourses.length} of {courses.length} courses
            </p>
          </div>

          {/* Loading State */}
          {isLoading && (<div className="text-center py-12">
              <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-brand-cyan mx-auto"></div>
              <p className="mt-4 text-gray-600">Loading courses...</p>
            </div>)}

          {/* Error State with fallback to mock data */}
          {error && !isLoading && (<div className="text-center py-8 bg-yellow-50 rounded-lg p-6 mb-8">
              <div className="text-2xl mb-4">⚠️</div>
              <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                {error}
              </h3>
              <p className="text-gray-600 mb-6">Displaying sample courses while we resolve the issue.</p>
            </div>)}

          {/* Courses Grid */}
          {!isLoading && filteredCourses.length > 0 ? (<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {filteredCourses.map((course) => {
                return (<div key={course.id} className="stats-card bg-white rounded-lg shadow-md p-6 flex flex-col hover:shadow-xl transition-shadow border border-gray-100">
                  <div className="relative mb-4">
                    <img src={course.thumbnail_url || 'https://placehold.co/400x200'} alt={course.title} className="w-full h-48 object-cover rounded-lg"/>
                    <div className="absolute top-3 right-3 bg-brand-cyan text-white px-2 py-1 rounded text-sm font-medium">
                      {course.level}
                    </div>
                  </div>
                  
                  <div className="mb-4">
                    <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                      {course.title}
                    </h3>
                    <p className="text-gray-600 text-sm mb-3 line-clamp-2">
                      {course.description}
                    </p>
                    
                    <div className="flex items-center justify-between text-sm text-gray-500 mb-4">
                      <span>Price: ${course.price}</span>
                      <span>Duration: {course.duration}</span>
                    </div>
                  </div>
                  
                  <div className="flex items-center justify-between">
                    <Link to={`/course/${course.id}/overview`} className="btn-primary">
                      View Course
                    </Link>
                  </div>
                </div>);
            })}
            </div>) : (<div className="text-center py-12">
              <div className="text-6xl mb-4">🤖</div>
              <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                Courses Coming Soon
              </h3>
              <p className="text-gray-600 mb-6 max-w-2xl mx-auto">
                Our AI is currently generating personalized courses for you. Check back soon for exciting new content!
                <br /><br />
                Admins can also upload courses manually through the admin panel.
              </p>
              <button onClick={() => {
                setSearchTerm('');
                setSelectedLevel('all');
            }} className="btn-secondary">
                Clear Filters
              </button>
            </div>)}
        </div>
      </section>


    </div>);
};

export default Courses;