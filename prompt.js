"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const react_1 = __importDefault(require("react"));
// PROMPT PAGE FOR LMS PROJECT
const Prompt = () => (<main className="min-h-screen bg-white text-navy-900 px-4 py-8 md:px-16 font-inter">
    {/* HEADER */}
    <header className="mb-8">
      <h1 className="text-3xl md:text-5xl font-poppins font-bold text-navy-900 mb-2 text-center">LMS Project Prompt</h1>
      <p className="text-cyan-600 text-lg text-center font-medium">Digital Marketing Academy – Trendtactics Digital</p>
    </header>

    {/* PROJECT OVERVIEW */}
    <section className="mb-8">
      <h2 className="text-2xl font-poppins font-semibold text-cyan-600 mb-2">Project Overview</h2>
      <p>
        Create a full-featured Learning Management System (LMS) for a digital academy specializing in digital marketing. The platform must deliver a seamless experience for students to enroll, access courses, track progress, and interact with course content—including video updates and live classes. The LMS must be built using <b>React</b> (frontend), <b>Tailwind CSS</b> (styling), <b>Node.js</b> (backend), and <b>MongoDB</b> (database).
      </p>
    </section>

    {/* CORE FEATURES */}
    <section className="mb-8">
      <h2 className="text-2xl font-poppins font-semibold text-cyan-600 mb-2">Core Features</h2>
      <ul className="list-disc pl-6 space-y-2">
        <li><b>Student Dashboard:</b> Personalized dashboard showing enrolled courses, progress, and upcoming lessons. Quick links to resume learning, view certificates, and access resources.</li>
        <li><b>Authentication & Authorization:</b> Secure sign-up, login, and password reset for students. Role-based access (students, instructors, admins).</li>
        <li><b>Course Management:</b> List of available digital marketing courses. Course detail pages with curriculum, instructor info, and enrollment option. Video lessons, downloadable resources, and quizzes. <span className="text-cyan-700">Video Updates:</span> Instructors can upload new video content to courses, and students receive notifications of new video updates. <span className="text-cyan-700">Live Classes:</span> Schedule and host live classes (e.g., via Zoom, embedded video, or custom streaming), with calendar integration and reminders for students.</li>
        <li><b>Progress Tracking:</b> Track lesson completion, quiz scores, and overall course progress. Visual progress bars and completion certificates.</li>
        <li><b>Responsive UI:</b> Mobile-first, fully responsive design using Tailwind CSS. Clean, modern, and accessible interface.</li>
        <li><b>Backend API:</b> Node.js/Express REST API for user, course, lesson, video, and progress management. JWT-based authentication. MongoDB for storing users, courses, lessons, videos, live class schedules, and progress data.</li>
        <li><b>Admin Panel (Optional for MVP):</b> Manage courses, lessons, users, videos, live classes, and analytics.</li>
      </ul>
    </section>

    {/* TECHNICAL REQUIREMENTS */}
    <section className="mb-8">
      <h2 className="text-2xl font-poppins font-semibold text-cyan-600 mb-2">Technical Requirements</h2>
      <ul className="list-disc pl-6 space-y-2">
        <li><b>Frontend:</b> React, Tailwind CSS, React Router, Axios (or similar for API calls)</li>
        <li><b>Backend:</b> Node.js, Express.js, JWT, bcrypt, MongoDB (Mongoose)</li>
        <li><b>Database:</b> MongoDB (cloud or local)</li>
        <li><b>Other:</b> Brand colors: <span className="font-bold text-navy-900">navy blue</span>, <span className="font-bold text-cyan-600">cyan</span>, and <span className="font-bold text-gray-900">white</span> throughout the UI. Use Poppins for headings, Inter for body text (Google Fonts). SEO meta tags, robots.txt, sitemap.xml. Dark mode toggle. Accessibility best practices (keyboard nav, ARIA, contrast). Modular, reusable components and organized code structure. Clean, semantic HTML5 and well-commented code. Lazy-loaded, compressed .webp images with alt text. Footer: Optionally include "© 2025 Trendtactics Digital" (ask before adding). Consistent header/footer and color palette.</li>
      </ul>
    </section>

    {/* BEFORE BUILDING, ASK */}
    <section className="mb-8">
      <h2 className="text-2xl font-poppins font-semibold text-cyan-600 mb-2">Before Building, Ask</h2>
      <ul className="list-disc pl-6 space-y-2">
        <li>What design style do you prefer? (e.g., Afrocentric, minimalist, bold, etc.)</li>
        <li>Any additional advanced features needed? (e.g., discussion forums, analytics, payments, etc.)</li>
        <li>Placeholder content, layout choice, and brand styling preferences?</li>
        <li>Should the footer include "© 2025 Trendtactics Digital"?</li>
      </ul>
    </section>

    {/* DELIVERABLES */}
    <section className="mb-8">
      <h2 className="text-2xl font-poppins font-semibold text-cyan-600 mb-2">Deliverables</h2>
      <ul className="list-disc pl-6 space-y-2">
        <li>Complete source code (frontend and backend)</li>
        <li>README with setup and usage instructions</li>
        <li>robots.txt and sitemap.xml</li>
        <li>SEO meta tags in all pages</li>
      </ul>
    </section>
  </main>);
exports.default = Prompt;
