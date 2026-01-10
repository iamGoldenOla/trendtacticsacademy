# DATABASE DOCUMENTATION

**Version:** 1.0.0  
**Created:** January 10, 2026  
**Status:** Master Schema Established

---

## OVERVIEW

This document describes the database schema for Trendtactics Digital Academy. The schema is designed to support:

- 3 courses with specific lesson counts (Vibe Coding: 26, Facebook Ads: 26, Prompt Engineering: 16)
- AI-generated content with uniqueness tracking
- Student progress tracking
- Course enrollment and access control
- Interactive learning features (whiteboard, code playground, quizzes)

---

## SCHEMA FILES

### Master Schema
- **Location:** `./database/schema/master-schema.sql`
- **Purpose:** Single source of truth for all database tables
- **Status:** ✅ Complete and ready for deployment

### Archived Schemas
- **Location:** `./archive/old-sql/`
- **Count:** 68 files
- **Status:** Archived for reference only

---

## DATABASE TABLES

### 1. courses
**Purpose:** Store course information

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| title | TEXT | Course title |
| description | TEXT | Course description |
| instructor_id | UUID | Reference to auth.users |
| category | TEXT | Course category |
| level | TEXT | Beginner/Intermediate/Advanced |
| duration | TEXT | e.g., "8 weeks", "26 lessons" |
| objectives | JSONB | Array of learning objectives |
| prerequisites | JSONB | Array of prerequisites |
| status | TEXT | draft/published/archived |
| price | DECIMAL | Course price |
| thumbnail_url | TEXT | Course image URL |
| featured | BOOLEAN | Featured on homepage |
| total_lessons | INTEGER | Denormalized lesson count |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |
| published_at | TIMESTAMPTZ | Publication timestamp |

**Indexes:**
- idx_courses_status
- idx_courses_category
- idx_courses_instructor
- idx_courses_featured
- idx_courses_created_at

---

### 2. modules
**Purpose:** Organize lessons into logical groups

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| course_id | UUID | Reference to courses |
| title | TEXT | Module title |
| description | TEXT | Module description |
| ordering | INTEGER | Order within course |
| duration | TEXT | Module duration |
| objectives | JSONB | Module objectives |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |

**Constraints:**
- UNIQUE(course_id, ordering) - No duplicate ordering

**Indexes:**
- idx_modules_course
- idx_modules_ordering

---

### 3. lessons
**Purpose:** Store individual lesson content

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| module_id | UUID | Reference to modules |
| title | TEXT | Lesson title |
| description | TEXT | Lesson description |
| content | TEXT | Main content (Markdown/HTML) |
| ordering | INTEGER | Order within module |
| duration | TEXT | Lesson duration |
| video_url | TEXT | YouTube/video URL |
| video_transcript | TEXT | Video transcript |
| resources | JSONB | Additional resources |
| ai_generated | BOOLEAN | AI-generated flag |
| ai_prompt_used | TEXT | Prompt hierarchy used |
| ai_model | TEXT | AI model used |
| ai_generation_date | TIMESTAMPTZ | Generation timestamp |
| content_hash | TEXT | SHA-256 hash for uniqueness |
| has_whiteboard | BOOLEAN | Whiteboard feature flag |
| has_code_playground | BOOLEAN | Code playground flag |
| has_quiz | BOOLEAN | Quiz feature flag |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |

**Constraints:**
- UNIQUE(module_id, ordering) - No duplicate ordering

**Indexes:**
- idx_lessons_module
- idx_lessons_ordering
- idx_lessons_content_hash
- idx_lessons_ai_generated

---

### 4. assessments
**Purpose:** Store quizzes, assignments, and exams

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| module_id | UUID | Reference to modules (optional) |
| lesson_id | UUID | Reference to lessons (optional) |
| title | TEXT | Assessment title |
| description | TEXT | Assessment description |
| type | TEXT | quiz/assignment/exam/project |
| questions | JSONB | Array of questions |
| passing_score | INTEGER | Minimum score to pass |
| attempts_allowed | INTEGER | Max attempts |
| time_limit | INTEGER | Time limit in minutes |
| ordering | INTEGER | Order within parent |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |

