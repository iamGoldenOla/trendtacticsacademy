# 🚀 AI Playground Setup Guide

## 📋 **What This Does:**
Creates a secure backend for the AI playground so students don't need to provide their own API keys.

---

## 🔧 **Setup Steps:**

### **Step 1: Deploy Supabase Edge Function**

1. **Install Supabase CLI** (if not installed):
   ```bash
   npm install -g supabase
   ```

2. **Login to Supabase**:
   ```bash
   supabase login
   ```

3. **Link your project**:
   ```bash
   supabase link --project-ref uimdbodamoeyukrghchb
   ```

4. **Create the function folder**:
   ```bash
   mkdir -p supabase/functions/ai-playground
   ```

5. **Copy the function code**:
   - Copy `supabase-edge-function-ai-playground.ts` to `supabase/functions/ai-playground/index.ts`

6. **Deploy the function**:
   ```bash
   supabase functions deploy ai-playground
   ```

7. **Set your OpenAI API key** (secure environment variable):
   ```bash
   supabase secrets set OPENAI_API_KEY=your-openai-api-key-here
   ```

---

### **Step 2: Update FIXED_course.html**

Replace the `handleAIRequest` function (around line 996) with the new version that calls the Edge Function instead of OpenAI directly.

**I'll create the updated function in the next file.**

---

### **Step 3: Test**

1. Upload updated `FIXED_course.html` to your server
2. Open a lesson with a playground
3. Enter a prompt (e.g., "Create a simple calculator")
4. Click "Generate Code"
5. Code should generate without asking for API key!

---

## 🔐 **Security Benefits:**

✅ **API keys stored securely** on Supabase (not in browser)  
✅ **No localStorage** - students can't access or steal keys  
✅ **Rate limiting** - can be added to Edge Function  
✅ **Cost control** - you control the AI model and limits  

---

## 💰 **Cost Estimate:**

- **GPT-4o-mini:** ~$0.15 per 1M input tokens, ~$0.60 per 1M output tokens
- **Average playground request:** ~500 input + 1000 output tokens = ~$0.001 per request
- **100 students × 10 requests each = 1,000 requests = ~$1.00**

Very affordable! 🎉

---

**Ready to deploy?** Let me know if you need help with any step!
