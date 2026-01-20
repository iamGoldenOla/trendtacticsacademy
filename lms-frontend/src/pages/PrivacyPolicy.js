import React from 'react';
import { Link } from 'react-router-dom';

const PrivacyPolicy = () => {
    return (
        <div className="min-h-screen bg-gray-50 py-12">
            <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="bg-white rounded-2xl shadow-sm p-8 lg:p-12">
                    <h1 className="text-4xl font-bold text-gray-900 mb-4">Privacy Policy</h1>
                    <p className="text-gray-600 mb-8">Last updated: {new Date().toLocaleDateString()}</p>

                    <div className="prose prose-lg max-w-none">
                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">1. Introduction</h2>
                            <p className="text-gray-700 leading-relaxed">
                                Welcome to Trendtactics Academy ("we," "our," or "us"). We are committed to protecting your personal information
                                and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information
                                when you visit our website and use our services.
                            </p>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">2. Information We Collect</h2>

                            <h3 className="text-xl font-semibold text-gray-900 mb-3">Personal Information</h3>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2 mb-4">
                                <li>Name and email address (when you create an account)</li>
                                <li>Payment information (processed securely by Flutterwave)</li>
                                <li>Course enrollment and progress data</li>
                                <li>Profile information you choose to provide</li>
                            </ul>

                            <h3 className="text-xl font-semibold text-gray-900 mb-3">Automatically Collected Information</h3>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2">
                                <li>IP address and browser type</li>
                                <li>Device information and operating system</li>
                                <li>Pages visited and time spent on our site</li>
                                <li>Cookies and similar tracking technologies</li>
                            </ul>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">3. How We Use Your Information</h2>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2">
                                <li>To provide and maintain our educational services</li>
                                <li>To process your course enrollments and payments</li>
                                <li>To send you course updates and important notifications</li>
                                <li>To improve our website and user experience</li>
                                <li>To analyze usage patterns and optimize our content</li>
                                <li>To prevent fraud and ensure platform security</li>
                                <li>To comply with legal obligations</li>
                            </ul>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">4. Cookies and Tracking Technologies</h2>
                            <p className="text-gray-700 leading-relaxed mb-4">
                                We use cookies and similar tracking technologies to enhance your experience on our platform:
                            </p>

                            <div className="bg-gray-50 p-4 rounded-lg mb-4">
                                <h4 className="font-semibold text-gray-900 mb-2">Essential Cookies</h4>
                                <p className="text-gray-700 text-sm">Required for authentication and basic site functionality. Cannot be disabled.</p>
                            </div>

                            <div className="bg-gray-50 p-4 rounded-lg mb-4">
                                <h4 className="font-semibold text-gray-900 mb-2">Functional Cookies</h4>
                                <p className="text-gray-700 text-sm">Remember your preferences like currency and language settings.</p>
                            </div>

                            <div className="bg-gray-50 p-4 rounded-lg">
                                <h4 className="font-semibold text-gray-900 mb-2">Analytics Cookies</h4>
                                <p className="text-gray-700 text-sm">Help us understand how you use our site to improve your experience.</p>
                            </div>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">5. Data Sharing and Disclosure</h2>
                            <p className="text-gray-700 leading-relaxed mb-4">
                                We do not sell your personal information. We may share your data with:
                            </p>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2">
                                <li><strong>Payment Processors:</strong> Flutterwave for secure payment processing</li>
                                <li><strong>Service Providers:</strong> Supabase for database hosting and authentication</li>
                                <li><strong>Analytics Partners:</strong> To understand site usage (with your consent)</li>
                                <li><strong>Legal Authorities:</strong> When required by law or to protect our rights</li>
                            </ul>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">6. Your Rights (GDPR)</h2>
                            <p className="text-gray-700 leading-relaxed mb-4">
                                If you are in the European Economic Area (EEA), you have the following rights:
                            </p>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2">
                                <li><strong>Right to Access:</strong> Request a copy of your personal data</li>
                                <li><strong>Right to Rectification:</strong> Correct inaccurate or incomplete data</li>
                                <li><strong>Right to Erasure:</strong> Request deletion of your personal data</li>
                                <li><strong>Right to Data Portability:</strong> Receive your data in a structured format</li>
                                <li><strong>Right to Object:</strong> Object to processing of your personal data</li>
                                <li><strong>Right to Withdraw Consent:</strong> Withdraw consent at any time</li>
                            </ul>
                            <p className="text-gray-700 leading-relaxed mt-4">
                                To exercise these rights, contact us at <a href="mailto:privacy@trendtacticsdigital.com" className="text-brand-cyan underline">privacy@trendtacticsdigital.com</a>
                            </p>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">7. Data Security</h2>
                            <p className="text-gray-700 leading-relaxed">
                                We implement appropriate technical and organizational measures to protect your personal information, including:
                            </p>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2 mt-4">
                                <li>SSL/TLS encryption for data transmission</li>
                                <li>Secure authentication and authorization</li>
                                <li>Regular security audits and updates</li>
                                <li>Access controls and data minimization</li>
                                <li>Encrypted database storage</li>
                            </ul>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">8. Data Retention</h2>
                            <p className="text-gray-700 leading-relaxed">
                                We retain your personal information only as long as necessary to provide our services and comply with legal obligations:
                            </p>
                            <ul className="list-disc pl-6 text-gray-700 space-y-2 mt-4">
                                <li>Account data: Until you delete your account</li>
                                <li>Course progress: As long as your account is active</li>
                                <li>Payment records: 7 years (legal requirement)</li>
                                <li>Analytics data: 26 months (aggregated and anonymized)</li>
                            </ul>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">9. Children's Privacy</h2>
                            <p className="text-gray-700 leading-relaxed">
                                Our services are not directed to children under 16. We do not knowingly collect personal information from children.
                                If you believe we have collected information from a child, please contact us immediately.
                            </p>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">10. Changes to This Policy</h2>
                            <p className="text-gray-700 leading-relaxed">
                                We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy
                                on this page and updating the "Last updated" date. Continued use of our services after changes constitutes acceptance.
                            </p>
                        </section>

                        <section className="mb-8">
                            <h2 className="text-2xl font-bold text-gray-900 mb-4">11. Contact Us</h2>
                            <p className="text-gray-700 leading-relaxed mb-4">
                                If you have questions about this Privacy Policy or our data practices, please contact us:
                            </p>
                            <div className="bg-gray-50 p-6 rounded-lg">
                                <p className="text-gray-900 font-semibold mb-2">Trendtactics Academy</p>
                                <p className="text-gray-700">Email: <a href="mailto:privacy@trendtacticsdigital.com" className="text-brand-cyan underline">privacy@trendtacticsdigital.com</a></p>
                                <p className="text-gray-700">Website: <a href="https://academy.trendtacticsdigital.com" className="text-brand-cyan underline">academy.trendtacticsdigital.com</a></p>
                            </div>
                        </section>
                    </div>

                    <div className="mt-12 pt-8 border-t border-gray-200">
                        <Link to="/" className="text-brand-cyan hover:text-brand-navy font-medium">
                            ← Back to Home
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default PrivacyPolicy;