**Constraints:**
- CHECK (module_id IS NOT NULL OR lesson_id IS NOT NULL)

**Indexes:**
- idx_assessments_module
- idx_assessments_lesson

---

### 5. student_course_access
**Purpose:** Track course enrollments and access

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | Reference to auth.users |
| course_id | UUID | Reference to courses |
| purchase_date | TIMESTAMPTZ | Enrollment date |
| access_status | TEXT | active/expired/cancelled/trial |
| enrollment_type | TEXT | paid/free/trial/scholarship |
| expires_at | TIMESTAMPTZ | Expiration date (optional) |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |

**Constraints:**
- UNIQUE(user_id, course_id) - One enrollment per user per course

**Indexes:**
- idx_student_course_access_user
- idx_student_course_access_course
- idx_student_course_access_status

---

### 6. user_progress
**Purpose:** Track student progress through lessons

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | Reference to auth.users |
| lesson_id | UUID | Reference to lessons |
| completed | BOOLEAN | Completion status |
| score | DECIMAL | Assessment score |
| time_spent | INTEGER | Time in seconds |
| last_accessed_at | TIMESTAMPTZ | Last access time |
| completed_at | TIMESTAMPTZ | Completion time |
| notes | TEXT | Student notes |
| created_at | TIMESTAMPTZ | Creation timestamp |
| updated_at | TIMESTAMPTZ | Last update timestamp |

**Constraints:**
- UNIQUE(user_id, lesson_id) - One progress record per user per lesson

**Indexes:**
- idx_user_progress_user
- idx_user_progress_lesson
- idx_user_progress_completed

---

### 7. ai_content_generations
**Purpose:** Track AI-generated content for uniqueness

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| content_type | TEXT | lesson/module/assessment/resource |
| content_id | UUID | Reference to generated content |
| prompt_hierarchy | JSONB | Full prompt hierarchy |
| content_hash | TEXT | SHA-256 hash |
| model_used | TEXT | AI model name |
| tokens_used | INTEGER | Token count |
| generation_time_ms | INTEGER | Generation time |
| is_unique | BOOLEAN | Uniqueness flag |
| duplicate_of | UUID | Reference to duplicate |
| created_at | TIMESTAMPTZ | Creation timestamp |

**Constraints:**
- UNIQUE(content_hash) - Ensure content uniqueness

**Indexes:**
- idx_ai_generations_content
- idx_ai_generations_hash

---

## FUNCTIONS

### get_student_courses(p_user_id UUID)
Returns all courses a student is enrolled in with progress information.

**Returns:**
- course_id, course_title, course_description
- course_level, course_category, course_image_url
- total_lessons, completed_lessons, progress_percentage
- enrollment_date, access_status

### get_course_structure(p_course_id UUID, p_user_id UUID)
Returns complete course structure with user progress.

**Returns:** JSONB with nested course → modules → lessons structure

### generate_content_hash(content TEXT)
Generates SHA-256 hash of content for uniqueness checking.

### check_content_uniqueness(p_content_hash TEXT)
Checks if content hash already exists in database.

---

## ROW LEVEL SECURITY (RLS)

All tables have RLS enabled with appropriate policies:

- **courses:** Public can view published, authenticated can view all
- **modules/lessons:** Accessible if course is accessible
- **student_course_access:** Users can only see their own enrollments
- **user_progress:** Users can only see/modify their own progress
- **ai_content_generations:** Read-only for authenticated users

---

## NEXT STEPS

1. ✅ Master schema created
2. ⏳ Deploy to Supabase production
3. ⏳ Populate with course data
4. ⏳ Test all functions and policies
5. ⏳ Create migration scripts for updates


