import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Search, Filter, BookOpen, Star, Clock, Users, TrendingUp } from 'lucide-react';
import * as supabaseCourseService from '../services/supabaseCourseService';
import { Course } from '../services/supabaseCourseService';

const Courses: React.FC = () => {
  const [courses, setCourses] = useState<Course[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedLevel, setSelectedLevel] = useState('all');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const levels = [
    { value: 'all', label: 'All Levels' },
    { value: 'beginner', label: 'Beginner' },
    { value: 'intermediate', label: 'Intermediate' },
    { value: 'advanced', label: 'Advanced' }
  ];

  const categories = [
    { value: 'all', label: 'All Categories' },
    { value: 'AI', label: 'Artificial Intelligence' },
    { value: 'Marketing', label: 'Digital Marketing' },
    { value: 'Technology', label: 'Technology' },
    { value: 'Business', label: 'Business' }
  ];

  useEffect(() => {
    const fetchCourses = async () => {
      try {
        setIsLoading(true);
        setError(null);
        const data = await supabaseCourseService.getAllCourses();
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

  const filteredCourses = courses.filter(course => {
    const matchesSearch = 
      course.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
      course.description.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesLevel = selectedLevel === 'all' || course.level === selectedLevel;
    const matchesCategory = selectedCategory === 'all' || course.category === selectedCategory;
    
    return matchesSearch && matchesLevel && matchesCategory;
  });

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header Section */}
      <section className="bg-gradient-to-br from-primary-navy via-primary-navyLight to-primary-navyDark text-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center"
          >
            <h1 className="text-4xl md:text-5xl font-bold mb-4">
              Explore Our Courses
            </h1>
            <p className="text-lg text-gray-300 max-w-2xl mx-auto">
              Discover expert-led courses designed to help you master in-demand skills
            </p>
          </motion.div>
        </div>
      </section>

      {/* Search and Filters */}
      <section className="bg-white shadow-sm sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <div className="flex flex-col md:flex-row gap-4">
            {/* Search Bar */}
            <div className="flex-1 relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" />
              <input
                type="text"
                placeholder="Search courses..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-cyan focus:border-transparent outline-none"
              />
            </div>

            {/* Level Filter */}
            <select
              value={selectedLevel}
              onChange={(e) => setSelectedLevel(e.target.value)}
              className="px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-cyan focus:border-transparent outline-none bg-white"
            >
              {levels.map(level => (
                <option key={level.value} value={level.value}>{level.label}</option>
              ))}
            </select>

            {/* Category Filter */}
            <select
              value={selectedCategory}
              onChange={(e) => setSelectedCategory(e.target.value)}
              className="px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-cyan focus:border-transparent outline-none bg-white"
            >
              {categories.map(category => (
                <option key={category.value} value={category.value}>{category.label}</option>
              ))}
            </select>
          </div>

          {/* Results Count */}
          <div className="mt-4 text-sm text-gray-600">
            Showing {filteredCourses.length} of {courses.length} courses
          </div>
        </div>
      </section>

      {/* Courses Grid */}
      <section className="py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          {isLoading ? (
            <div className="flex justify-center items-center py-20">
              <div className="text-center">
                <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-primary-cyan mx-auto mb-4"></div>
                <p className="text-gray-600">Loading courses...</p>
              </div>
            </div>
          ) : error ? (
            <div className="text-center py-20">
              <p className="text-red-600 mb-4">{error}</p>
              <button
                onClick={() => window.location.reload()}
                className="text-primary-cyan hover:text-primary-cyanLight font-semibold"
              >
                Try Again
              </button>
            </div>
          ) : filteredCourses.length === 0 ? (
            <div className="text-center py-20">
              <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-4" />
              <h3 className="text-xl font-semibold text-gray-900 mb-2">No courses found</h3>
              <p className="text-gray-600">Try adjusting your search or filters</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {filteredCourses.map((course, index) => (
                <motion.div
                  key={course.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.05, duration: 0.5 }}
                  className="group"
                >
                  <Link to={`/courses/${course.id}`} className="block h-full">
                    <div className="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-glow-strong transition-all duration-300 transform hover:-translate-y-2 h-full flex flex-col">
                      {/* Course Image */}
                      <div className="relative h-48 bg-gradient-to-br from-primary-navy to-primary-navyLight overflow-hidden">
                        {course.thumbnail_url ? (
                          <img
                            src={course.thumbnail_url}
                            alt={course.title}
                            className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center">
                            <BookOpen className="w-16 h-16 text-primary-cyan" />
                          </div>
                        )}

                        {/* Level Badge */}
                        <div className="absolute top-4 right-4 bg-primary-cyan text-primary-navy px-3 py-1 rounded-full text-xs font-semibold uppercase">
                          {course.level}
                        </div>

                        {/* Category Badge */}
                        {course.category && (
                          <div className="absolute top-4 left-4 bg-white/90 backdrop-blur-sm text-primary-navy px-3 py-1 rounded-full text-xs font-semibold">
                            {course.category}
                          </div>
                        )}
                      </div>

                      {/* Course Content */}
                      <div className="p-6 flex-1 flex flex-col">
                        <h3 className="text-xl font-bold text-gray-900 mb-2 line-clamp-2 group-hover:text-primary-cyan transition-colors">
                          {course.title}
                        </h3>

                        <p className="text-gray-600 mb-4 line-clamp-2 flex-1">
                          {course.description}
                        </p>

                        {/* Course Meta */}
                        <div className="flex items-center justify-between text-sm text-gray-600 mb-4">
                          <div className="flex items-center gap-1">
                            <Star className="w-4 h-4 text-yellow-400 fill-current" />
                            <span className="font-semibold text-gray-900">4.8</span>
                            <span className="text-gray-500">(1.2k)</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <Users className="w-4 h-4" />
                            <span>12.5k students</span>
                          </div>
                        </div>

                        <div className="flex items-center justify-between pt-4 border-t border-gray-200">
                          <div className="flex items-center gap-1 text-gray-600">
                            <Clock className="w-4 h-4" />
                            <span className="text-sm">{course.duration || '8 weeks'}</span>
                          </div>
                          <div className="text-2xl font-bold text-primary-navy">
                            {course.price ? `$${course.price}` : 'Free'}
                          </div>
                        </div>
                      </div>
                    </div>
                  </Link>
                </motion.div>
              ))}
            </div>
          )}
        </div>
      </section>

      {/* CTA Section */}
      {!isLoading && filteredCourses.length > 0 && (
        <section className="bg-gradient-to-br from-primary-navy to-primary-navyLight text-white py-16">
          <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 className="text-3xl font-bold mb-4">
              Can't find what you're looking for?
            </h2>
            <p className="text-gray-300 mb-6">
              We're constantly adding new courses. Check back soon or contact us with your suggestions.
            </p>
            <Link
              to="/contact"
              className="inline-block bg-primary-cyan hover:bg-primary-cyanLight text-primary-navy px-8 py-3 rounded-lg font-semibold transition-colors duration-300"
            >
              Contact Us
            </Link>
          </div>
        </section>
      )}
    </div>
  );
};

export default Courses;


