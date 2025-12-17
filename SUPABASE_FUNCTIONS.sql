-- Supabase Functions for Trendtactics Academy

-- 1. Function to get user cart
CREATE OR REPLACE FUNCTION get_user_cart(user_id UUID)
RETURNS TABLE(
  course_id UUID,
  title TEXT,
  description TEXT,
  price DECIMAL(10,2),
  thumbnail TEXT,
  added_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.id as course_id,
    c.title,
    c.description,
    c.price,
    c.thumbnail,
    cart.created_at as added_at
  FROM carts cart
  JOIN courses c ON cart.course_id = c.id
  WHERE cart.user_id = $1
  ORDER BY cart.created_at DESC;
END;
$$ LANGUAGE plpgsql;

-- 2. Function to add item to cart
CREATE OR REPLACE FUNCTION add_to_cart(user_id UUID, course_id UUID)
RETURNS TABLE(success BOOLEAN, message TEXT) AS $$
DECLARE
  course_exists BOOLEAN;
  already_in_cart BOOLEAN;
BEGIN
  -- Check if course exists
  SELECT EXISTS(SELECT 1 FROM courses WHERE id = course_id) INTO course_exists;
  
  IF NOT course_exists THEN
    RETURN QUERY SELECT FALSE, 'Course not found';
    RETURN;
  END IF;
  
  -- Check if already in cart
  SELECT EXISTS(SELECT 1 FROM carts WHERE carts.user_id = $1 AND carts.course_id = $2) INTO already_in_cart;
  
  IF already_in_cart THEN
    RETURN QUERY SELECT FALSE, 'Course already in cart';
    RETURN;
  END IF;
  
  -- Add to cart
  INSERT INTO carts (user_id, course_id) VALUES ($1, $2);
  
  RETURN QUERY SELECT TRUE, 'Course added to cart successfully';
END;
$$ LANGUAGE plpgsql;

-- 3. Function to remove item from cart
CREATE OR REPLACE FUNCTION remove_from_cart(user_id UUID, course_id UUID)
RETURNS TABLE(success BOOLEAN, message TEXT) AS $$
BEGIN
  DELETE FROM carts 
  WHERE carts.user_id = $1 AND carts.course_id = $2;
  
  IF FOUND THEN
    RETURN QUERY SELECT TRUE, 'Course removed from cart successfully';
  ELSE
    RETURN QUERY SELECT FALSE, 'Course not found in cart';
  END IF;
END;
$$ LANGUAGE plpgsql;

-- 4. Function to get cart total
CREATE OR REPLACE FUNCTION get_cart_total(user_id UUID)
RETURNS DECIMAL(10,2) AS $$
DECLARE
  total DECIMAL(10,2);
BEGIN
  SELECT COALESCE(SUM(c.price), 0) INTO total
  FROM carts cart
  JOIN courses c ON cart.course_id = c.id
  WHERE cart.user_id = $1;
  
  RETURN COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;

-- 5. Function to create order from cart
CREATE OR REPLACE FUNCTION create_order_from_cart(user_id UUID)
RETURNS TABLE(order_id UUID, success BOOLEAN, message TEXT, total_amount DECIMAL(10,2)) AS $$
DECLARE
  new_order_id UUID;
  cart_total DECIMAL(10,2);
BEGIN
  -- Get cart total
  SELECT get_cart_total($1) INTO cart_total;
  
  IF cart_total = 0 THEN
    RETURN QUERY SELECT NULL::UUID, FALSE, 'Cart is empty', 0::DECIMAL(10,2);
    RETURN;
  END IF;
  
  -- Create order
  INSERT INTO orders (user_id, total_amount, status)
  VALUES ($1, cart_total, 'pending')
  RETURNING id INTO new_order_id;
  
  -- Create order items from cart
  INSERT INTO order_items (order_id, course_id, price)
  SELECT new_order_id, course_id, c.price
  FROM carts cart
  JOIN courses c ON cart.course_id = c.id
  WHERE cart.user_id = $1;
  
  -- Clear cart
  DELETE FROM carts WHERE user_id = $1;
  
  -- Enroll user in courses
  INSERT INTO enrollments (user_id, course_id, progress, completed_lessons)
  SELECT $1, course_id, 0, '{}'
  FROM carts
  WHERE user_id = $1
  ON CONFLICT (user_id, course_id) DO NOTHING;
  
  RETURN QUERY SELECT new_order_id, TRUE, 'Order created successfully', cart_total;
END;
$$ LANGUAGE plpgsql;

-- 6. Function to update user analytics
CREATE OR REPLACE FUNCTION update_user_analytics(
  user_id UUID, 
  course_id UUID, 
  progress_percent INTEGER,
  time_spent INTEGER
)
RETURNS TABLE(success BOOLEAN, message TEXT) AS $$
BEGIN
  INSERT INTO user_analytics (
    user_id, 
    course_id, 
    progress_percentage, 
    time_spent_minutes,
    last_accessed
  )
  VALUES ($1, $2, $3, $4, NOW())
  ON CONFLICT (user_id, course_id)
  DO UPDATE SET 
    progress_percentage = EXCLUDED.progress_percentage,
    time_spent_minutes = EXCLUDED.time_spent_minutes,
    last_accessed = NOW(),
    updated_at = NOW();
  
  RETURN QUERY SELECT TRUE, 'Analytics updated successfully';
END;
$$ LANGUAGE plpgsql;

-- 7. Function to get user analytics summary
CREATE OR REPLACE FUNCTION get_user_analytics_summary(user_id UUID)
RETURNS TABLE(
  total_enrollments BIGINT,
  completed_courses BIGINT,
  in_progress_courses BIGINT,
  avg_progress DECIMAL(5,2),
  total_time_spent INTEGER
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*) as total_enrollments,
    COUNT(CASE WHEN ua.completed THEN 1 END) as completed_courses,
    COUNT(CASE WHEN ua.progress_percentage > 0 AND NOT ua.completed THEN 1 END) as in_progress_courses,
    COALESCE(ROUND(AVG(ua.progress_percentage), 2), 0) as avg_progress,
    COALESCE(SUM(ua.time_spent_minutes), 0) as total_time_spent
  FROM user_analytics ua
  WHERE ua.user_id = $1;
END;
$$ LANGUAGE plpgsql;

-- 8. Function to get admin dashboard stats
CREATE OR REPLACE FUNCTION get_admin_stats()
RETURNS TABLE(
  total_users BIGINT,
  total_courses BIGINT,
  total_enrollments BIGINT,
  total_revenue DECIMAL(12,2)
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    (SELECT COUNT(*) FROM auth.users) as total_users,
    (SELECT COUNT(*) FROM courses) as total_courses,
    (SELECT COUNT(*) FROM enrollments) as total_enrollments,
    (SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'completed') as total_revenue;
END;
$$ LANGUAGE plpgsql;

-- 9. Function to get admin course analytics
CREATE OR REPLACE FUNCTION get_course_analytics()
RETURNS TABLE(
  course_id UUID,
  title TEXT,
  enrollments_count BIGINT,
  avg_completion_rate DECIMAL(5,2)
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.id as course_id,
    c.title,
    COUNT(e.id) as enrollments_count,
    COALESCE(ROUND(AVG(ua.progress_percentage), 2), 0) as avg_completion_rate
  FROM courses c
  LEFT JOIN enrollments e ON c.id = e.course_id
  LEFT JOIN user_analytics ua ON c.id = ua.course_id
  GROUP BY c.id, c.title
  ORDER BY enrollments_count DESC;
END;
$$ LANGUAGE plpgsql;

-- 10. Function to get setting value
CREATE OR REPLACE FUNCTION get_setting(setting_key TEXT)
RETURNS TEXT AS $$
DECLARE
  setting_value TEXT;
BEGIN
  SELECT s.setting_value INTO setting_value
  FROM admin_settings s
  WHERE s.setting_key = $1;
  
  RETURN COALESCE(setting_value, '');
END;
$$ LANGUAGE plpgsql;