# 🚀 Deploy Webhooks via Supabase Dashboard

## 📁 **Your Webhook Files:**

Both files are ready in your project:
- `supabase-functions/flutterwave-webhook.ts`
- `supabase-functions/paystack-webhook.ts`

---

## 🎯 **Deployment Steps (Via Dashboard):**

### **Step 1: Go to Supabase Dashboard**
1. Visit: https://supabase.com/dashboard/project/uimdbodamoeyukrghchb
2. Click **Edge Functions** in left sidebar

### **Step 2: Deploy Flutterwave Webhook**

1. Click **"New Function"** or **"Deploy new function"**
2. **Function name:** `flutterwave-webhook`
3. **Copy and paste** the entire content from `flutterwave-webhook.ts`
4. Click **"Deploy"**

### **Step 3: Add Flutterwave Secrets**

After deploying, click on the function and go to **Settings** → **Secrets**:

Add these 3 secrets:
```
Name: FLUTTERWAVE_SECRET_HASH
Value: [Create a random string, e.g., "trendtactics_flw_2024"]

Name: SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co

Name: SUPABASE_SERVICE_ROLE_KEY
Value: [Get from Supabase Settings → API → service_role key]
```

### **Step 4: Deploy Paystack Webhook**

1. Click **"New Function"** again
2. **Function name:** `paystack-webhook`
3. **Copy and paste** the entire content from `paystack-webhook.ts`
4. Click **"Deploy"**

### **Step 5: Add Paystack Secrets**

Click on the paystack-webhook function → **Settings** → **Secrets**:

Add these 3 secrets:
```
Name: PAYSTACK_SECRET_KEY
Value: sk_test_[your-secret-key]

Name: SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co

Name: SUPABASE_SERVICE_ROLE_KEY
Value: [Same as Flutterwave - get from Supabase Settings → API]
```

---

## 📍 **Your Webhook URLs (After Deployment):**

### **Flutterwave:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook
```

### **Paystack:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook
```

---

## 🔧 **Configure in Payment Dashboards:**

### **Flutterwave Dashboard:**
1. Go to: Settings → Webhooks
2. **Webhook URL:** `https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook`
3. **Secret Hash:** [Same value you used in Supabase secrets]
4. **Events:** Select `charge.completed`
5. **Webhook Preferences:**
   - ✅ Receive webhook response in JSON format
   - ✅ Enable webhook retries
   - ✅ Enable v3 webhooks
   - ✅ Enable resend webhook from the dashboard
6. Click **Save**

### **Paystack Dashboard:**
1. Go to: Settings → API Keys & Webhooks
2. **Webhook URL:** `https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook`
3. **Events:** Select `charge.success`
4. Click **Save**

---

## ✅ **Verification:**

### **Test Flutterwave:**
1. Make a test payment with Flutterwave
2. Check Supabase → Edge Functions → flutterwave-webhook → Logs
3. Verify payment appears in `payments` table

### **Test Paystack:**
1. Make a test payment with Paystack
2. Check Supabase → Edge Functions → paystack-webhook → Logs
3. Verify payment appears in `payments` table

---

## 🔑 **Where to Find Service Role Key:**

1. Go to Supabase Dashboard
2. Click **Settings** (gear icon)
3. Click **API**
4. Scroll to **Project API keys**
5. Copy the **`service_role`** key (NOT the anon key!)

**⚠️ IMPORTANT:** Never share or expose the service_role key!

---

## 📊 **Summary:**

| Step | Action | Status |
|------|--------|--------|
| 1 | Deploy flutterwave-webhook | ⏳ Pending |
| 2 | Add Flutterwave secrets | ⏳ Pending |
| 3 | Deploy paystack-webhook | ⏳ Pending |
| 4 | Add Paystack secrets | ⏳ Pending |
| 5 | Configure Flutterwave dashboard | ⏳ Pending |
| 6 | Configure Paystack dashboard | ⏳ Pending |
| 7 | Test both webhooks | ⏳ Pending |

**Once deployed, both payment gateways will be fully functional!** 🎉
