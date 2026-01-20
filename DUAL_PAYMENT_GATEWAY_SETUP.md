# 🚀 Dual Payment Gateway Setup - Flutterwave + Paystack

## 📦 **What's Been Created:**

### 1. **Paystack Webhook** (`paystack-webhook.ts`)
- Signature verification
- Duplicate payment prevention
- Automatic enrollment
- Full audit trail

### 2. **Updated PaymentModal** 
- Supports both Flutterwave AND Paystack
- User can choose payment method
- Same payment flow for both

### 3. **Unified Payments Table**
- Stores payments from both gateways
- Already created with `CREATE_PAYMENTS_TABLE.sql`

---

## 📋 **Setup Instructions:**

### **Step 1: Run SQL (Do This Now)** ✅

```bash
# Run in Supabase SQL Editor
CREATE_PAYMENTS_TABLE.sql
```

This creates the payments table that works for BOTH gateways.

---

### **Step 2: Get API Keys**

#### **Flutterwave:**
1. Sign up: https://flutterwave.com
2. Go to Settings → API
3. Copy:
   - Public Key: `FLWPUBK-xxxxx`
   - Secret Hash: `xxxxx`

#### **Paystack:**
1. Sign up: https://paystack.com
2. Go to Settings → API Keys & Webhooks
3. Copy:
   - Public Key: `pk_test_xxxxx` or `pk_live_xxxxx`
   - Secret Key: `sk_test_xxxxx` or `sk_live_xxxxx`

---

### **Step 3: Add Environment Variables**

Create `.env` in `lms-frontend`:

```env
# Flutterwave
REACT_APP_FLUTTERWAVE_PUBLIC_KEY=FLWPUBK-test-your-key-here

# Paystack
REACT_APP_PAYSTACK_PUBLIC_KEY=pk_test_your-key-here
```

---

### **Step 4: Deploy Webhooks**

#### **Option A: Using Supabase CLI** (Recommended)

```bash
# Deploy Flutterwave webhook
supabase functions deploy flutterwave-webhook

# Deploy Paystack webhook
supabase functions deploy paystack-webhook
```

#### **Set Environment Variables in Supabase:**

**For Flutterwave webhook:**
- `FLUTTERWAVE_SECRET_HASH` (from Flutterwave dashboard)
- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`

**For Paystack webhook:**
- `PAYSTACK_SECRET_KEY` (from Paystack dashboard)
- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`

---

### **Step 5: Configure Webhooks**

#### **Flutterwave:**
1. Go to Flutterwave Dashboard → Settings → Webhooks
2. Add URL: `https://your-project.supabase.co/functions/v1/flutterwave-webhook`
3. Select event: `charge.completed`
4. Save

#### **Paystack:**
1. Go to Paystack Dashboard → Settings → API Keys & Webhooks
2. Add URL: `https://your-project.supabase.co/functions/v1/paystack-webhook`
3. Save

---

### **Step 6: Install Packages & Build**

```bash
cd lms-frontend
npm install react-paystack
npm run build
```

---

## 💰 **Payment Gateway Comparison:**

| Feature | Flutterwave | Paystack |
|---------|-------------|----------|
| **NGN Support** | ✅ Excellent | ✅ Excellent |
| **International** | ✅ USD, EUR, GBP, etc. | ⚠️ Limited |
| **Fees (NGN)** | 1.4% | 1.5% + ₦100 |
| **Fees (USD)** | 3.8% | 3.9% |
| **Mobile Money** | ✅ Yes | ✅ Yes |
| **USSD** | ✅ Yes | ✅ Yes |
| **Bank Transfer** | ✅ Yes | ✅ Yes |
| **Best For** | International | Nigerian market |

---

## 🎯 **How It Works:**

### **User Flow:**
1. User clicks "Enroll Now"
2. Payment modal opens
3. **User chooses:** Flutterwave OR Paystack
4. Completes payment
5. Webhook verifies payment
6. User automatically enrolled
7. Payment recorded in database

---

## ✅ **Testing:**

### **Flutterwave Test Cards:**
| Card Number | CVV | Expiry | PIN | OTP |
|-------------|-----|--------|-----|-----|
| 5531886652142950 | 564 | 09/32 | 3310 | 12345 |

### **Paystack Test Cards:**
| Card Number | CVV | Expiry | PIN |
|-------------|-----|--------|-----|
| 4084084084084081 | 408 | 01/99 | 0000 |
| 5060666666666666666 | 123 | 01/99 | 1234 |

---

## 📊 **Deployment Checklist:**

- [x] Create payments table (SQL)
- [ ] Get Flutterwave API keys
- [ ] Get Paystack API keys
- [ ] Add keys to `.env`
- [ ] Deploy Flutterwave webhook
- [ ] Deploy Paystack webhook
- [ ] Configure Flutterwave webhook URL
- [ ] Configure Paystack webhook URL
- [ ] Install react-paystack
- [ ] Build React app
- [ ] Deploy to server
- [ ] Test with Flutterwave
- [ ] Test with Paystack

---

## 🔐 **Security Features:**

✅ **Both gateways:**
- Webhook signature verification
- Duplicate payment prevention
- Secure HTTPS communication
- PCI-DSS compliant
- Encrypted transactions

---

## 💡 **Recommendations:**

1. **For Nigerian users:** Offer both (let them choose)
2. **For international:** Flutterwave (better support)
3. **Start with:** Test mode for both
4. **Switch to live:** After thorough testing

---

## 🚀 **Next Steps:**

1. ✅ Run `CREATE_PAYMENTS_TABLE.sql` (Do now)
2. ⏳ Get API keys from both gateways
3. ⏳ Deploy both webhooks
4. ⏳ Test payments
5. ⏳ Go live!

**You now have the flexibility of TWO payment gateways!** 🎉
