import { motion } from 'framer-motion';
import { useState } from 'react';
import { PiCertificate } from 'react-icons/pi';

const Certificates = () => {
    const [previewImg, setPreviewImg] = useState<string | null>(null);

    const certificates = [
        {
            name: 'Dicoding Python',
            description: 'Python Programming Certification',
            imgUrl: '/certificates/python.png',
            icon: <PiCertificate />
        },
        {
            name: 'Javacripst Freecodecamp',
            description: 'JavaScript Algorithms and Data Structures',
            imgUrl: '/certificates/javascripts.png',
            icon: <PiCertificate />
        },
        {
            name: 'Responsive Web Design Freecodecamp',
            description: 'Responsive Web Design Certification',
            imgUrl: '/certificates/freecodecamp.png',
            icon: <PiCertificate />
        },
        {
            name: 'Networking Basic Cisco',
            description: 'Cisco Networking Fundamentals',
            imgUrl: '/certificates/networkbasic.png',
            icon: <PiCertificate />
        },
        {
            name: 'Networking Device Cisco',
            description: 'Cisco Device Configuration',
            imgUrl: '/certificates/networkdevice.png',
            icon: <PiCertificate />
        }
    ];

    const handleCertificateClick = (imgUrl: string) => {
        setPreviewImg(imgUrl);
    };

    const closeModal = () => setPreviewImg(null);

    return (
        <>
            <section id="certificates" className="py-20 px-4">
                <div className="max-w-6xl mx-auto">
                    <motion.div
                        initial={{ opacity: 0, y: 100 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        transition={{ duration: 0.8 }}
                        className="text-center mb-16"
                    >
                        <h2 className="text-4xl md:text-5xl font-poppins font-bold">
                            Certificates
                        </h2>
                    </motion.div>

                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {certificates.map((cert) => (
                            <div
                                key={cert.name}
                                onClick={() => handleCertificateClick(cert.imgUrl)}
                                className="p-6 rounded-lg bg-white/5 hover:bg-white/10 transition-all duration-200 cursor-pointer group border border-white/10 hover:border-white/20"
                            >
                                <div className="flex items-center space-x-4 mb-4">
                                    <span className="text-3xl text-yellow-400 group-hover:scale-110 transition-transform duration-200">
                                        {cert.icon}
                                    </span>
                                    <div>
                                        <h3 className="text-xl font-poppins font-bold group-hover:text-yellow-400 transition-colors duration-200">
                                            {cert.name}
                                        </h3>
                                        <p className="text-sm font-figtree font-light text-gray-400">
                                            {cert.description}
                                        </p>
                                    </div>
                                </div>
                                <p className="text-sm font-figtree font-light text-gray-300">
                                    Click to view certificate
                                </p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Image Preview Modal */}
            {previewImg && (
                <div className="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 p-4">
                    <div className="bg-white rounded-lg p-4 max-w-4xl w-full max-h-[90vh] overflow-hidden relative">
                        <button
                            onClick={closeModal}
                            className="absolute top-2 right-2 text-black text-2xl hover:text-gray-600 z-10"
                        >
                            &times;
                        </button>
                        <div className="overflow-auto max-h-[calc(90vh-2rem)] flex items-center justify-center">
                            <img
                                src={previewImg}
                                alt="Certificate Preview"
                                className="w-full h-auto max-h-[80vh] object-contain rounded"
                            />
                        </div>
                    </div>
                </div>
            )}
        </>
    );
};

export default Certificates; 