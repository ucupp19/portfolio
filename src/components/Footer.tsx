

const Footer = () => (
    <footer className="w-full py-6 bg-black border-t border-white/10 mt-12">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between px-4 text-gray-400 text-sm">
            <span>
                &copy; {new Date().getFullYear()} Afrizz. All rights reserved.
            </span>
            <span>
                Built with <a href="https://react.dev/" className="underline hover:text-white" target="_blank" rel="noopener noreferrer">React</a>
            </span>
        </div>
    </footer>
);

export default Footer; 