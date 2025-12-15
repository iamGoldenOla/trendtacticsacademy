import React from "react";

const CertificateTemplate = ({ studentName, courseTitle, date, certificateId }) => {
    return (
        <div className="w-full max-w-2xl mx-auto bg-white border-4 border-yellow-400 rounded-2xl shadow-2xl p-10 text-center relative" style={{ fontFamily: 'serif', background: 'linear-gradient(135deg, #fffbe6 0%, #f7fafc 100%)' }}>
            <div className="absolute top-6 left-6">
                <img src="/logo192.png" alt="Trendtactics Academy Logo" className="w-16 h-16"/>
            </div>
            <div className="mb-2 text-lg text-gray-500 tracking-wide">Certificate of Completion</div>
            <h1 className="text-4xl font-bold text-gray-800 mb-4">This is to Certify That</h1>
            <div className="text-3xl font-semibold text-indigo-700 mb-2">{studentName}</div>
            <div className="text-lg text-gray-700 mb-6">has successfully completed the course</div>
            <div className="text-2xl font-bold text-green-700 mb-4">{courseTitle}</div>
            <div className="text-lg text-gray-600 mb-8">on {date}</div>
            <div className="flex justify-between items-center mt-8">
                <div className="text-left">
                    <div className="text-gray-700 font-semibold">Signature</div>
                    <div className="w-32 h-10 border-b-2 border-gray-400 mt-2 mb-1"></div>
                    <div className="text-xs text-gray-500">Academy Director</div>
                </div>
                <div className="text-right">
                    <div className="text-gray-700 font-semibold">Certificate ID</div>
                    <div className="text-xs text-gray-500">{certificateId || 'XXXX-XXXX'}</div>
                </div>
            </div>
            <div className="absolute bottom-6 right-6 text-xs text-gray-400">Trendtactics Academy</div>
        </div>
    );
};

export default CertificateTemplate;