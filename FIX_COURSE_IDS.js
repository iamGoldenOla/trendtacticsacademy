/**
 * Fix Course IDs Script
 * This script demonstrates how to properly fetch and display real courses from Supabase
 * instead of using mock data with invalid IDs
 */

// Original problematic code in Home.js (lines 7-8):
// const featuredCourses = digitalMarketingCourses.slice(0, 3); // Show first 3 as featured
// const coursesToShow = realCourses.length > 0 ? realCourses : featuredCourses;

// Fixed approach - Always prioritize real courses from Supabase
// Only show mock data if there's an error or no real courses

const FIXED_HOME_LOGIC = `
// In Home.js, replace the existing logic with this:

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
                    
                    setRealCourses(validCourses.slice(0, 3)); // Get first 3 real courses
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
    
    // Rest of the component remains the same...
`;

// Also fix the CourseDetail component to handle invalid IDs properly
const FIXED_COURSE_DETAIL_LOGIC = `
// In CourseDetail.js, improve the error handling:

const CourseDetail = () => {
  const { courseId } = useParams();
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCourse = async () => {
      try {
        setLoading(true);
        
        // Validate course ID format before making request
        if (!courseId) {
          setError('No course ID provided');
          return;
        }
        
        // Check if courseId looks like a valid UUID
        const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
        if (!uuidRegex.test(courseId)) {
          setError(\`Invalid course ID format: \${courseId}\`);
          console.warn('Invalid course ID detected:', courseId);
          return;
        }
        
        const courseData = await getCourseById(courseId);
        setCourse(courseData);
      } catch (err) {
        console.error('Error fetching course:', err);
        setError(err.message || 'Failed to load course. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    if (courseId) {
      fetchCourse();
    }
  }, [courseId]);
  
  // Rest of component...
`;

console.log('🔧 Course ID Fix Script Generated');
console.log('📋 To fix the course ID issues:');

console.log('\n1. Update Home.js with the improved logic:');
console.log(FIXED_HOME_LOGIC);

console.log('\n2. Update CourseDetail.js with better error handling:');
console.log(FIXED_COURSE_DETAIL_LOGIC);

console.log('\n3. Remove dependency on mock data entirely');
console.log('   - Delete or comment out: import { digitalMarketingCourses } from "../data/digitalMarketingCourses";');
console.log('   - Remove the fallback to mock data');

console.log('\n4. Test with real course IDs from your Supabase database');
console.log('   - You can find real course IDs by running:');
console.log('     SELECT id, title FROM courses WHERE is_published = true LIMIT 5;');