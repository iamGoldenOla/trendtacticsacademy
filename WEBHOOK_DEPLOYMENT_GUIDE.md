# 🚀 Webhook Deployment Guide

## 📍 **Your Webhook URLs:**

After deployment, your webhook URLs will be:

### **Flutterwave Webhook:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook
```

### **Paystack Webhook:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook
```

---

## 🔑 **Flutterwave Secret Hash Explained:**

### **What is it?**
The **Secret Hash** is a password you create yourself to verify webhook authenticity.

### **How to get it:**
1. Go to **Flutterwave Dashboard** → Settings → Webhooks
2. You'll see a field called **"Secret Hash"**
3. **Create your own** - any random string (e.g., `my_secret_hash_2024`)
4. Save it in Flutterwave dashboard
5. Add the SAME value to Supabase Edge Function

**Example:**
```
FLUTTERWAVE_SECRET_HASH=my_super_secret_webhook_hash_12345
```

---

## 🔐 **Environment Variables Needed:**

### **Flutterwave Webhook Function:**
```
FLUTTERWAVE_SECRET_HASH=your-secret-hash-here
SUPABASE_URL=https://uimdbodamoeyukrghchb.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

### **Paystack Webhook Function:**
```
PAYSTACK_SECRET_KEY=sk_test_your-secret-key
SUPABASE_URL=https://uimdbodamoeyukrghchb.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

---

## 📋 **Deployment Steps:**

### **Step 1: Install Supabase CLI** (if not installed)
```bash
npm install -g supabase
```

### **Step 2: Login to Supabase**
```bash
supabase login
```

### **Step 3: Link Your Project**
```bash
cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"
supabase link --project-ref uimdbodamoeyukrghchb
```

### **Step 4: Set Secrets**
```bash
# Flutterwave secrets
supabase secrets set FLUTTERWAVE_SECRET_HASH=your-secret-hash
supabase secrets set SUPABASE_URL=https://uimdbodamoeyukrghchb.supabase.co
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# Paystack secrets
supabase secrets set PAYSTACK_SECRET_KEY=sk_test_your-key
```

### **Step 5: Deploy Functions**
```bash
# Deploy Flutterwave webhook
supabase functions deploy flutterwave-webhook

# Deploy Paystack webhook
supabase functions deploy paystack-webhook
```

---

## 🎯 **Configure in Payment Dashboards:**

### **Flutterwave Dashboard:**
1. Go to **Settings** → **Webhooks**
2. Add webhook URL:
   ```
   https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook
   ```
3. Set your **Secret Hash** (same as in Supabase)
4. Select events: `charge.completed`
5. Save

### **Paystack Dashboard:**
1. Go to **Settings** → **API Keys & Webhooks**
2. Add webhook URL:
   ```
   https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook
   ```
3. No secret hash needed (Paystack uses secret key)
4. Save

---

## ✅ **Verification:**

### **Test Webhooks:**
```bash
# Test Flutterwave
curl -X POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook

# Test Paystack
curl -X POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook
```

### **Check Logs:**
```bash
supabase functions logs flutterwave-webhook
supabase functions logs paystack-webhook
```

---

## 🚨 **Common Issues:**

### **Issue: "Function not found"**
- Make sure you deployed the function
- Check function name matches exactly

### **Issue: "Unauthorized"**
- Verify secrets are set correctly
- Check service role key is correct

### **Issue: "Webhook verification failed"**
- Flutterwave: Check secret hash matches
- Paystack: Check secret key is correct

---

**Ready to deploy? I'll help you run the commands!**
