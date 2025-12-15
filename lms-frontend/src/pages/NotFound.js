import React from "react";
import { Link } from "react-router-dom";

const NotFound = () => {
    return (
        <div className="min-h-screen bg-gray-50 flex items-center justify-center">
            <div className="max-w-md mx-auto text-center">
                <div className="text-6xl font-heading font-bold text-brand-navy mb-4">
                    404
                </div>
                <h1 className="text-2xl font-heading font-semibold text-gray-900 mb-4">
                    Page Not Found
                </h1>
                <p className="text-gray-600 mb-8">
                    The page you're looking for doesn't exist. It might have been moved, deleted, or you entered the wrong URL.
                </p>
                <div className="space-y-4">
                    <Link to="/" className="btn-primary block">
                        Go to Homepage
                    </Link>
                    <Link to="/courses" className="btn-secondary block">
                        Browse Courses
                    </Link>
                </div>
            </div>
        </div>
    );
};

export default NotFound;