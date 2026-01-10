# 🚀 TrendTactics Academy - Quick Reference Card

---

## 📁 Project Structure

```
trendtactics-academy/
├── lms-frontend/                    # React Frontend
│   ├── src/
│   │   ├── api/                    # 🆕 Backend-agnostic API layer
│   │   │   ├── client.ts           # HTTP client with interceptors
│   │   │   ├── endpoints.ts        # API endpoint definitions
│   │   │   ├── services/           # Service layer
│   │   │   │   └── course.service.ts
│   │   │   └── adapters/           # Backend adapters
│   │   │       └── supabase.adapter.ts
│   │   │
│   │   ├── components/             # React components
│   │   │   └── LessonViewer.new.tsx  # 🆕 Modern lesson viewer
│   │   │
│   │   ├── pages/                  # Page components
│   │   │   ├── Home.tsx
│   │   │   ├── Courses.tsx
│   │   │   ├── CourseDetail.tsx
│   │   │   └── Dashboard.tsx       # 🆕 Student dashboard
│   │   │
│   │   ├── config/                 # 🆕 Configuration
│   │   │   └── security.config.ts  # Security settings
│   │   │
│   │   └── types/                  # 🆕 TypeScript types
│   │       └── api.types.ts
│   │
│   └── .env.example                # 🆕 Environment template
│
├── ENTERPRISE_ARCHITECTURE.md      # 🆕 System architecture
├── SCALABILITY_GUIDE.md            # 🆕 Scaling guide
├── PHASE_3_DEPLOYMENT.md           # 🆕 Deployment guide
└── PHASE_3_COMPLETE.md             # 🆕 Summary
```

---

## 🔑 Key Files

### API Layer (Backend-Agnostic)
| File | Purpose |
|------|---------|
| `api/client.ts` | HTTP client with auto token refresh |
| `api/endpoints.ts` | Centralized API endpoints |
| `api/services/course.service.ts` | Course API service |
| `api/adapters/supabase.adapter.ts` | Temporary Supabase adapter |
| `types/api.types.ts` | TypeScript type definitions |

### Security
| File | Purpose |
|------|---------|
| `config/security.config.ts` | Security configuration |
| `.env.example` | Environment variables template |

### Components
| File | Purpose |
|------|---------|
| `components/LessonViewer.new.tsx` | Modern lesson viewer |
| `pages/Dashboard.tsx` | Student dashboard |

---

## ⚙️ Environment Variables

```bash
# Copy template
cp lms-frontend/.env.example lms-frontend/.env

# Key variables:
REACT_APP_USE_API_BACKEND=false          # false = Supabase, true = API
REACT_APP_API_BASE_URL=http://localhost:3001/api
REACT_APP_SUPABASE_URL=your_url
REACT_APP_SUPABASE_ANON_KEY=your_key
```

---

## 🚀 Common Commands

### Development
```bash
cd lms-frontend
npm install              # Install dependencies
npm start                # Start dev server (http://localhost:3000)
npm run build            # Build for production
npm test                 # Run tests
```

### Git
```bash
git add -A               # Stage all changes
git commit -m "message"  # Commit changes
git push origin master   # Push to GitHub (auto-deploys to cPanel)
git status               # Check status
git log --oneline        # View commit history
```

### Package Management
```bash
npm install package-name          # Install package
npm install package-name --save   # Install and save to package.json
npm uninstall package-name        # Remove package
npm update                        # Update all packages
```

---

## 🔌 Using the API Layer

### Get All Courses
```typescript
import { courseService } from './api/services/course.service';

const courses = await courseService.getAllCourses();
```

### Get Course by ID
```typescript
const course = await courseService.getCourseById('course-id');
```

### Get Course Modules
```typescript
const modules = await courseService.getCourseModules('course-id');
```

### Get Lesson by ID
```typescript
const lesson = await courseService.getLessonById('lesson-id');
```

---

## 🔄 Switching Backends

### Currently Using Supabase
```bash
# In .env
REACT_APP_USE_API_BACKEND=false
```

