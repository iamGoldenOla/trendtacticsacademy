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

    // Fetch courses from API
    useEffect(() => {
        const fetchCourses = async () => {
            try {
                setIsLoading(true);
                setError(null);
                const data = await courseService.getAllCourses();
                setCourses(data);
            } catch (err) {
                console.error('Error fetching courses:', err);
                setError('Failed to load courses. Please try again later.');
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

          {/* Error State */}
          {error && !isLoading && (<div className="text-center py-12">
              <div className="text-6xl mb-4">⚠️</div>
              <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                Error Loading Courses
              </h3>
              <p className="text-gray-600 mb-6">{error}</p>
              <button onClick={() => window.location.reload()} className="btn-secondary">
                Try Again
              </button>
            </div>)}

          {/* Courses Grid */}
          {!isLoading && !error && filteredCourses.length > 0 ? (<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
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
                    <Link to={`/course/${course.id}`} className="btn-primary">
                      View Course
                    </Link>
                  </div>
                </div>);
            })}
            </div>) : (<div className="text-center py-12">
              <div className="text-6xl mb-4">🔍</div>
              <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                No courses found
              </h3>
              <p className="text-gray-600 mb-6">
                Try adjusting your search terms or filters
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