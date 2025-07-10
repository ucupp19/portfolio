import React, { useEffect, useState } from "react";

const greetings = [
    { text: "Hello", color: "text-blue-400" },
    { text: "Hi", color: "text-green-400" },
    { text: "Ola", color: "text-yellow-400" },
    { text: "Hola", color: "text-pink-400" },
];

const Typewriter: React.FC = () => {
    const [index, setIndex] = useState(0);
    const [displayed, setDisplayed] = useState("");
    const [typing, setTyping] = useState(true);

    useEffect(() => {
        let timeout: number;
        const current = greetings[index].text;
        if (typing) {
            if (displayed.length < current.length) {
                timeout = window.setTimeout(() => setDisplayed(current.slice(0, displayed.length + 1)), 100);
            } else {
                timeout = window.setTimeout(() => setTyping(false), 2000);
            }
        } else {
            if (displayed.length > 0) {
                timeout = window.setTimeout(() => setDisplayed(current.slice(0, displayed.length - 1)), 50);
            } else {
                setTyping(true);
                setIndex((prev) => (prev + 1) % greetings.length);
            }
        }
        return () => clearTimeout(timeout);
    }, [displayed, typing, index]);

    return (
        <span className={`font-bold ${greetings[index].color}`}>
            {displayed}
            <span className="animate-pulse">_</span>
        </span>
    );
};

export default Typewriter; 