### Switch to Your Backend API
```bash
# In .env
REACT_APP_USE_API_BACKEND=true
REACT_APP_API_BASE_URL=https://api.yourdomain.com
```

**No code changes needed!** The frontend automatically switches.

---

## 🔒 Security Features

### Rate Limits
- 100 API requests per minute
- 5 login attempts per hour
- 3 registration attempts per hour
- 10MB file upload limit
- 500MB video upload limit

### Input Validation
```typescript
import { VALIDATION_RULES } from './config/security.config';

// Email validation
VALIDATION_RULES.EMAIL_REGEX.test(email);

// Password validation (8+ chars, uppercase, lowercase, number, special)
VALIDATION_RULES.PASSWORD_REGEX.test(password);
```

### XSS Protection
```typescript
import { sanitizeInput, sanitizeHTML } from './config/security.config';

const clean = sanitizeInput(userInput);
const cleanHTML = sanitizeHTML(htmlContent);
```

---

## 📊 Architecture Layers

```
┌─────────────────────────────────────┐
│         Users (2B+)                 │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│         CDN (CloudFlare)            │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│    Frontend (React + TypeScript)    │
│    - Components                     │
│    - Pages                          │
│    - State Management               │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│       API Layer (Abstraction)       │
│    - client.ts                      │
│    - services/                      │
│    - adapters/                      │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│    Backend (Supabase → Your API)    │
│    - Authentication                 │
│    - Business Logic                 │
│    - Data Processing                │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│      Cache Layer (Redis)            │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│    Database (PostgreSQL)            │
│    - Primary                        │
│    - Read Replicas                  │
│    - Sharding                       │
└─────────────────────────────────────┘
```

---

## 📈 Scaling Checklist

### Phase 1: 0-100K Users ✅ CURRENT
- [x] Single server deployment
- [x] Supabase database
- [x] Basic monitoring

### Phase 2: 100K-1M Users
- [ ] Deploy backend API
- [ ] Add load balancer
- [ ] Set up Redis cache
- [ ] Configure CDN
- [ ] Add read replicas

### Phase 3: 1M-10M Users
- [ ] Multi-region deployment
- [ ] Database sharding
- [ ] API Gateway
- [ ] Message queue
- [ ] Advanced monitoring

---

## 🆘 Troubleshooting

### Build Fails
```bash
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Environment Variables Not Working
- Ensure they start with `REACT_APP_`
- Restart dev server after changes
- Check for typos

### API Not Working
- Check `REACT_APP_USE_API_BACKEND` setting
- Verify API URL is correct
- Check browser console for errors

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| `ENTERPRISE_ARCHITECTURE.md` | Complete system architecture |
| `SCALABILITY_GUIDE.md` | How to scale to 2B+ users |
| `PHASE_3_DEPLOYMENT.md` | Deployment instructions |
| `PHASE_3_COMPLETE.md` | What was accomplished |
| `DEPLOYMENT_GUIDE.md` | General deployment guide |

---

## 🎯 Next Steps

1. **Test New Features**
   - Dashboard at `/dashboard`
   - Lesson Viewer at `/courses/:id/lessons/:id`

2. **Build Backend API**
   - Node.js + NestJS recommended
   - Deploy to AWS/Heroku/Railway

3. **Set Up Infrastructure**
   - Redis for caching
   - CDN for static assets
   - Monitoring (Sentry)

4. **Scale**
   - Add load balancer
   - Database read replicas
   - Multi-region deployment

---

## 💡 Pro Tips

✅ **Always use the service layer** - Don't call APIs directly from components

✅ **Type everything** - Use TypeScript types from `api.types.ts`

✅ **Validate inputs** - Use security config validation rules

✅ **Handle errors** - API client has built-in error handling

✅ **Monitor performance** - Check API response times

✅ **Test before deploy** - Run `npm run build` locally first

---

## 📞 Support

- **Documentation:** Check the MD files in root directory
- **Code Comments:** All files have detailed comments
- **GitHub:** https://github.com/iamGoldenOla/trendtacticsacademy

---

**🎉 You're all set! Happy coding!**

