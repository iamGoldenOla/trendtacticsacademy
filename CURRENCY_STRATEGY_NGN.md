# 💰 Currency Strategy - Naira Only (Recommended)

## ✅ **Your Decision: Naira Only**

**Why This Makes Sense:**
1. ✅ Paystack works best with NGN
2. ✅ Flutterwave works best with NGN
3. ✅ Most students are Nigerian
4. ✅ Simpler pricing (no conversion confusion)
5. ✅ Diaspora can pay in NGN (their banks convert automatically)

---

## 🌍 **How Diaspora Students Pay:**

### **Scenario: Student in USA wants to pay ₦5,000**

**Option 1: International Card (Recommended)**
- Student uses their US Visa/Mastercard
- Enters ₦5,000 payment
- Their bank converts NGN → USD automatically
- Student sees ~$3.33 charge on statement
- **Works seamlessly!**

**Option 2: PayPal (If you add it later)**
- PayPal handles currency conversion
- Student pays in their local currency
- You receive in NGN

**Option 3: Wise/Remitly Transfer**
- Student sends money via Wise
- Converts to NGN
- Pays normally

---

## 💳 **Payment Gateway Support:**

### **Flutterwave:**
- ✅ Accepts NGN from international cards
- ✅ Automatic currency conversion
- ✅ Works in 150+ countries

### **Paystack:**
- ✅ Accepts NGN from international cards
- ✅ Automatic currency conversion
- ✅ Works globally

**Both gateways handle international payments in NGN!**

---

## 📊 **Pricing Strategy:**

### **Current Setup:**
- All courses: ₦5,000
- Currency: NGN only
- Display: ₦5,000 (not $5000)

### **Recommended Pricing:**

**Beginner Courses:**
- ₦3,000 - ₦5,000
- ~$2 - $3.33 USD

**Intermediate Courses:**
- ₦7,500 - ₦15,000
- ~$5 - $10 USD

**Advanced Courses:**
- ₦20,000 - ₦50,000
- ~$13 - $33 USD

**Masterclass:**
- ₦75,000 - ₦150,000
- ~$50 - $100 USD

---

## ✅ **What We Fixed:**

1. **Course Detail Page:** Now shows `₦5,000` (not `$5000`)
2. **Payment Modal:** Uses NGN by default
3. **Database:** Prices in NGN (5000, not 3.00)
4. **Currency Column:** Added with default 'NGN'

---

## 🌐 **For International Students:**

### **FAQ to Add to Your Site:**

**Q: I'm outside Nigeria, can I still pay?**
A: Yes! Use any international Visa/Mastercard. The payment is in Naira (₦), but your bank will automatically convert it to your local currency.

**Q: How much will I be charged in USD/EUR/GBP?**
A: Your bank converts at current exchange rates. For example, ₦5,000 ≈ $3.33 USD.

**Q: Do I need a Nigerian bank account?**
A: No! Any international card works.

---

## 🎯 **Benefits of NGN-Only:**

| Benefit | Impact |
|---------|--------|
| **Simpler** | One price, no confusion |
| **Cheaper** | Lower payment fees in NGN |
| **Faster** | No conversion delays |
| **Compliant** | Meets Nigerian regulations |
| **Works Globally** | International cards accepted |

---

## 💡 **Optional: Add USD Reference**

You can show USD equivalent for clarity:

```
₦5,000 (~$3.33 USD)
```

This helps international students understand the value.

---

## ✅ **Final Setup:**

**Database:**
```sql
price: '5000'
currency: 'NGN'
```

**Display:**
```
₦5,000
```

**Payment:**
```
Amount: 5000 NGN
Gateway: Flutterwave/Paystack
International: ✅ Supported
```

**Perfect! Keep everything in Naira!** 🇳🇬
