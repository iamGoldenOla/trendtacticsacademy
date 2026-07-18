-- Dynamic PL/pgSQL block to update the course thumbnail regardless of the column name (thumbnail, thumbnail_url, or image_url)
DO $$
BEGIN
  -- 1. Check if 'thumbnail' column exists
  IF EXISTS (
    SELECT 1 
    FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='thumbnail'
  ) THEN
    UPDATE courses 
    SET thumbnail = '/images/course-promptmastery.png' 
    WHERE title ILIKE '%Prompt Engineering Mastery%' 
       OR id = 'c3d4e5f6-a7b8-9012-cdef-012345678913';
  END IF;

  -- 2. Check if 'thumbnail_url' column exists
  IF EXISTS (
    SELECT 1 
    FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='thumbnail_url'
  ) THEN
    UPDATE courses 
    SET thumbnail_url = '/images/course-promptmastery.png' 
    WHERE title ILIKE '%Prompt Engineering Mastery%' 
       OR id = 'c3d4e5f6-a7b8-9012-cdef-012345678913';
  END IF;

  -- 3. Check if 'image_url' column exists
  IF EXISTS (
    SELECT 1 
    FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='image_url'
  ) THEN
    UPDATE courses 
    SET image_url = '/images/course-promptmastery.png' 
    WHERE title ILIKE '%Prompt Engineering Mastery%' 
       OR id = 'c3d4e5f6-a7b8-9012-cdef-012345678913';
  END IF;
END $$;
