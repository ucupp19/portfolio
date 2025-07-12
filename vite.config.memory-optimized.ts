import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Memory-optimized Vite config for 256MB VPS
export default defineConfig({
    plugins: [react()],
    build: {
        // Basic optimizations
        target: 'es2015',
        minify: 'esbuild',
        sourcemap: false,

        // Memory optimizations
        reportCompressedSize: false,
        emptyOutDir: true,
        cssCodeSplit: false,

        // Chunk optimization
        rollupOptions: {
            output: {
                manualChunks: {
                    vendor: ['react', 'react-dom'],
                    animations: ['framer-motion', 'gsap'],
                    icons: ['react-icons']
                }
            }
        },

        // Size limits
        chunkSizeWarningLimit: 1000,
        assetsInlineLimit: 4096
    },

    // Optimize dependencies
    optimizeDeps: {
        include: ['react', 'react-dom']
    },

    // Disable HMR for build
    server: {
        hmr: false
    }
}) 