import React, { useRef, useEffect } from "react";

const team = [
    {
        name: 'Akinola Olujobi',
        role: 'Founder & CEO',
        avatar: 'https://randomuser.me/api/portraits/men/44.jpg',
        bio: 'Digital marketing strategist with 10+ years of experience in online education and growth.'
    },
    {
        name: 'Michael Lee',
        role: 'Head of Curriculum',
        avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
        bio: 'Expert in content marketing and course design, passionate about student success.'
    },
    {
        name: 'Priya Patel',
        role: 'Lead Instructor',
        avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
        bio: 'Award-winning instructor specializing in SEO, analytics, and digital strategy.'
    },
];

const stats = [
    { label: 'Students Enrolled', value: '50K+' },
    { label: 'Expert Courses', value: '24' },
    { label: 'Completion Rate', value: '95%' },
    { label: 'Avg. Rating', value: '4.8/5' },
];

const testimonials = [
    {
        name: 'Chidera Okafor',
        avatar: 'https://randomuser.me/api/portraits/women/65.jpg',
        quote: 'Trendtactics Academy transformed my career. The courses are practical and the instructors are top-notch!'
    },
    {
        name: 'James Smith',
        avatar: 'https://randomuser.me/api/portraits/men/23.jpg',
        quote: 'I landed my first digital marketing job thanks to the hands-on training and support.'
    },
    {
        name: 'Fatima Bello',
        avatar: 'https://randomuser.me/api/portraits/women/12.jpg',
        quote: 'The community and mentorship at Trendtactics are unmatched. Highly recommended!'
    },
    {
        name: 'Emeka Umeh',
        avatar: 'https://randomuser.me/api/portraits/men/56.jpg',
        quote: 'The curriculum is up-to-date and the learning experience is engaging and fun.'
    },
    {
        name: 'Ngozi Eze',
        avatar: 'https://randomuser.me/api/portraits/women/34.jpg',
        quote: 'I love the flexibility and the real-world projects. I feel ready for any marketing challenge now.'
    },
];

const partners = [
    {
        name: 'Coursera',
        logo: '/partners/coursera.png',
        url: 'https://www.coursera.org/'
    },
    {
        name: 'MTN',
        logo: '/partners/mtn.png',
        url: 'https://www.mtn.com/'
    },
    {
        name: 'Airtel',
        logo: '/partners/airtel.png',
        url: 'https://www.airtel.com/'
    },
    {
        name: 'Glo',
        logo: '/partners/glo.jpg',
        url: 'https://www.gloworld.com/'
    },
    {
        name: 'Udemy',
        logo: '/partners/Udemy.png',
        url: 'https://www.udemy.com/'
    },
    {
        name: 'Mastercard',
        logo: 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg',
        url: 'https://www.mastercard.com/'
    },
    {
        name: 'Google',
        logo: 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg',
        url: 'https://www.google.com/'
    },
    {
        name: 'Microsoft',
        logo: 'https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg',
        url: 'https://www.microsoft.com/'
    },
];

const partnerColors = {
    Coursera: 'bg-blue-100 border-blue-400',
    MTN: 'bg-yellow-100 border-yellow-400',
    Airtel: 'bg-red-100 border-red-400',
    Glo: 'bg-green-100 border-green-400',
    Udemy: 'bg-purple-100 border-purple-400',
    Mastercard: 'bg-yellow-50 border-yellow-400',
    Google: 'bg-gradient-to-br from-blue-100 via-green-100 to-yellow-100 border-blue-400',
    Microsoft: 'bg-blue-50 border-blue-400',
};

const statColors = {
    'Students Enrolled': 'bg-blue-100 border-blue-400',
    'Expert Courses': 'bg-cyan-100 border-cyan-400',
    'Completion Rate': 'bg-green-100 border-green-400',
    'Avg. Rating': 'bg-purple-100 border-purple-400',
};

