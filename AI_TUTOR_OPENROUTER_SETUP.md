# 🤖 AI Tutor with OpenRouter (FREE!) - Quick Setup

## ✅ **You Already Have:**
- OpenRouter API key in Supabase secrets ✓

## 📋 **What You Still Need:**

### **1. Supabase Service Role Key**
1. Go to: https://supabase.com/dashboard/project/uimdbodamoeyukrghchb/settings/api
2. Scroll to "Project API keys"
3. Copy the **`service_role`** key (NOT the anon key!)

---

## 🚀 **Quick Deploy (3 Steps):**

### **Step 1: Deploy Function**
1. Go to: https://supabase.com/dashboard/project/uimdbodamoeyukrghchb/functions
2. Click "New Function"
3. Name: `ai-tutor`
4. Copy ALL code from `ai-tutor.ts`
5. Paste and click "Deploy"

### **Step 2: Add Missing Secrets**
Click on `ai-tutor` function → Settings → Secrets

Add these 2 secrets (OpenRouter key already added):

```
Name: SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co

Name: SUPABASE_SERVICE_ROLE_KEY
Value: [paste your service role key here]
```

### **Step 3: Test**
Go to "Invocations" tab, test with:
```json
{
  "message": "What is SEO?",
  "context": "Digital Marketing"
}
```

---

## ✅ **That's It!**

Your AI Tutor is now live at:
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor
```

---

## 💰 **Cost: $0.00 (FREE!)**

**Model:** meta-llama/llama-3.2-3b-instruct:free
**Provider:** OpenRouter
**Limit:** Unlimited (with rate limits)

---

## 🎯 **Free Models Available:**

If you want to change the model, edit line 79 in `ai-tutor.ts`:

```typescript
model: 'meta-llama/llama-3.2-3b-instruct:free', // Current
// OR try these:
// model: 'google/gemma-2-9b-it:free',
// model: 'microsoft/phi-3-mini-128k-instruct:free',
// model: 'qwen/qwen-2-7b-instruct:free',
```

---

## 🧪 **Test from Browser Console:**

```javascript
fetch('https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    message: 'Explain digital marketing in simple terms',
    context: 'Learning basics'
  })
})
.then(r => r.json())
.then(data => console.log(data.response))
```

---

## ✅ **Checklist:**

- [x] OpenRouter API key in secrets
- [ ] Deploy `ai-tutor` function
- [ ] Add SUPABASE_URL secret
- [ ] Add SUPABASE_SERVICE_ROLE_KEY secret
- [ ] Test with sample question

**Deploy now - it's already configured for OpenRouter!** 🚀
