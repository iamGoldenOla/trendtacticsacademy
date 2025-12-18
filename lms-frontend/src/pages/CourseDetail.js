import React from 'react';
import { useParams } from 'react-router-dom';
import CourseLearningBoard from '../components/CourseLearningBoard';
import './CourseDetail.css';

const CourseDetail = () => {
  const { courseId } = useParams();

  // In a real implementation, you would fetch course data here
  // For now, we're just rendering the learning board which will handle data fetching

  return (
    <div className="course-detail-page">
      <CourseLearningBoard />
    </div>
  );
};

export default CourseDetail;