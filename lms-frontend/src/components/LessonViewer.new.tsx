import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import {
  ChevronLeft,
  ChevronRight,
  CheckCircle,
  Clock,
  FileText,
  Video,
  Code,
  Download,
  BookOpen
} from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { vscDarkPlus } from 'react-syntax-highlighter/dist/esm/styles/prism';
import { courseService } from '../api/services/course.service';
import { Lesson, Module } from '../types/api.types';

interface LessonViewerProps {
  user?: any;
}

const LessonViewer: React.FC<LessonViewerProps> = ({ user }) => {
  const { courseId, lessonId } = useParams<{ courseId: string; lessonId: string }>();
  const navigate = useNavigate();
  
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [modules, setModules] = useState<Module[]>([]);
  const [allLessons, setAllLessons] = useState<{ [moduleId: string]: Lesson[] }>({});
  const [loading, setLoading] = useState(true);
  const [isCompleted, setIsCompleted] = useState(false);
  const [videoProgress, setVideoProgress] = useState(0);

  useEffect(() => {
    if (courseId && lessonId) {
      fetchLessonData();
    }
  }, [courseId, lessonId]);

  const fetchLessonData = async () => {
    if (!courseId || !lessonId) return;
    
    try {
      setLoading(true);
      
      // Fetch current lesson
      const lessonData = await courseService.getLessonById(lessonId);
      setLesson(lessonData);
      
      // Fetch all modules and lessons for navigation
      const modulesData = await courseService.getCourseModules(courseId);
      setModules(modulesData);
      
      // Fetch lessons for each module
      const lessonsData: { [moduleId: string]: Lesson[] } = {};
      for (const module of modulesData) {
        const moduleLessons = await courseService.getModuleLessons(module.id);
        lessonsData[module.id] = moduleLessons;
      }
      setAllLessons(lessonsData);
      
    } catch (error) {
      console.error('Error fetching lesson data:', error);
    } finally {
      setLoading(false);
    }
  };

  const findAdjacentLessons = () => {
    const allLessonsList: Lesson[] = [];
    modules.forEach(module => {
      if (allLessons[module.id]) {
        allLessonsList.push(...allLessons[module.id]);
      }
    });
    
    const currentIndex = allLessonsList.findIndex(l => l.id === lessonId);
    
    return {
      previous: currentIndex > 0 ? allLessonsList[currentIndex - 1] : null,
      next: currentIndex < allLessonsList.length - 1 ? allLessonsList[currentIndex + 1] : null,
    };
  };

  const handleMarkComplete = () => {
    setIsCompleted(true);
    // TODO: Call API to mark lesson as complete
  };

  const handleNavigate = (targetLessonId: string) => {
    navigate(`/courses/${courseId}/lessons/${targetLessonId}`);
  };

  const renderContent = () => {
    if (!lesson) return null;

    switch (lesson.content_type) {
      case 'video':
        return (
          <div className="aspect-video bg-black rounded-lg overflow-hidden">
            {lesson.video_url ? (
              <video
                src={lesson.video_url}
                controls
                className="w-full h-full"
                onTimeUpdate={(e) => {
                  const video = e.target as HTMLVideoElement;
                  const progress = (video.currentTime / video.duration) * 100;
                  setVideoProgress(progress);
                }}
              >
                Your browser does not support the video tag.
              </video>
            ) : (
              <div className="w-full h-full flex items-center justify-center text-white">
                <div className="text-center">
                  <Video className="w-16 h-16 mx-auto mb-4 opacity-50" />
                  <p>Video not available</p>
                </div>
              </div>
            )}
          </div>
        );
      
      case 'text':
        return (
          <div className="prose prose-lg max-w-none">
            <ReactMarkdown
              remarkPlugins={[remarkGfm]}
              components={{
                code({ node, inline, className, children, ...props }) {
                  const match = /language-(\w+)/.exec(className || '');
                  return !inline && match ? (
                    <SyntaxHighlighter
                      style={vscDarkPlus}
                      language={match[1]}
                      PreTag="div"
                      {...props}
                    >
                      {String(children).replace(/\n$/, '')}
                    </SyntaxHighlighter>
                  ) : (
                    <code className={className} {...props}>
                      {children}
                    </code>
                  );
                },
              }}
            >
              {lesson.content || ''}
            </ReactMarkdown>
          </div>
        );
      
      default:
        return (
          <div className="text-center py-12">
            <FileText className="w-16 h-16 mx-auto mb-4 text-gray-400" />
            <p className="text-gray-600">Content type not supported yet</p>
          </div>
        );
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-primary-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading lesson...</p>
        </div>
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">Lesson Not Found</h2>
          <button
            onClick={() => navigate(`/courses/${courseId}`)}
            className="text-primary-cyan hover:text-primary-cyanLight font-semibold"
          >
            Back to Course
          </button>
        </div>
      </div>
    );
  }

  const { previous, next } = findAdjacentLessons();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={() => navigate(`/courses/${courseId}`)}
              className="flex items-center text-gray-600 hover:text-gray-900"
            >
              <ChevronLeft className="w-5 h-5 mr-1" />
              Back to Course
            </button>

            <div className="flex items-center space-x-4">
              {lesson.duration && (
                <div className="flex items-center text-gray-600">
                  <Clock className="w-4 h-4 mr-2" />
                  <span className="text-sm">{lesson.duration}</span>
                </div>
              )}

              <button
                onClick={handleMarkComplete}
                disabled={isCompleted}
                className={`flex items-center px-4 py-2 rounded-lg font-semibold transition-colors ${
                  isCompleted
                    ? 'bg-green-100 text-green-700 cursor-not-allowed'
                    : 'bg-primary-cyan text-white hover:bg-primary-cyanLight'
                }`}
              >
                <CheckCircle className="w-5 h-5 mr-2" />
                {isCompleted ? 'Completed' : 'Mark Complete'}
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          {/* Lesson Title */}
          <div className="mb-6">
            <h1 className="text-3xl font-bold text-gray-900 mb-2">{lesson.title}</h1>
            {lesson.description && (
              <p className="text-gray-600">{lesson.description}</p>
            )}
          </div>

          {/* Lesson Content */}
          <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
            {renderContent()}
          </div>

          {/* Resources */}
          {lesson.resources && lesson.resources.length > 0 && (
            <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
              <h2 className="text-xl font-bold text-gray-900 mb-4 flex items-center">
                <Download className="w-5 h-5 mr-2" />
                Resources
              </h2>
              <div className="space-y-3">
                {lesson.resources.map((resource, index) => (
                  <a
                    key={index}
                    href={resource.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex items-center justify-between p-4 border border-gray-200 rounded-lg hover:border-primary-cyan hover:bg-primary-cyan/5 transition-colors"
                  >
                    <div className="flex items-center">
                      <FileText className="w-5 h-5 text-gray-400 mr-3" />
                      <div>
                        <p className="font-semibold text-gray-900">{resource.title}</p>
                        <p className="text-sm text-gray-500">{resource.type.toUpperCase()}</p>
                      </div>
                    </div>
                    <Download className="w-5 h-5 text-gray-400" />
                  </a>
                ))}
              </div>
            </div>
          )}

          {/* Navigation */}
          <div className="flex items-center justify-between">
            {previous ? (
              <button
                onClick={() => handleNavigate(previous.id)}
                className="flex items-center px-6 py-3 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
              >
                <ChevronLeft className="w-5 h-5 mr-2" />
                <div className="text-left">
                  <p className="text-xs text-gray-500">Previous</p>
                  <p className="font-semibold text-gray-900">{previous.title}</p>
                </div>
              </button>
            ) : (
              <div></div>
            )}

            {next ? (
              <button
                onClick={() => handleNavigate(next.id)}
                className="flex items-center px-6 py-3 bg-primary-cyan text-white rounded-lg hover:bg-primary-cyanLight transition-colors"
              >
                <div className="text-right">
                  <p className="text-xs text-cyan-100">Next</p>
                  <p className="font-semibold">{next.title}</p>
                </div>
                <ChevronRight className="w-5 h-5 ml-2" />
              </button>
            ) : (
              <div></div>
            )}
          </div>
        </motion.div>
      </div>
    </div>
  );
};

export default LessonViewer;

