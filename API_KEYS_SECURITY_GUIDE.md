# 🔐 API Keys Security Guide

## ✅ **PUBLIC Keys (Safe in Frontend)**

These keys are designed to be public and can safely be included in your React `.env` file:

### **1. Supabase Anon Key**
```
REACT_APP_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```
- ✅ Safe to expose in frontend
- Protected by Row Level Security (RLS)
- Can only access data allowed by RLS policies

### **2. Flutterwave Public Key**
```
REACT_APP_FLUTTERWAVE_PUBLIC_KEY=FLWPUBK-test-xxxxx
```
- ✅ Safe to expose in frontend
- Starts with `FLWPUBK-`
- Only initiates payment, cannot complete without webhook verification

### **3. Paystack Public Key**
```
REACT_APP_PAYSTACK_PUBLIC_KEY=pk_test_43035d3b6c556c7019386196faf399c1c51b1ce4
```
- ✅ Safe to expose in frontend
- Starts with `pk_test_` or `pk_live_`
- Only initiates payment, cannot complete without webhook verification

---

## ❌ **SECRET Keys (NEVER in Frontend)**

These keys must ONLY be stored in backend/server environment:

### **1. Supabase Service Role Key**
```
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```
- ❌ NEVER in frontend .env
- ✅ Only in Supabase Edge Functions
- Bypasses RLS - full database access

### **2. Flutterwave Secret Key**
```
FLUTTERWAVE_SECRET_KEY=FLWSECK-xxxxx
```
- ❌ NEVER in frontend .env
- ✅ Only in Supabase Edge Functions
- Used for webhook signature verification

### **3. Paystack Secret Key**
```
PAYSTACK_SECRET_KEY=
```
- ❌ NEVER in frontend .env
- ✅ Only in Supabase Edge Functions
- Starts with `sk_test_` or `sk_live_`
- Used for webhook signature verification

---

## 📁 **Where Keys Should Be Stored:**

### **Frontend (.env file):**
```env
# ✅ SAFE - Public keys only
REACT_APP_SUPABASE_URL=https://uimdbodamoeyukrghchb.supabase.co
REACT_APP_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
REACT_APP_FLUTTERWAVE_PUBLIC_KEY=FLWPUBK_TEST-415d3c92b9c49dd6eda7eaf268998803-X
REACT_APP_PAYSTACK_PUBLIC_KEY=pk_test_43035d3b6c556c7019386196faf399c1c51b1ce4
```

### **Supabase Edge Functions (Environment Variables):**
```
# ❌ SECRET - Never in frontend
SUPABASE_SERVICE_ROLE_KEY=
FLUTTERWAVE_SECRET_KEY=FLWSECK-xxxxx
FLUTTERWAVE_SECRET_HASH=your-webhook-hash
PAYSTACK_SECRET_KEY=sk_test_xxxxx
```

**How to set in Supabase:**
1. Go to Supabase Dashboard
2. Settings → Edge Functions
3. Add secrets for each webhook function

---

## 🔒 **Security Best Practices:**

### **1. Never Commit Real Keys**
```bash
# Add to .gitignore
.env
.env.local
.env.production
```

### **2. Use .env.example**
```env
# Template with placeholder values
REACT_APP_SUPABASE_URL=your-supabase-url-here
REACT_APP_SUPABASE_ANON_KEY=your-anon-key-here
```

### **3. Rotate Keys Regularly**
- Change keys every 3-6 months
- Immediately if compromised
- Use different keys for test/production

### **4. Test vs Production**
```env
# Test keys (for development)
REACT_APP_PAYSTACK_PUBLIC_KEY=pk_test_43035d3b6c556c7019386196faf399c1c51b1ce4

# Production keys (for live site)
REACT_APP_PAYSTACK_PUBLIC_KEY=pk_live_xxxxx
```

---

## ✅ **Your Current Setup:**

### **Frontend (.env):**
- ✅ Supabase Anon Key
- ✅ Flutterwave Public Key
- ✅ Paystack Public Key

### **Backend (Supabase Edge Functions):**
- ✅ Flutterwave Secret Hash (for webhook)
- ✅ Paystack Secret Key (for webhook)
- ✅ Supabase Service Role Key

**This is the correct and secure setup!** 🎉

---

## 🎯 **Quick Reference:**

| Key Type | Frontend | Backend | Starts With |
|----------|----------|---------|-------------|
| Supabase Anon | ✅ Yes | ❌ No | eyJhbGciOi... |
| Supabase Service | ❌ No | ✅ Yes | eyJhbGciOi... |
| Flutterwave Public | ✅ Yes | ❌ No | FLWPUBK- |
| Flutterwave Secret | ❌ No | ✅ Yes | FLWSECK- |
| Paystack Public | ✅ Yes | ❌ No | pk_test_ or pk_live_ |
| Paystack Secret | ❌ No | ✅ Yes | sk_test_ or sk_live_ |

**Remember: If it starts with "public" or "pk_", it's safe for frontend. If it starts with "secret" or "sk_", it belongs in backend only!**
