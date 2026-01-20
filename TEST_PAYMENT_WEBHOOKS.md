# 🧪 Test Payment Webhooks - Complete Guide

## ✅ **How to Test If Webhooks Are Working:**

### **Method 1: Test Payment (Recommended)**

#### **Step 1: Make a Test Payment**
1. Go to your website
2. Select a course
3. Click "Enroll" or "Buy Now"
4. Choose **Flutterwave** or **Paystack**
5. Use **test card details**:

**Flutterwave Test Cards:**
```
Card Number: 5531 8866 5214 2950
CVV: 564
Expiry: 09/32
PIN: 3310
OTP: 12345
```

**Paystack Test Cards:**
```
Card Number: 4084 0840 8408 4081
CVV: 408
Expiry: Any future date
OTP: 123456
```

#### **Step 2: Check Webhook Logs**
1. Go to Supabase Dashboard
2. Click **Edge Functions**
3. Click on **flutterwave-webhook** or **paystack-webhook**
4. Click **Logs** tab
5. Look for recent activity

**What to look for:**
- ✅ `Payment processed successfully`
- ✅ `Webhook processed successfully`
- ❌ `Invalid signature` = Secret key mismatch
- ❌ `Missing webhook signature` = Not configured

#### **Step 3: Verify Database**
Run this in Supabase SQL Editor:
```sql
-- Check if payment was recorded
SELECT * FROM payments 
ORDER BY created_at DESC 
LIMIT 5;

-- Check if user was enrolled
SELECT * FROM enrollments 
ORDER BY enrolled_at DESC 
LIMIT 5;
```

**Expected Result:**
- New row in `payments` table
- New row in `enrollments` table
- User can access course

---

### **Method 2: Manual Webhook Test**

#### **Test Flutterwave Webhook:**
```bash
curl -X POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook \
  -H "Content-Type: application/json" \
  -H "verif-hash: YOUR_SECRET_HASH" \
  -d '{
    "event": "charge.completed",
    "data": {
      "tx_ref": "TEST-123-userid-courseid",
      "amount": 1000,
      "currency": "NGN",
      "status": "successful",
      "customer": {
        "email": "test@example.com",
        "name": "Test User"
      }
    }
  }'
```

#### **Test Paystack Webhook:**
```bash
curl -X POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook \
  -H "Content-Type: application/json" \
  -H "x-paystack-signature: [HMAC signature]" \
  -d '{
    "event": "charge.success",
    "data": {
      "reference": "TEST-456",
      "amount": 100000,
      "currency": "NGN",
      "status": "success",
      "customer": {
        "email": "test@example.com",
        "first_name": "Test",
        "last_name": "User"
      },
      "metadata": {
        "user_id": "user-uuid-here",
        "course_id": "course-uuid-here"
      }
    }
  }'
```

---

### **Method 3: Check Payment Dashboard**

#### **Flutterwave:**
1. Go to Flutterwave Dashboard → Transactions
2. Make a test payment
3. Click on the transaction
4. Scroll to **Webhook Logs**
5. Check if webhook was sent and response received

**Expected Response:**
```json
{
  "message": "Webhook processed successfully"
}
```

#### **Paystack:**
1. Go to Paystack Dashboard → Transactions
2. Make a test payment
3. Click on the transaction
4. Check **Webhook** section
5. Verify webhook was delivered

---

## 🔍 **Troubleshooting:**

### **Issue: "Invalid signature"**

**Flutterwave:**
- Check `FLUTTERWAVE_SECRET_HASH` in Supabase matches Flutterwave dashboard
- Must be EXACTLY the same (case-sensitive)

**Paystack:**
- Check `PAYSTACK_SECRET_KEY` in Supabase is correct
- Should start with `sk_test_` or `sk_live_`

### **Issue: "Missing webhook signature"**

**Flutterwave:**
- Webhook URL not configured in Flutterwave dashboard
- Or webhook not enabled

**Paystack:**
- Webhook URL not configured in Paystack dashboard

### **Issue: "Payment already processed"**

✅ This is GOOD! It means duplicate prevention is working.

### **Issue: No logs appearing**

1. Check webhook is deployed: `supabase functions list`
2. Check webhook URL is correct in payment dashboard
3. Verify payment was actually made

---

## ✅ **Success Checklist:**

- [ ] Made test payment with Flutterwave
- [ ] Made test payment with Paystack
- [ ] Checked Supabase logs (no errors)
- [ ] Verified payment in `payments` table
- [ ] Verified enrollment in `enrollments` table
- [ ] User can access purchased course
- [ ] Webhook logs show success in payment dashboard

---

## 🎯 **Quick Test (5 minutes):**

1. **Make ₦100 test payment** with Flutterwave
2. **Check Supabase logs** - should see success
3. **Check database** - payment + enrollment recorded
4. **Repeat with Paystack**

**If all 4 steps work, webhooks are functioning perfectly!** ✅

---

## 📊 **Expected Database Records:**

### **Payments Table:**
```sql
id | transaction_ref | user_id | course_id | amount | currency | status | payment_method
---|----------------|---------|-----------|--------|----------|--------|----------------
1  | TT-123-user-id | uuid... | uuid...   | 1000   | NGN      | completed | flutterwave
2  | PS-456-ref     | uuid... | uuid...   | 1000   | NGN      | completed | paystack
```

### **Enrollments Table:**
```sql
id | user_id | course_id | enrolled_at | payment_status
---|---------|-----------|-------------|----------------
1  | uuid... | uuid...   | 2024-01-20  | paid
2  | uuid... | uuid...   | 2024-01-20  | paid
```

**Both tables should have matching records after successful payment!**
