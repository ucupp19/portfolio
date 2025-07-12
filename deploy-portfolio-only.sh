#!/bin/bash

# Portfolio Static Files Deployment Script (for existing nginx)
echo "🚀 Starting portfolio static files deployment..."

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

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

# Check system resources
print_status "Checking system resources..."
TOTAL_MEM=$(free -m | awk 'NR==2{printf "%.0f", $2}')
AVAILABLE_MEM=$(free -m | awk 'NR==2{printf "%.0f", $7}')

print_status "Total RAM: ${TOTAL_MEM}MB, Available: ${AVAILABLE_MEM}MB"

if [ "$AVAILABLE_MEM" -lt 256 ]; then
    print_warning "Low memory available. Cleaning up Docker..."
    docker system prune -af
    docker builder prune -af
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Stop existing portfolio container
print_status "Stopping existing portfolio container..."
docker compose -f docker-compose.portfolio-only.yml down

# Clean up Docker cache
print_status "Cleaning Docker cache..."
docker system prune -f
docker builder prune -f

# Build portfolio static files
print_status "Building portfolio static files..."
if docker compose -f docker-compose.portfolio-only.yml up --build -d; then
    print_success "Portfolio static files built successfully!"
    echo ""
    print_status "Container status:"
    docker compose -f docker-compose.portfolio-only.yml ps
    echo ""
    print_status "Memory usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
    echo ""
    print_status "Static files are available in volume: portfolio-static-files"
    echo ""
    print_status "Integration with your existing nginx:"
    echo ""
    print_status "Option 1: Mount volume in your nginx container"
    echo "   Add to your nginx docker-compose.yml:"
    echo "   volumes:"
    echo "     - portfolio-static-files:/usr/share/nginx/html:ro"
    echo ""
    print_status "Option 2: Copy files to your nginx directory"
    echo "   docker cp portfolio-static:/app/dist ./nginx-files"
    echo "   Then mount: -v \$(pwd)/nginx-files:/usr/share/nginx/html:ro"
    echo ""
    print_status "Option 3: Use external volume"
    echo "   docker run --rm -v portfolio-static-files:/source -v \$(pwd)/nginx-files:/dest alpine sh -c 'cp -r /source/* /dest/'"
    echo ""
    print_status "Useful commands:"
    echo "   - View logs: docker compose -f docker-compose.portfolio-only.yml logs -f"
    echo "   - Rebuild:   docker compose -f docker-compose.portfolio-only.yml up --build -d"
    echo "   - Check files: docker run --rm -v portfolio-static-files:/app alpine ls -la /app"
    echo "   - Stop build: docker compose -f docker-compose.portfolio-only.yml down"
else
    print_error "Build failed. Check the logs:"
    docker compose -f docker-compose.portfolio-only.yml logs
    exit 1
fi 