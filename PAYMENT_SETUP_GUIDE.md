# 🚀 Payment Integration Setup Guide

## 📦 Step 1: Install Flutterwave Package

Run this command in the `lms-frontend` directory:

```bash
npm install flutterwave-react-v3
```

---

## 🔑 Step 2: Get Flutterwave API Keys

### **Create Flutterwave Account:**

1. Go to [https://flutterwave.com](https://flutterwave.com)
2. Click "Get Started" → Sign up
3. Verify your email
4. Complete business verification

### **Get API Keys:**

1. Login to Flutterwave Dashboard
2. Go to **Settings** → **API**
3. Copy your **Public Key**

**Test Mode:** `FLWPUBK-test-xxxxxxxxxxxxx`
**Live Mode:** `FLWPUBK-xxxxxxxxxxxxx`

---

## ⚙️ Step 3: Add API Key to Environment

Create `.env` file in `lms-frontend` folder:

```env
REACT_APP_FLUTTERWAVE_PUBLIC_KEY=FLWPUBK-test-your-key-here
```

**For production:**
```env
REACT_APP_FLUTTERWAVE_PUBLIC_KEY=FLWPUBK-your-live-key-here
```

---

## 🏗️ Step 4: Build and Deploy

```bash
cd lms-frontend
npm install
npm run build
```

Upload `build` folder to your server.

---

## ✅ Step 5: Test Payment Flow

### **Test Cards (Flutterwave Sandbox):**

| Card Number | CVV | Expiry | PIN | OTP |
|-------------|-----|--------|-----|-----|
| 5531886652142950 | 564 | 09/32 | 3310 | 12345 |
| 4187427415564246 | 828 | 09/32 | N/A | 12345 |

### **Test Flow:**

1. Go to Courses page
2. Click "Enroll Now" on any course
3. Login if not logged in
4. Payment modal appears
5. Select currency (USD, NGN, EUR, GBP, CAD, AUD)
6. Click "Pay"
7. Enter test card details
8. Complete payment
9. User enrolled → Redirected to course

---

## 💰 Supported Currencies

| Currency | Code | Symbol | Example Price |
|----------|------|--------|---------------|
| US Dollar | USD | $ | $3.00 |
| Nigerian Naira | NGN | ₦ | ₦4,500 |
| Euro | EUR | € | €2.76 |
| British Pound | GBP | £ | £2.37 |
| Canadian Dollar | CAD | C$ | C$4.05 |
| Australian Dollar | AUD | A$ | A$4.56 |

---

## 🔧 Webhook Setup (Optional but Recommended)

### **Create Webhook Endpoint:**

1. Create Supabase Edge Function:

```bash
supabase functions new payment-webhook
```

2. Add webhook URL in Flutterwave Dashboard:
   - Settings → Webhooks
   - Add: `https://your-project.supabase.co/functions/v1/payment-webhook`

3. Verify payments server-side for security

---

## 📊 Transaction Fees

### **Flutterwave Fees:**

- **NGN Cards:** 1.4%
- **International Cards:** 3.8%
- **Bank Transfer:** ₦10 flat
- **USSD:** ₦50 flat

### **Example:**
- Course Price: $3.00
- Fee (3.8%): $0.11
- **You Receive:** $2.89

---

## 🎯 Next Steps

1. ✅ Install package: `npm install flutterwave-react-v3`
2. ✅ Get Flutterwave API key
3. ✅ Add to `.env` file
4. ✅ Build React app: `npm run build`
5. ✅ Deploy to server
6. ✅ Test with sandbox cards
7. ✅ Switch to live mode when ready

---

## 🚨 Important Notes

- **Test Mode:** Use test API key for development
- **Live Mode:** Switch to live key only after thorough testing
- **Security:** Never expose API keys in client-side code (use environment variables)
- **Webhooks:** Implement for production to verify payments server-side

---

## 📞 Support

- **Flutterwave Docs:** [https://developer.flutterwave.com](https://developer.flutterwave.com)
- **Support:** support@flutterwavego.com
- **Test Cards:** [https://developer.flutterwave.com/docs/test-cards](https://developer.flutterwave.com/docs/test-cards)

**You're all set! 🎉**
