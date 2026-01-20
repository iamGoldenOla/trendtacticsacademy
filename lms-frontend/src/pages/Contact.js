import React, { useState } from "react";
import { Mail, Phone, MapPin, Send, Copy, CheckCircle } from "lucide-react";
import "./ContactQuoteScroll.css";

// Contact details
const CONTACT_PHONE = '+234 701 234 5678';
const CONTACT_ADDRESS = '12 Allen Avenue, Ikeja, Lagos, Nigeria';
const GOOGLE_MAPS_EMBED = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3971.949234567890!2d3.3500000000000005!3d6.601840000000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x103b92e6e8e8e8e8%3A0x1234567890abcdef!2s12%20Allen%20Ave%2C%20Ikeja%2C%20Lagos%2C%20Nigeria!5e0!3m2!1sen!2sng!4v1710000000000!5m2!1sen!2sng';

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

  return (
    <main className="min-h-screen bg-gray-50 flex flex-col">
      {/* HERO SECTION */}
      <section className="relative h-[40vh] min-h-[400px] flex items-center justify-center overflow-hidden">
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{
            backgroundImage: "url('/images/contactpage-parallex.jpg')",
          }}
        ></div>
        <div className="absolute inset-0 bg-brand-navy/90 backdrop-blur-sm"></div>

        <div className="relative container mx-auto px-4 text-center z-10">
          <span className="inline-block py-1 px-3 rounded-full bg-brand-cyan/20 text-brand-cyan text-sm font-semibold mb-4 border border-brand-cyan/30">
            We'd Love to Hear From You
          </span>
          <h1 className="text-4xl md:text-6xl font-black text-white mb-6 tracking-tight">
            Get in <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand-cyan to-blue-400">Touch</span>
          </h1>
          <p className="text-xl text-gray-300 max-w-2xl mx-auto leading-relaxed">
            Have questions about our courses or need support? Our team is here to help you accelerate your learning journey.
          </p>
        </div>
      </section>

      {/* Content Section */}
      <section className="relative z-20 -mt-20 pb-20 px-4">
        <div className="container mx-auto">
          <div className="flex flex-col lg:flex-row gap-8 max-w-6xl mx-auto">

            {/* Contact Info Card */}
            <div className="lg:w-1/3 order-2 lg:order-1">
              <div className="bg-brand-navy text-white rounded-3xl p-8 shadow-xl h-full relative overflow-hidden group">
                {/* Decorative Circles */}
                <div className="absolute top-0 right-0 w-64 h-64 bg-brand-cyan/10 rounded-full translate-x-1/2 -translate-y-1/2 blur-3xl group-hover:bg-brand-cyan/20 transition-all duration-700"></div>
                <div className="absolute bottom-0 left-0 w-48 h-48 bg-blue-600/20 rounded-full -translate-x-1/2 translate-y-1/2 blur-3xl"></div>

                <h3 className="text-2xl font-bold mb-8 relative z-10">Contact Information</h3>

                <div className="space-y-8 relative z-10">
                  {/* Phone */}
                  <div className="flex gap-4">
                    <div className="w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center flex-shrink-0 text-brand-cyan">
                      <Phone />
                    </div>
                    <div>
                      <p className="text-sm text-gray-400 uppercase tracking-widest font-semibold mb-1">Call Us</p>
                      <p className="font-medium text-lg mb-2">{CONTACT_PHONE}</p>
                      <button
                        onClick={() => handleCopy('phone', CONTACT_PHONE)}
                        className="text-xs flex items-center gap-1.5 text-brand-cyan hover:text-white transition-colors"
                      >
                        {copied.phone ? <CheckCircle size={14} /> : <Copy size={14} />}
                        {copied.phone ? 'Copied' : 'Copy Number'}
                      </button>
                    </div>
                  </div>

                  {/* Email */}
                  <div className="flex gap-4">
                    <div className="w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center flex-shrink-0 text-brand-cyan">
                      <Mail />
                    </div>
                    <div>
                      <p className="text-sm text-gray-400 uppercase tracking-widest font-semibold mb-1">Email Us</p>
                      <p className="font-medium text-lg mb-2">hello@trendtactics.com</p>
                      <button
                        onClick={() => handleCopy('email', 'hello@trendtactics.com')}
                        className="text-xs flex items-center gap-1.5 text-brand-cyan hover:text-white transition-colors"
                      >
                        {copied.email ? <CheckCircle size={14} /> : <Copy size={14} />}
                        {copied.email ? 'Copied' : 'Copy Email'}
                      </button>
                    </div>
                  </div>

                  {/* Address */}
                  <div className="flex gap-4">
                    <div className="w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center flex-shrink-0 text-brand-cyan">
                      <MapPin />
                    </div>
                    <div>
                      <p className="text-sm text-gray-400 uppercase tracking-widest font-semibold mb-1">Visit Us</p>
                      <p className="font-medium text-lg leading-snug mb-2">{CONTACT_ADDRESS}</p>
                      <button
                        onClick={() => handleCopy('address', CONTACT_ADDRESS)}
                        className="text-xs flex items-center gap-1.5 text-brand-cyan hover:text-white transition-colors"
                      >
                        {copied.address ? <CheckCircle size={14} /> : <Copy size={14} />}
                        {copied.address ? 'Copied' : 'Copy Address'}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Contact Form */}
            <div className="lg:w-2/3 order-1 lg:order-2">
              <div className="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 h-full">
                <h3 className="text-2xl font-bold text-gray-900 mb-2">Send us a Message</h3>
                <p className="text-gray-500 mb-8">Fill out the form below and we'll get back to you within 24 hours.</p>

                <form onSubmit={handleSubmit} className="space-y-6">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <label className="text-sm font-semibold text-gray-700 ml-1">Full Name</label>
                      <input
                        type="text"
                        name="name"
                        value={form.name}
                        onChange={handleChange}
                        className={`w-full px-5 py-3 rounded-xl bg-gray-50 border ${errors.name ? 'border-red-500 focus:ring-red-200' : 'border-gray-200 focus:border-brand-cyan focus:ring-brand-cyan/20'} focus:outline-none focus:ring-4 transition-all`}
                        placeholder="John Doe"
                      />
                      {errors.name && <p className="text-red-500 text-xs ml-1">{errors.name}</p>}
                    </div>
                    <div className="space-y-2">
                      <label className="text-sm font-semibold text-gray-700 ml-1">Email Address</label>
                      <input
                        type="email"
                        name="email"
                        value={form.email}
                        onChange={handleChange}
                        className={`w-full px-5 py-3 rounded-xl bg-gray-50 border ${errors.email ? 'border-red-500 focus:ring-red-200' : 'border-gray-200 focus:border-brand-cyan focus:ring-brand-cyan/20'} focus:outline-none focus:ring-4 transition-all`}
                        placeholder="john@example.com"
                      />
                      {errors.email && <p className="text-red-500 text-xs ml-1">{errors.email}</p>}
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-semibold text-gray-700 ml-1">Your Message</label>
                    <textarea
                      name="message"
                      value={form.message}
                      onChange={handleChange}
                      rows="5"
                      className={`w-full px-5 py-3 rounded-xl bg-gray-50 border ${errors.message ? 'border-red-500 focus:ring-red-200' : 'border-gray-200 focus:border-brand-cyan focus:ring-brand-cyan/20'} focus:outline-none focus:ring-4 transition-all`}
                      placeholder="How can we help you?"
                    ></textarea>
                    {errors.message && <p className="text-red-500 text-xs ml-1">{errors.message}</p>}
                  </div>

                  <button
                    type="submit"
                    className="w-full bg-brand-navy hover:bg-brand-cyan text-white hover:text-brand-navy font-bold text-lg py-4 rounded-xl transition-all duration-300 shadow-lg hover:shadow-cyan-500/25 flex items-center justify-center gap-2 group"
                  >
                    {success ? (
                      <>Message Sent <CheckCircle size={20} /></>
                    ) : (
                      <>Send Message <Send size={20} className="group-hover:translate-x-1 transition-transform" /></>
                    )}
                  </button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Map Section */}
      <section className="h-96 w-full relative">
        <iframe
          src={GOOGLE_MAPS_EMBED}
          className="w-full h-full border-0 grayscale hover:grayscale-0 transition-all duration-700"
          allowFullScreen=""
          loading="lazy"
          referrerPolicy="no-referrer-when-downgrade"
          title="Office Location"
        ></iframe>
      </section>
    </main>
  );
};

export default Contact;