const teamCardColors = ['bg-blue-50 border-blue-200', 'bg-cyan-50 border-cyan-200', 'bg-purple-50 border-purple-200'];
const testimonialCardColors = ['bg-blue-50 border-blue-200', 'bg-cyan-50 border-cyan-200', 'bg-purple-50 border-purple-200'];

const missionIcons = [
    <svg key="mission" className="w-8 h-8 text-blue-500 mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 19V6m0 0l-3 3m3-3l3 3"/></svg>, // Mission: arrow up
    <svg key="vision" className="w-8 h-8 text-cyan-500 mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="2" fill="none"/><circle cx="12" cy="12" r="4" stroke="currentColor" strokeWidth="2" fill="none"/></svg>, // Vision: eye
    <svg key="values" className="w-8 h-8 text-green-500 mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 21C12 21 4 13.5 4 8.5C4 5.5 6.5 3 9.5 3C11.24 3 12 4.5 12 4.5C12 4.5 12.76 3 14.5 3C17.5 3 20 5.5 20 8.5C20 13.5 12 21 12 21Z"/></svg>, // Values: heart
];

const About = () => {
    // Auto-scroll for testimonials
    const carouselRef = useRef(null);
    
    useEffect(() => {
        const interval = setInterval(() => {
            if (carouselRef.current) {
                carouselRef.current.scrollLeft += 1;
                if (carouselRef.current.scrollLeft >=
                    carouselRef.current.scrollWidth / 2) {
                    carouselRef.current.scrollLeft = 0;
                }
            }
        }, 20);
        return () => clearInterval(interval);
    }, []);
    
    return (<div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <section className="bg-brand-navy py-16 px-4 text-center">
        <h1 className="text-4xl md:text-5xl font-extrabold text-white mb-4">About Trendtactics Academy</h1>
        <p className="text-lg md:text-xl text-cyan-100 max-w-2xl mx-auto">
          Empowering the next generation of digital marketers with world-class, practical, and accessible education in digital marketing, growth, and strategy.
        </p>
      </section>

      {/* Our Story Section (upgraded) */}
      <section className="max-w-4xl mx-auto px-4 py-12">
        <h2 className="text-3xl font-extrabold text-brand-navy text-center mb-6">How It All Began</h2>
        <div className="bg-gradient-to-br from-blue-50 to-cyan-50 rounded-2xl shadow-lg p-8 flex flex-col md:flex-row items-center gap-8">
          {/* Founder Photo */}
          <img src="https://randomuser.me/api/portraits/men/44.jpg" alt="Akinola Olujobi" className="w-32 h-32 rounded-full object-cover border-4 border-brand-cyan shadow-md mb-4 md:mb-0"/>
          <div className="flex-1">
            <p className="text-lg text-gray-700 mb-4">
              Founded by passionate educators and industry experts, Trendtactics Academy was born out of a desire to bridge the gap between theory and real-world digital marketing skills. Our founder, Akinola Olujobi, envisioned a platform where anyone, anywhere, could access high-quality, practical training to launch or accelerate their digital marketing career.
            </p>
            <div className="flex items-center gap-3 mb-2">
              <svg className="w-8 h-8 text-brand-cyan" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7v4a2 2 0 01-2 2H7a2 2 0 01-2-2V7"/></svg>
              <span className="italic text-lg text-brand-navy font-medium">"We believe in empowering learners to not just keep up with the digital world, but to lead it."</span>
            </div>
            <div className="mt-1 text-right w-full">
              <span className="font-semibold text-brand-cyan">— Akinola Olujobi, Founder & CEO</span>
            </div>
          </div>
        </div>
        {/* Timeline Bar */}
        <div className="mt-8 flex flex-col items-center">
          <div className="w-full max-w-xl flex items-center justify-between">
            <div className="flex flex-col items-center">
              <div className="w-4 h-4 bg-brand-cyan rounded-full mb-1"></div>
              <span className="text-xs text-gray-600">2021<br />Founded</span>
            </div>
            <div className="flex-1 h-1 bg-cyan-200 mx-2"></div>
            <div className="flex flex-col items-center">
              <div className="w-4 h-4 bg-green-400 rounded-full mb-1"></div>
              <span className="text-xs text-gray-600">2022<br />1,000+ Students</span>
            </div>
            <div className="flex-1 h-1 bg-cyan-200 mx-2"></div>
            <div className="flex flex-col items-center">
              <div className="w-4 h-4 bg-yellow-400 rounded-full mb-1"></div>
              <span className="text-xs text-gray-600">2023<br />Major Partnerships</span>
            </div>
            <div className="flex-1 h-1 bg-cyan-200 mx-2"></div>
            <div className="flex flex-col items-center">
              <div className="w-4 h-4 bg-brand-navy rounded-full mb-1"></div>
              <span className="text-xs text-gray-600">2025<br />Today</span>
            </div>
          </div>
        </div>
      </section>

      {/* Stats Section (moved up) */}
      <section className="max-w-4xl mx-auto px-4 py-8">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {stats.map((stat) => (<div key={stat.label} className={`rounded-xl p-8 flex flex-col items-center stats-card border-2 shadow-lg transition-transform duration-300 hover:-translate-y-1 hover:shadow-xl ${statColors[stat.label] || 'bg-white border-gray-200'}`}>
              <span className="text-4xl font-extrabold text-brand-navy mb-1">{stat.value}</span>
              <span className="text-gray-700 text-base font-semibold whitespace-nowrap">{stat.label}</span>
            </div>))}
        </div>
      </section>

      {/* Mission, Vision, Values Section (moved up) */}
      <section className="max-w-5xl mx-auto px-4 py-16 grid gap-8 md:grid-cols-3">
        {/* Mission Card */}
        <div className="rounded-2xl shadow-xl p-8 flex flex-col items-center border-2 bg-gradient-to-br from-blue-100 to-blue-50 transition-transform duration-300 hover:-translate-y-2 hover:shadow-2xl hover:ring-2 hover:ring-blue-300">
          {missionIcons[0]}
          <h2 className="text-2xl font-bold text-brand-navy mb-2">Our Mission</h2>
          <p className="text-gray-700 text-center">
            To equip learners with the skills, tools, and confidence to excel in the fast-evolving digital landscape.
          </p>
        </div>
        {/* Vision Card */}
        <div className="rounded-2xl shadow-xl p-8 flex flex-col items-center border-2 bg-gradient-to-br from-cyan-100 to-cyan-50 transition-transform duration-300 hover:-translate-y-2 hover:shadow-2xl hover:ring-2 hover:ring-cyan-300">
          {missionIcons[1]}
          <h2 className="text-2xl font-bold text-brand-navy mb-2">Our Vision</h2>
          <p className="text-gray-700 text-center">
            To be the leading platform for digital marketing education, fostering innovation, creativity, and career growth.
          </p>
        </div>
        {/* Values Card */}
        <div className="rounded-2xl shadow-xl p-8 flex flex-col items-center border-2 bg-gradient-to-br from-green-100 to-green-50 transition-transform duration-300 hover:-translate-y-2 hover:shadow-2xl hover:ring-2 hover:ring-green-300">
          {missionIcons[2]}
          <h2 className="text-2xl font-bold text-brand-navy mb-2">Our Values</h2>
          <ul className="text-gray-700 list-disc list-inside text-left">
            <li>Excellence in teaching and learning</li>
            <li>Accessibility and inclusivity</li>
            <li>Innovation and adaptability</li>
            <li>Community and collaboration</li>
          </ul>
        </div>
      </section>

      {/* Testimonials Carousel */}
      <section className="max-w-5xl mx-auto px-4 py-16">
        <h2 className="text-3xl font-bold text-brand-navy text-center mb-8">What Our Students Say</h2>
        <div className="overflow-x-hidden">
          <div ref={carouselRef} className="flex gap-8 w-max min-w-full items-center stats-carousel overflow-hidden" style={{ scrollBehavior: 'smooth' }}>
            {[...testimonials, ...testimonials].map((t, idx) => (<div key={idx} className={`min-w-[320px] max-w-xs rounded-2xl shadow-lg p-6 flex flex-col items-center border-2 stats-card hover:shadow-2xl transition-shadow duration-300 ${testimonialCardColors[idx % testimonialCardColors.length]} overflow-hidden`}>
                <svg className="w-8 h-8 text-brand-cyan mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 13h6v2a2 2 0 01-2 2H9a2 2 0 01-2-2v-2zm0 0V7a2 2 0 012-2h2a2 2 0 012 2v6"/></svg>
                <div className={`w-16 h-16 rounded-full mb-4 border-4 ${testimonialCardColors[idx % testimonialCardColors.length].split(' ')[1]}`} style={{ borderColor: '' }}>
                  <img src={t.avatar} alt={t.name} className="w-full h-full rounded-full object-cover"/>
                </div>
                <p className="text-gray-700 text-center mb-2">"{t.quote}"</p>
                <span className="text-brand-navy font-semibold">{t.name}</span>
              </div>))}
          </div>
        </div>
      </section>

      {/* Team Section */}
      <section className="max-w-5xl mx-auto px-4 py-12">
        <h2 className="text-3xl font-bold text-brand-navy text-center mb-8">Meet Our Team</h2>
        <div className="grid gap-8 md:grid-cols-3">
          {team.map((member, idx) => (<div key={member.name} className={`rounded-2xl shadow-lg p-6 flex flex-col items-center border-2 transition-transform duration-300 hover:-translate-y-1 hover:shadow-2xl ${teamCardColors[idx % teamCardColors.length]}`}> 
              <div className={`w-24 h-24 rounded-full mb-4 border-4 ${teamCardColors[idx % teamCardColors.length].split(' ')[1]}`} style={{ borderColor: '' }}>
                <img src={member.avatar} alt={member.name} className="w-full h-full rounded-full object-cover"/>
              </div>
              <h3 className="text-xl font-semibold text-brand-navy mb-1">{member.name}</h3>
              <span className="text-brand-cyan font-medium mb-2">{member.role}</span>
              <p className="text-gray-600 text-center text-sm">{member.bio}</p>
            </div>))}
        </div>
      </section>

      {/* Our Partners Section (scrolling carousel) */}
      <section className="max-w-5xl mx-auto px-4 py-8">
        <h2 className="text-2xl font-bold text-brand-navy text-center mb-6">Our Partners</h2>
        <div className="overflow-x-hidden">
          <div className="flex gap-12 w-max min-w-full items-center stats-carousel" style={{ animation: 'stats-scroll 30s linear infinite', perspective: '800px' }}>
            {[...partners, ...partners].map((partner, idx) => (<a key={partner.name + idx} href={partner.url} target="_blank" rel="noopener noreferrer">
                <div className={`h-20 md:h-28 max-w-[180px] flex items-center justify-center rounded-lg p-4 shadow-lg border-2 transition-transform duration-300 hover:scale-110 ${partnerColors[partner.name] || 'bg-white border-gray-200'}`} style={{ background: '', minWidth: '140px' }}>
                  <img src={partner.logo} alt={partner.name + ' logo'} className="max-h-full max-w-full object-contain"/>
                </div>
              </a>))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="text-center py-12">
        <a href="/courses" className="inline-block bg-brand-cyan hover:bg-cyan-600 text-white font-bold px-8 py-4 rounded-full text-lg shadow-lg transition-colors duration-200">
          Browse Courses
        </a>
      </section>

      {/* Contact/Support Section */}
      <section className="bg-white border-t border-gray-200 py-8 px-4 text-center">
        <h2 className="text-2xl font-bold text-brand-navy mb-2">Need Help or Have Questions?</h2>
        <p className="text-gray-700 mb-4">Our support team is here to help you succeed. Reach out to us anytime!</p>
        <a href="mailto:support@trendtactics.academy" className="text-brand-cyan font-semibold underline mr-4">support@trendtactics.academy</a>
        <a href="/contact" className="text-brand-navy font-semibold underline">Contact Page</a>
      </section>

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
    </div>);
};

export default About;