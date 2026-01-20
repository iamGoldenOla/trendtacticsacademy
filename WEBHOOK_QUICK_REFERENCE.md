# 🎯 Webhook Configuration Summary

## 📍 **Your Webhook URLs:**

### **Flutterwave:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook
```

### **Paystack:**
```
https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook
```

---

## 🔑 **Flutterwave Secret Hash:**

### **What is it?**
A password YOU create to verify webhooks are really from Flutterwave.

### **How to set it up:**

1. **Create your secret hash** (any random string):
   ```
   Example: my_webhook_secret_2024
   ```

2. **Add to Flutterwave Dashboard:**
   - Go to: Settings → Webhooks
   - Find "Secret Hash" field
   - Enter your secret hash
   - Save

3. **Add to Supabase Edge Function:**
   - Go to Supabase Dashboard
   - Edge Functions → flutterwave-webhook → Secrets
   - Add secret:
     ```
     Name: FLUTTERWAVE_SECRET_HASH
     Value: my_webhook_secret_2024
     ```

**IMPORTANT:** The secret hash must be EXACTLY the same in both places!

---

## 📋 **Complete Setup Checklist:**

### **1. Flutterwave Setup:**
- [ ] Deploy flutterwave-webhook function
- [ ] Add secrets to Supabase:
  - `FLUTTERWAVE_SECRET_HASH`
  - `SUPABASE_URL`
  - `SUPABASE_SERVICE_ROLE_KEY`
- [ ] Configure in Flutterwave Dashboard:
  - Webhook URL: `https://uimdbodamoeyukrghchb.supabase.co/functions/v1/flutterwave-webhook`
  - Secret Hash: (same as Supabase)
  - Events: `charge.completed`

### **2. Paystack Setup:**
- [ ] Deploy paystack-webhook function
- [ ] Add secrets to Supabase:
  - `PAYSTACK_SECRET_KEY`
  - `SUPABASE_URL`
  - `SUPABASE_SERVICE_ROLE_KEY`
- [ ] Configure in Paystack Dashboard:
  - Webhook URL: `https://uimdbodamoeyukrghchb.supabase.co/functions/v1/paystack-webhook`

### **3. Database Setup:**
- [ ] Run `CREATE_PAYMENTS_TABLE.sql` in Supabase SQL Editor

---

## 🎯 **Quick Reference:**

| Item | Flutterwave | Paystack |
|------|-------------|----------|
| **Webhook URL** | `/functions/v1/flutterwave-webhook` | `/functions/v1/paystack-webhook` |
| **Verification** | Secret Hash | Secret Key |
| **Public Key** | `FLWPUBK-test-...` | `pk_test_...` |
| **Secret Key** | Not needed | `sk_test_...` |
| **Secret Hash** | Custom string | Not needed |

---

## ✅ **After Deployment:**

1. **Test with small payment** (₦100 or $1)
2. **Check Supabase logs** for webhook activity
3. **Verify payment recorded** in `payments` table
4. **Check user enrolled** in course

---

**Both webhooks are ready to deploy!**
