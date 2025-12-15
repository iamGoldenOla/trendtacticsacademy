import React from "react";
import CertificateTemplate from "../components/CertificateTemplate";

const CertificatePreview: React.FC = () => {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-yellow-100 to-indigo-100 py-10">
      <h2 className="text-3xl font-bold mb-8 text-indigo-700">Certificate Preview</h2>
      <CertificateTemplate
        studentName="Jedi Ark"
        courseTitle="Digital Marketing Mastery"
        date={/* TODO: Replace with real certificate date */ '[Certificate Date]'}
        certificateId="TTAC-2023-0001"
      />
    </div>
  );
};

export default CertificatePreview;