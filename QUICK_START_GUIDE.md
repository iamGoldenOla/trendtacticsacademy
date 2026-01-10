# QUICK START GUIDE - BEGIN THE OVERHAUL

**For:** Development Team  
**Purpose:** Get started with Phase 1 immediately  
**Time Required:** Day 1 (4-6 hours)

---

## BEFORE YOU BEGIN

### ✅ Prerequisites
- [ ] Read EXECUTIVE_SUMMARY.md
- [ ] Review COMPREHENSIVE_SYSTEM_AUDIT.md
- [ ] Understand IMPLEMENTATION_ROADMAP.md
- [ ] Get stakeholder approval
- [ ] Set up development environment

### 🛠️ Tools Needed
- Git (version control)
- Node.js (v18+)
- Code editor (VS Code recommended)
- Database client (for Supabase)
- Browser dev tools

---

## PHASE 1 - DAY 1: IMMEDIATE ACTIONS

### Step 1: Backup Everything (30 minutes)

```bash
# Create backup branch
git checkout -b backup-before-overhaul
git add .
git commit -m "Backup: Complete system state before overhaul"
git push origin backup-before-overhaul

# Create local backup
cd ..
cp -r "Trendtactics Academy" "Trendtactics Academy BACKUP $(date +%Y%m%d)"
```

### Step 2: Create Archive Folder (15 minutes)

```bash
# In project root
mkdir -p archive/deployment-history
mkdir -p archive/legacy-tests
mkdir -p archive/old-sql
```

### Step 3: Move Deployment Docs (30 minutes)

Move these files to `archive/deployment-history/`:
- All files starting with `DEPLOYMENT`
- All files starting with `CPANEL`
- All files starting with `FTP`
- All files starting with `GITHUB`
- All files ending with `_DEPLOY.md`
- All files containing `TROUBLESHOOTING`

```bash
# Example commands
mv DEPLOYMENT*.md archive/deployment-history/
mv CPANEL*.md archive/deployment-history/
mv FTP*.md archive/deployment-history/
mv *TROUBLESHOOTING*.md archive/deployment-history/
```

### Step 4: Move Test Scripts (30 minutes)

Move to `archive/legacy-tests/`:
- All `test-*.js` files
- All `check-*.js` files
- All `debug-*.js` files
- All `verify-*.js` files
- All `diagnose-*.js` files

```bash
mv test-*.js archive/legacy-tests/
mv check-*.js archive/legacy-tests/
mv debug-*.js archive/legacy-tests/
mv verify-*.js archive/legacy-tests/
mv diagnose-*.js archive/legacy-tests/
```

### Step 5: Move SQL Files (30 minutes)

Move to `archive/old-sql/`:
- All `.sql` files except the one you'll create as master

```bash
mkdir -p database/migrations
mv *.sql archive/old-sql/
```

### Step 6: Create New Directory Structure (30 minutes)

```bash
# Create new structure
mkdir -p src/pages
mkdir -p src/components
mkdir -p src/styles
mkdir -p src/scripts
mkdir -p src/services
mkdir -p src/data
mkdir -p public/images
mkdir -p public/videos
mkdir -p public/assets
mkdir -p database/schema
mkdir -p database/migrations
mkdir -p database/seeds
mkdir -p docs
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p tests/e2e
```

### Step 7: Identify Source Files (1 hour)

Create `SOURCE_OF_TRUTH.md` and document:

```markdown
# Source of Truth - File Locations

## HTML Pages (Production)
- Homepage: ./index.html
- About: ./about.html
- Services: ./services.html
- Courses: ./courses.html
- Contact: ./contact.html
- Signup: ./signup.html
- Login: ./login.html
- Dashboard: ./new-dashboard.html
- Lesson Viewer: ./learn.html

## CSS Files
- Main Stylesheet: ./css/main.css

## JavaScript Files
- Auth: ./js/auth.js
- Supabase Client: ./js/supabase-client.js
- Trendy AI: ./js/trendy-ai-system.js

## Database
- Current Schema: [To be documented after audit]
```

### Step 8: Commit Progress (15 minutes)

```bash
git checkout -b phase1-cleanup
git add .
git commit -m "Phase 1 Day 1: Archive old files, create new structure"
git push origin phase1-cleanup
```

---

## PHASE 1 - DAY 2: DATABASE AUDIT

### Step 1: Connect to Production Database (30 minutes)

1. Log into Supabase dashboard
2. Go to Database → SQL Editor
3. Run this query to document current state:

```sql
-- Get all tables
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- Get all columns for each table
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

4. Save results to `database/CURRENT_STATE.md`

### Step 2: Export Current Schema (30 minutes)

In Supabase:
1. Go to Database → Schema
2. Copy the SQL for each table
3. Save to `database/schema/current-production-schema.sql`

### Step 3: Create Master Schema (2 hours)

Create `database/schema/master-schema.sql` with:
- All required tables
- Proper relationships
- Correct data types
- Indexes
- RLS policies

Use the template from IMPLEMENTATION_ROADMAP.md

---

## WHAT YOU'LL HAVE AFTER DAY 1-2

✅ **Clean Root Directory**
- Only essential files
- Clear organization
- No confusion

✅ **Archived Legacy Files**
- Safe backup of everything
- Easy to reference if needed
- Out of the way

✅ **New Structure**
- Professional organization
- Clear file locations
- Ready for development

✅ **Database Documentation**
- Current state documented
- Master schema created
- Migration path clear

---

## NEXT STEPS

After completing Day 1-2:
1. Review progress with team
2. Continue with Day 3-4 (Course Structure Definition)
3. Follow IMPLEMENTATION_ROADMAP.md for remaining tasks

---

## TROUBLESHOOTING

### "I can't find a file"
- Check `SOURCE_OF_TRUTH.md`
- Look in `archive/` folders
- Search git history

### "Something broke"
- Revert to backup branch
- Check git log
- Restore from local backup

### "I'm not sure which file to keep"
- Compare file dates
- Check git blame
- Test functionality
- When in doubt, keep the one in root directory

---

## SUPPORT

If you get stuck:
1. Review the audit documents
2. Check the implementation roadmap
3. Consult with team lead
4. Document the issue for future reference

---

## SUCCESS CHECKLIST

After Day 1-2, you should have:
- [ ] Backup created
- [ ] Archive folder with old files
- [ ] New directory structure
- [ ] SOURCE_OF_TRUTH.md created
- [ ] Database state documented
- [ ] Master schema drafted
- [ ] Progress committed to git
- [ ] Team updated on progress

**You're ready to proceed to Phase 1 Day 3!**


