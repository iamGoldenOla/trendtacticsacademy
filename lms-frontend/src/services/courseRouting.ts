/**
 * Course Route Mapping & Enrollment Fix
 * 
 * This file fixes:
 * 1. Inconsistent course URLs (vibe-coding vs course-detail)
 * 2. Enrollment API failures
 * 3. Course ID lookup issues
 */

import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { courseService } from '../services';

/**
 * Course ID Mapping - Maps URL-friendly names to actual course IDs
 * This ensures consistent routing across the application
 */
const COURSE_URL_MAPPING: Record<string, string> = {
  'vibe-coding': 'vibe-coding',  // Use actual UUID from Supabase
  'prompt-engineering': 'prompt-engineering',
  'facebook-ads': 'facebook-ads',
  'course-detail': 'vibe-coding'  // Legacy redirect
};

/**
 * Hook to resolve course URL to actual course ID
 */
export const useCourseId = (courseParam: string | undefined): string | null => {
  const [resolvedId, setResolvedId] = useState<string | null>(null);

  useEffect(() => {
    if (!courseParam) return;

    // Check if it's a URL-friendly name that needs mapping
    if (COURSE_URL_MAPPING[courseParam]) {
      setResolvedId(COURSE_URL_MAPPING[courseParam]);
      return;
    }

    // Otherwise assume it's already a course ID
    setResolvedId(courseParam);
  }, [courseParam]);

  return resolvedId;
};

/**
 * Enhanced enrollment function with better error handling
 */
export const enrollInCourseWithFix = async (courseId: string) => {
  try {
    console.log('Attempting to enroll in course:', courseId);
    
    if (!courseId || courseId.trim() === '') {
      throw new Error('Invalid course ID');
    }

    // First verify the course exists
    const course = await courseService.getCourseById(courseId);
    if (!course) {
      throw new Error(`Course not found: ${courseId}`);
    }

    // Attempt enrollment
    const result = await courseService.enrollInCourse(courseId);
    
    if (!result) {
      throw new Error('Enrollment API returned false');
    }

    return { success: true, message: 'Successfully enrolled in course' };
  } catch (error: any) {
    console.error('Enrollment error details:', {
      courseId,
      message: error.message,
      fullError: error
    });

    // Provide helpful error messages
    if (error.message.includes('not found')) {
      return {
        success: false,
        message: 'Course not found. Please go back and select a valid course.'
      };
    }
    
    if (error.message.includes('Already enrolled')) {
      return {
        success: false,
        message: 'You are already enrolled in this course.'
      };
    }

    if (error.message.includes('Failed to fetch')) {
      return {
        success: false,
        message: 'Connection error. Please check your internet and try again.'
      };
    }

    return {
      success: false,
      message: error.message || 'Error enrolling in course. Please try again.'
    };
  }
};

export default { COURSE_URL_MAPPING, enrollInCourseWithFix, useCourseId };
