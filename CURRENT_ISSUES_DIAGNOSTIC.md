# 🔧 Current Issues & Fixes

## 🚨 **Issue 1: "No course ID provided" on Refresh**

### **Problem:**
When refreshing a course page, you get "No course ID provided" error

### **Cause:**
URL routing issue - the course ID is not being preserved in the URL

### **Quick Check:**
What URL are you seeing when you refresh?
- ❌ Bad: `https://academy.../course` (no ID)
- ✅ Good: `https://academy.../course/abc-123` (has ID)

### **Fix:**
Need to check the routing in your React app. The course ID should be in the URL path.

---

## 🚨 **Issue 2: Flutterwave Stuck on "Please Wait"**

### **Problem:**
Payment gets stuck loading after entering card details

### **Possible Causes:**

#### **1. Webhook Not Deployed** ⚠️ Most Likely
- Flutterwave sends payment to webhook
- If webhook doesn't exist, payment hangs
- User never gets enrolled

**Check:**
1. Go to Supabase Dashboard → Edge Functions
2. Is `flutterwave-webhook` deployed?
3. If NO → Deploy it now!

#### **2. Wrong Secret Hash**
- Flutterwave sends `verif-hash` header
- Must match your `FLUTTERWAVE_SECRET_HASH` in Supabase
- If mismatch, webhook rejects payment

**Check:**
1. Supabase → Edge Functions → flutterwave-webhook → Secrets
2. Is `FLUTTERWAVE_SECRET_HASH` set?
3. Does it match Flutterwave dashboard webhook settings?

#### **3. Test Mode Issues**
- Using test card but webhook expects live payments
- Or vice versa

**Check:**
- Using test public key: `FLWPUBK_TEST-...`
- Using test card: `5531 8866 5214 2950`
- Webhook should accept test payments

---

## ✅ **Immediate Actions:**

### **For Flutterwave Issue:**

**Step 1: Check if Webhook is Deployed**
```
Go to: https://supabase.com/dashboard/project/uimdbodamoeyukrghchb/functions

Look for: flutterwave-webhook
Status: Should be "Active"
```

**Step 2: Check Webhook Logs**
```
Click on: flutterwave-webhook
Go to: Logs tab
Look for: Recent activity when you made payment
```

**Step 3: Check Flutterwave Dashboard**
```
Go to: Flutterwave Dashboard → Settings → Webhooks
Check: Is webhook URL configured?
URL: https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook
```

### **For "No Course ID" Issue:**

**Check Current URL Structure:**
When you're on a course page, what's the URL?

Share the URL and I can help fix the routing.

---

## 🧪 **Test Payment Flow:**

### **Expected Flow:**
1. Click "Enroll Now" → Payment modal opens ✅
2. Enter card details → Flutterwave processes ✅
3. Payment successful → Webhook receives notification ⏳
4. Webhook creates enrollment → User enrolled ⏳
5. Redirect to course → Access granted ⏳

### **Where It's Stuck:**
Step 3 - Webhook not receiving or processing payment

---

## 📋 **Quick Diagnostic:**

Run these checks:

**1. Webhook Deployed?**
- [ ] Yes - flutterwave-webhook exists in Supabase
- [ ] No - Need to deploy it

**2. Secrets Configured?**
- [ ] FLUTTERWAVE_SECRET_HASH set
- [ ] SUPABASE_URL set
- [ ] SUPABASE_SERVICE_ROLE_KEY set

**3. Webhook URL in Flutterwave?**
- [ ] Webhook URL configured
- [ ] Secret hash matches
- [ ] Events: charge.completed enabled

**4. Test Payment Made?**
- [ ] Used test card
- [ ] Payment shows in Flutterwave dashboard
- [ ] Webhook logs show activity

---

## 🎯 **Most Likely Fix:**

**Deploy the webhook!**

If webhook isn't deployed, payments will hang because Flutterwave can't notify your system.

**See:** `DEPLOY_WEBHOOKS_DASHBOARD.md` for deployment steps

---

**Share:**
1. Is webhook deployed? (Check Supabase Functions)
2. What URL shows when you refresh course page?
3. Any errors in browser console (F12)?

I'll help fix both issues!
