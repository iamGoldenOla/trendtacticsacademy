-- Function to get courses a student has access to
CREATE OR REPLACE FUNCTION get_student_courses(p_user_id UUID)
RETURNS TABLE(
    course_id UUID,
    course_title TEXT,
    course_description TEXT,
    course_level TEXT,
    course_category TEXT,
    course_image_url TEXT,
    enrollment_date TIMESTAMP WITH TIME ZONE,
    access_status TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id as course_id,
        c.title as course_title,
        c.description as course_description,
        c.level as course_level,
        c.category as course_category,
        c.image_url as course_image_url,
        sca.purchase_date as enrollment_date,
        sca.access_status
    FROM courses c
    INNER JOIN student_course_access sca ON c.id = sca.course_id
    WHERE sca.user_id = p_user_id
      AND sca.access_status = 'active'
    ORDER BY c.created_at;
END;
$$;

-- Grant permissions to the function
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;