# 🤖 AI Tutor Edge Function - Deployment Guide

## 📋 **What You Need:**

### **1. OpenAI API Key**
- Go to: https://platform.openai.com/api-keys
- Create new secret key
- Copy the key (starts with `sk-`)

### **2. Supabase Service Role Key**
- Go to Supabase Dashboard → Settings → API
- Copy the `service_role` key

---

## 🚀 **Deployment Steps:**

### **Method 1: Via Supabase Dashboard** (Easiest)

#### **Step 1: Create Function**
1. Go to https://supabase.com/dashboard/project/uimdbodamoeyukrghchb/functions
2. Click "New Function"
3. Name: `ai-tutor`
4. Copy entire content from `ai-tutor.ts`
5. Paste into editor
6. Click "Deploy"

#### **Step 2: Add Secrets**
1. Click on `ai-tutor` function
2. Go to "Settings" → "Secrets"
3. Add these 3 secrets:

```
Name: OPENAI_API_KEY
Value: sk-your-openai-key-here

Name: SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co

Name: SUPABASE_SERVICE_ROLE_KEY
Value: your-service-role-key-here
```

#### **Step 3: Test**
1. Go to "Invocations" tab
2. Click "Test Function"
3. Use this test payload:
```json
{
  "message": "What is digital marketing?",
  "context": "Learning basics"
}
```
4. Should get AI response

---

### **Method 2: Via CLI** (If Docker is running)

```bash
# 1. Navigate to project
cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# 2. Set secrets
supabase secrets set OPENAI_API_KEY=sk-your-key
supabase secrets set SUPABASE_URL=https://uimdbodamoeyukrghchb.supabase.co
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# 3. Deploy function
supabase functions deploy ai-tutor --project-ref uimdbodamoeyukrghchb
```

---

## 🧪 **Testing:**

### **Test with cURL:**
```bash
curl -X POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Explain SEO in simple terms",
    "context": "Digital Marketing Course"
  }'
```

### **Expected Response:**
```json
{
  "response": "SEO (Search Engine Optimization) is the practice of improving your website to rank higher in search engine results...",
  "success": true
}
```

---

## 📊 **Optional: Create Logs Table**

Run this in Supabase SQL Editor to track AI interactions:

```sql
CREATE TABLE ai_tutor_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  message TEXT,
  response TEXT,
  course_id UUID,
  lesson_id UUID,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add index for performance
CREATE INDEX idx_ai_tutor_logs_created_at ON ai_tutor_logs(created_at DESC);
```

---

## 🔧 **Frontend Integration:**

The AI Tutor component in your React app will call this endpoint:

```javascript
// In aiService.js
const response = await fetch(
  'https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor',
  {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      message: userMessage,
      context: 'Learning context',
      courseId: currentCourseId,
      lessonId: currentLessonId
    })
  }
);
```

---

## 💰 **OpenAI Costs:**

**Model:** GPT-3.5-turbo
**Cost:** ~$0.002 per 1K tokens
**Average query:** ~500 tokens = $0.001 per question

**Example:**
- 1,000 questions/month = ~$1
- 10,000 questions/month = ~$10

**Tip:** Start with GPT-3.5-turbo (cheaper), upgrade to GPT-4 if needed

---

## ✅ **Verification Checklist:**

- [ ] OpenAI API key obtained
- [ ] Function deployed to Supabase
- [ ] Secrets added (OPENAI_API_KEY, SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)
- [ ] Test query successful
- [ ] Optional: ai_tutor_logs table created
- [ ] Frontend can call the function

---

## 🚨 **Troubleshooting:**

### **Error: "AI service not configured"**
- Check OPENAI_API_KEY is set in Supabase secrets
- Verify key is valid and has credits

### **Error: "AI service temporarily unavailable"**
- Check OpenAI API status
- Verify API key has available credits
- Check Supabase function logs

### **No response from function:**
- Check CORS headers
- Verify function is deployed
- Check Supabase function logs

---

## 📍 **Your AI Tutor URL:**

```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor
```

**Deploy this and your AI Tutor will be live!** 🤖
