import { FaHome } from 'react-icons/fa';
import { FaCode } from 'react-icons/fa';
import { PiCertificate } from 'react-icons/pi';
import { IoMdContact } from 'react-icons/io';
import { MdQuestionMark } from "react-icons/md"

const Navbar = () => {
    const navItems = [
        { id: 'home', icon: <FaHome />, label: 'Home' },
        { id: 'about', icon: <MdQuestionMark />, label: 'About Me' },
        { id: 'tech', icon: <FaCode />, label: 'Tech Stack' },
        { id: 'projects', icon: <FaCode />, label: 'My Projects' },
        { id: 'certificates', icon: <PiCertificate />, label: 'Certificates' },
        { id: 'contact', icon: <IoMdContact />, label: 'Contact' },
    ];

    const scrollToSection = (id: string) => {
        const element = document.getElementById(id);
        if (element) {
            element.scrollIntoView({ behavior: 'smooth' });
        }
    };

    return (
        <nav className="w-full top-0 left-0 right-0 z-50 bg-black/80 backdrop-blur-sm border-b border-white/10">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex items-center justify-center h-16">
                    <div className="flex items-center space-x-8">
                        {navItems.map((item) => (
                            <button
                                key={item.id}
                                onClick={() => scrollToSection(item.id)}
                                className="flex items-center space-x-2 text-white hover:text-gray-300 transition-colors duration-200 group"
                                title={item.label}
                            >
                                <span className="text-xl group-hover:scale-110 transition-transform duration-200">
                                    {item.icon}
                                </span>
                                <span className="hidden md:block text-sm font-medium">
                                    {item.label}
                                </span>
                            </button>
                        ))}
                    </div>
                </div>
            </div>
        </nav>
    );
};

export default Navbar; 