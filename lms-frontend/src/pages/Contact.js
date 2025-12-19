import React, { useState } from "react";
import "./ContactQuoteScroll.css";
// Contact details (realistic placeholders)
const CONTACT_PHONE = '+234 701 234 5678';
const CONTACT_ADDRESS = '12 Allen Avenue, Ikeja, Lagos, Nigeria';
const GOOGLE_MAPS_EMBED = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3971.949234567890!2d3.3500000000000005!3d6.601840000000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x103b92e6e8e8e8e8%3A0x1234567890abcdef!2s12%20Allen%20Ave%2C%20Ikeja%2C%20Lagos%2C%20Nigeria!5e0!3m2!1sen!2sng!4v1710000000000!5m2!1sen!2sng';
const GOOGLE_FORM_EMBED = 'https://docs.google.com/forms/d/e/1FAIpQLSfD0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w0w/viewform?embedded=true';
const Contact = () => {
    const [form, setForm] = useState({ name: '', email: '', message: '' });
    const [errors, setErrors] = useState({});
    const [success, setSuccess] = useState(false);
    const [copied, setCopied] = useState({ phone: false, address: false, email: false });
    // Real-time validation
    const validate = (field, value) => {
        switch (field) {
            case 'name':
                return value.trim() ? '' : 'Name is required';
            case 'email':
                return /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value) ? '' : 'Valid email required';
            case 'message':
                return value.trim() ? '' : 'Message is required';
            default:
                return '';
        }
    };
    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        setErrors(prev => ({ ...prev, [name]: validate(name, value) }));
    };
    const handleSubmit = (e) => {
        e.preventDefault();
        const newErrors = {};
        Object.entries(form).forEach(([k, v]) => {
            const err = validate(k, v);
            if (err) newErrors[k] = err;
        });
        setErrors(newErrors);
        if (Object.keys(newErrors).length === 0) {
            setSuccess(true);
            setForm({ name: '', email: '', message: '' });
            setTimeout(() => setSuccess(false), 4000);
        }
    };
    const handleCopy = (type, value) => {
        navigator.clipboard.writeText(value);
        setCopied(prev => ({ ...prev, [type]: true }));
        setTimeout(() => setCopied(prev => ({ ...prev, [type]: false })), 1500);
    };
    return (<main className="min-h-screen bg-gray-50 dark:bg-brand-navy flex flex-col items-center justify-center py-8 px-2">
      {/* HERO SECTION with Parallax */}
      <section className="relative h-96 flex items-center justify-center overflow-hidden rounded-2xl shadow-md mb-8">
        <div 
          className="absolute inset-0 bg-cover bg-center bg-fixed"
          style={{ 
            backgroundImage: "url('/images/contactpage-parallex.jpg')",
            backgroundAttachment: 'fixed'
          }}
        ></div>
        <div className="absolute inset-0 bg-black opacity-70"></div>
        <div className="relative max-w-3xl mx-auto text-center z-10 px-4">
          <h1 className="text-4xl md:text-5xl font-heading font-bold text-white mb-4">Contact Trendtactics Academy</h1>
          <p className="text-lg md:text-xl text-cyan-100 mb-2">We're here to help! Reach out for support, partnership, or general inquiries.</p>
        </div>
      </section>

      {/* White background spacer between hero and cards */}
      <div className="w-full max-w-3xl mx-auto bg-white rounded-2xl shadow-sm py-6 mb-8"></div>
      {/* Divider */}
      <div className="w-full max-w-3xl mx-auto mb-8 flex items-center">
        <div className="w-full border-t border-cyan-200 dark:border-cyan-700"></div>
      </div>

      <div className="flex flex-col md:flex-row-reverse md:justify-center md:items-stretch gap-6 w-full max-w-5xl mb-8">
        {/* CONTACT DETAILS 3D CARD (Right on desktop) */}
        <section className="lesson-3d-card duration bg-white dark:bg-gray-900 shadow-xl rounded-2xl p-6 sm:p-8 w-full md:w-[340px] flex-shrink-0 flex flex-col justify-center mx-auto hover:shadow-2xl transition-shadow" aria-label="Contact Details Section">
          <h2 className="text-2xl font-bold text-center text-brand-navy dark:text-white mb-4 font-heading">Get in Touch</h2>
          <div className="flex flex-col gap-6 w-full">
            {/* Phone */}
            <div className="flex flex-col gap-1">
              <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Phone</span>
              <div className="flex items-center gap-2">
                <span aria-hidden="true" className="inline-block text-white">
                  <svg width="22" height="22" fill="none" viewBox="0 0 24 24" aria-hidden="true"><path d="M2 5.5A3.5 3.5 0 0 1 5.5 2h1A2.5 2.5 0 0 1 9 4.5v2A2.5 2.5 0 0 1 6.5 9h-.25A1.25 1.25 0 0 0 5 10.25v.5A11.25 11.25 0 0 0 16.25 22h.5A1.25 1.25 0 0 0 18 20.75V20.5A2.5 2.5 0 0 1 20.5 18h2A2.5 2.5 0 0 1 25 20.5v1A3.5 3.5 0 0 1 21.5 25h-1C10.282 25 2 16.718 2 6.5v-1Z" fill="currentColor"/></svg>
                </span>
                <a href={`tel:${CONTACT_PHONE.replace(/\s+/g, '')}`} className="text-base text-white font-medium hover:underline" aria-label="Call us">
                  {CONTACT_PHONE}
                </a>
                <button type="button" className="ml-1 px-2 py-1 rounded bg-cyan-100 dark:bg-cyan-900 text-brand-navy dark:text-brand-cyan text-xs font-semibold hover:bg-cyan-200 dark:hover:bg-cyan-800 transition-colors" onClick={() => handleCopy('phone', CONTACT_PHONE)} aria-label="Copy phone number">
                  {copied.phone ? 'Copied!' : 'Copy'}
                </button>
              </div>
            </div>
            {/* Email */}
            <div className="flex flex-col gap-1">
              <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Email</span>
              <div className="flex items-center gap-2">
                <span aria-hidden="true" className="inline-block text-white">
                  <svg width="22" height="22" fill="none" viewBox="0 0 24 24" aria-hidden="true"><path d="M2 4a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4zm2 0v.01L12 13l8-8.99V4H4zm16 2.41l-7.29 7.3a1 1 0 0 1-1.42 0L4 6.41V20h16V6.41z" fill="currentColor"/></svg>
                </span>
                <a href="mailto:support@trendtactics.com" className="text-base text-white font-medium hover:underline" aria-label="Email us">support@trendtactics.com</a>
                <button type="button" className="ml-1 px-2 py-1 rounded bg-cyan-100 dark:bg-cyan-900 text-brand-navy dark:text-brand-cyan text-xs font-semibold hover:bg-cyan-200 dark:hover:bg-cyan-800 transition-colors" onClick={() => handleCopy('email', 'support@trendtactics.com')} aria-label="Copy email">
                  {copied.email ? 'Copied!' : 'Copy'}
                </button>
              </div>
            </div>
            {/* Address */}
            <div className="flex flex-col gap-1">
              <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Address</span>
              <div className="flex items-center gap-2">
                <span aria-hidden="true" className="inline-block text-white">
                  <svg width="22" height="22" fill="none" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2C7.03 2 3 6.03 3 11c0 5.25 7.25 11 8.25 11.75.47.36 1.03.36 1.5 0C13.75 22 21 16.25 21 11c0-4.97-4.03-9-9-9Zm0 13.5a4.5 4.5 0 1 1 0-9 4.5 4.5 0 0 1 0 9Z" fill="currentColor"/></svg>
                </span>
                <span className="text-base text-white font-medium break-words" aria-label="Our address">{CONTACT_ADDRESS}</span>
                <button type="button" className="ml-1 px-2 py-1 rounded bg-cyan-100 dark:bg-cyan-900 text-brand-navy dark:text-brand-cyan text-xs font-semibold hover:bg-cyan-200 dark:hover:bg-cyan-800 transition-colors" onClick={() => handleCopy('address', CONTACT_ADDRESS)} aria-label="Copy address">
                  {copied.address ? 'Copied!' : 'Copy'}
                </button>
              </div>
            </div>
          </div>
        </section>

        {/* CONTACT FORM 3D CARD (Left on desktop) */}
        <section className="lesson-3d-card duration bg-white dark:bg-gray-900 shadow-xl rounded-2xl p-6 sm:p-10 w-full md:w-1/2 flex-shrink-0 hover:shadow-2xl transition-shadow" aria-label="Contact Form Section">
          <h1 className="text-3xl font-bold text-center text-brand-navy dark:text-white mb-2 font-heading">Contact Us</h1>
          <p className="text-center text-gray-600 dark:text-gray-300 mb-6">We'd love to hear from you! Fill out the form below and our team will get back to you soon.</p>
          <form className="space-y-4" aria-label="Contact form" onSubmit={handleSubmit}>
            <div>
              <label htmlFor="name" className="block text-sm font-medium mb-1 text-brand-navy dark:text-gray-200">Name</label>
              <input id="name" name="name" type="text" className={`input-field transition-shadow duration-200 focus:shadow-lg ${errors.name ? 'border-red-500' : ''}`} placeholder="Your Name" required aria-required="true" autoComplete="name" value={form.name} onChange={handleChange} onBlur={handleChange} aria-invalid={!!errors.name} aria-describedby="name-error"/>
              {errors.name && <span id="name-error" className="text-xs text-red-500 mt-1 block">{errors.name}</span>}
          </div>
          <div>
              <label htmlFor="email" className="block text-sm font-medium mb-1 text-brand-navy dark:text-gray-200">Email</label>
              <input id="email" name="email" type="email" className={`input-field transition-shadow duration-200 focus:shadow-lg ${errors.email ? 'border-red-500' : ''}`} placeholder="you@email.com" required aria-required="true" autoComplete="email" value={form.email} onChange={handleChange} onBlur={handleChange} aria-invalid={!!errors.email} aria-describedby="email-error"/>
              {errors.email && <span id="email-error" className="text-xs text-red-500 mt-1 block">{errors.email}</span>}
          </div>
          <div>
              <label htmlFor="message" className="block text-sm font-medium mb-1 text-brand-navy dark:text-gray-200">Message</label>
              <textarea id="message" name="message" className={`input-field transition-shadow duration-200 focus:shadow-lg ${errors.message ? 'border-red-500' : ''}`} rows={4} placeholder="How can we help you?" required aria-required="true" value={form.message} onChange={handleChange} onBlur={handleChange} aria-invalid={!!errors.message} aria-describedby="message-error"/>
              {errors.message && <span id="message-error" className="text-xs text-red-500 mt-1 block">{errors.message}</span>}
          </div>
            <button type="submit" className="btn-primary w-full" aria-label="Send message">Send Message</button>
            {success && <div className="text-green-600 text-center mt-2 font-semibold">Message sent! We'll get back to you soon.</div>}
        </form>
          <div className="text-center text-white text-xs mt-4">We typically respond within 24 hours.</div>
        </section>
      </div>

      {/* GOOGLE MAPS EMBED */}
      <section className="w-full max-w-2xl mb-8" aria-label="Location map">
        <h2 className="text-lg font-semibold text-brand-navy dark:text-brand-cyan mb-2 text-center">Our Location</h2>
        <div className="rounded-2xl overflow-hidden shadow-lg border border-gray-200 dark:border-gray-700">
          <iframe src={GOOGLE_MAPS_EMBED} width="100%" height="300" style={{ border: 0 }} allowFullScreen loading="lazy" referrerPolicy="no-referrer-when-downgrade" title="Google Map Location" aria-label="Google Map Location"></iframe>
        </div>
        <div className="text-center mt-2">
          <a href="https://www.google.com/maps/dir/?api=1&destination=12+Allen+Avenue,+Ikeja,+Lagos,+Nigeria" target="_blank" rel="noopener noreferrer" className="text-brand-cyan underline text-sm hover:text-cyan-700 dark:hover:text-cyan-300 transition-colors">
            Get Directions
          </a>
        </div>
      </section>

      {/* Scrolling motivational quotes directly on blue background */}
      <div className="w-full max-w-3xl mx-auto py-6 mb-8 overflow-hidden relative">
        <div className="whitespace-nowrap animate-scroll-quote text-center font-charm italic">
          {/* Quotes block 1 */}
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Education is the passport to the future, for tomorrow belongs to those who prepare for it today." — Malcolm X
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "The best way to predict your future is to create it." — Abraham Lincoln
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Learning never exhausts the mind." — Leonardo da Vinci
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "Success is not the key to happiness. Happiness is the key to success." — Albert Schweitzer
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Your journey to digital mastery starts with a single step. Take it today."
          </span>
          {/* Quotes block 2 (duplicate for seamless loop) */}
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Education is the passport to the future, for tomorrow belongs to those who prepare for it today." — Malcolm X
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "The best way to predict your future is to create it." — Abraham Lincoln
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Learning never exhausts the mind." — Leonardo da Vinci
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "Success is not the key to happiness. Happiness is the key to success." — Albert Schweitzer
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Your journey to digital mastery starts with a single step. Take it today."
          </span>
          {/* Quotes block 3 (extra duplicate for longer seamless loop) */}
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Education is the passport to the future, for tomorrow belongs to those who prepare for it today." — Malcolm X
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "The best way to predict your future is to create it." — Abraham Lincoln
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Learning never exhausts the mind." — Leonardo da Vinci
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-brand-cyan px-8">
            "Success is not the key to happiness. Happiness is the key to success." — Albert Schweitzer
          </span>
          <span className="inline-block text-lg md:text-xl font-heading font-semibold text-white px-8">
            "Your journey to digital mastery starts with a single step. Take it today."
          </span>
        </div>
      </div>

      {/* Footer Section */}
      <footer className="bg-brand-navy text-white mt-8">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          {/* Email Subscriber Form */}
          <div className="mb-8 flex flex-col items-center">
            <h3 className="text-lg font-semibold mb-2">Subscribe to our Newsletter</h3>
            <p className="text-sm text-gray-200 mb-4 text-center max-w-md">Get updates on new courses, exclusive offers, and digital marketing tips delivered to your inbox.</p>
            <form className="flex flex-col sm:flex-row gap-2 w-full max-w-md" onSubmit={e => { e.preventDefault(); alert('Thank you for subscribing!'); }}>
              <input type="email" required placeholder="Enter your email" className="rounded-l-md rounded-r-md sm:rounded-r-none px-4 py-2 w-full text-gray-900 focus:outline-none focus:ring-2 focus:ring-cyan-400"/>
              <button type="submit" className="bg-cyan-500 hover:bg-cyan-600 text-white font-semibold px-6 py-2 rounded-md sm:rounded-l-none transition-colors">
                Subscribe
              </button>
            </form>
          </div>
          {/* Existing footer content here */}
    </div>
      </footer>
    </main>);
};
export default Contact;