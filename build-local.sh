#!/bin/bash

# Local Portfolio Build Script (no Docker build)
echo "🚀 Starting local portfolio build..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js 20+ first."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 20 ]; then
    print_error "Node.js version 20+ is required. Current version: $(node -v)"
    exit 1
fi

print_status "Node.js version: $(node -v)"

# Check system resources
print_status "Checking system resources..."
TOTAL_MEM=$(free -m | awk 'NR==2{printf "%.0f", $2}')
AVAILABLE_MEM=$(free -m | awk 'NR==2{printf "%.0f", $7}')

print_status "Total RAM: ${TOTAL_MEM}MB, Available: ${AVAILABLE_MEM}MB"

if [ "$AVAILABLE_MEM" -lt 256 ]; then
    print_warning "Low memory available. Consider freeing up some RAM."
fi

# Install dependencies
print_status "Installing dependencies..."
if npm ci --no-audit --no-fund; then
    print_success "Dependencies installed successfully"
else
    print_error "Failed to install dependencies"
    exit 1
fi

# Set memory limits for build
export NODE_OPTIONS="--max-old-space-size=128"
export NODE_ENV=production

# Build the application
print_status "Building portfolio with memory optimization..."
if npm run build; then
    print_success "Portfolio built successfully!"
    echo ""
    print_status "Build output location: ./dist/"
    print_status "Files created:"
    ls -la dist/
    echo ""
    print_status "Integration with your nginx:"
    echo ""
    print_status "Option 1: Copy files to nginx directory"
    echo "   sudo cp -r dist/* /path/to/your/nginx/html/"
    echo ""
    print_status "Option 2: Mount dist directory in nginx"
    echo "   -v \$(pwd)/dist:/usr/share/nginx/html:ro"
    echo ""
    print_status "Option 3: Create Docker volume"
    echo "   docker run --rm -v \$(pwd)/dist:/source -v portfolio-static-files:/dest alpine sh -c 'cp -r /source/* /dest/'"
    echo ""
    print_status "Build completed successfully!"
else
    print_error "Build failed. Check the error messages above."
    exit 1
fi 