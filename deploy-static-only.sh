#!/bin/bash

# Static-only Portfolio Deployment Script (works with existing nginx)
echo "🚀 Starting static-only portfolio deployment..."

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

# Check if SSL certificates exist
if [ ! -f "./ssl/cert.pem" ] || [ ! -f "./ssl/key.pem" ]; then
    print_error "SSL certificates not found in ./ssl/ directory"
    print_status "You can set up SSL certificates using:"
    echo "   ./setup-ssl.sh"
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Stop existing containers
print_status "Stopping existing containers..."
docker compose -f docker-compose.static-only.yml down

# Clean up Docker cache
print_status "Cleaning Docker cache..."
docker system prune -f
docker builder prune -f

# Build and start static-only application
print_status "Building static files only..."
if docker compose -f docker-compose.static-only.yml up --build -d; then
    print_success "Static-only deployment successful!"
    print_status "Your portfolio static files are ready!"
    echo ""
    print_status "Container status:"
    docker compose -f docker-compose.static-only.yml ps
    echo ""
    print_status "Memory usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
    echo ""
    print_status "Static files are available in volume: portfolio-static-files"
    print_status "You can access them from your nginx container at: /usr/share/nginx/html"
    echo ""
    print_status "Useful commands:"
    echo "   - View logs: docker compose -f docker-compose.static-only.yml logs -f"
    echo "   - Stop app:  docker compose -f docker-compose.static-only.yml down"
    echo "   - Restart:   docker compose -f docker-compose.static-only.yml restart"
    echo "   - Check files: docker run --rm -v portfolio-static-files:/app alpine ls -la /app"
    echo ""
    print_status "To use with your existing nginx:"
    echo "   - Mount volume: -v portfolio-static-files:/usr/share/nginx/html:ro"
    echo "   - Or copy files: docker cp portfolio-static:/app/dist ./nginx-files"
else
    print_error "Deployment failed. Check the logs:"
    docker compose -f docker-compose.static-only.yml logs
    exit 1
fi 