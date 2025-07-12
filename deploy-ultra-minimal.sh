#!/bin/bash

# Ultra-minimal Portfolio Deployment Script for 256MB VPS
echo "🚀 Starting ultra-minimal portfolio deployment..."

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

# Aggressive cleanup for low memory
print_warning "Performing aggressive Docker cleanup..."
docker system prune -af
docker builder prune -af
docker image prune -af
docker container prune -f
docker volume prune -f
docker network prune -f

# Clear system cache
print_status "Clearing system cache..."
sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches 2>/dev/null || true

# Stop existing containers
print_status "Stopping existing containers..."
docker compose -f docker-compose.ultra-minimal.yml down

# Create logs directory if it doesn't exist
mkdir -p logs

# Build with ultra-minimal configuration
print_status "Building with ultra-minimal configuration (64MB limit)..."
print_warning "This may take longer due to extreme memory constraints..."

# Set environment variables for low memory
export NODE_OPTIONS="--max-old-space-size=64"
export NODE_ENV=production

if docker compose -f docker-compose.ultra-minimal.yml up --build -d; then
    print_success "Ultra-minimal deployment successful!"
    echo ""
    print_status "Container status:"
    docker compose -f docker-compose.ultra-minimal.yml ps
    echo ""
    print_status "Memory usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
    echo ""
    print_status "System memory after deployment:"
    free -h
    echo ""
    print_status "Static files are available in volume: portfolio-static-files"
    echo ""
    print_status "Integration with your existing nginx:"
    echo "   Add to your nginx docker-compose.yml:"
    echo "   volumes:"
    echo "     - portfolio-static-files:/usr/share/nginx/html:ro"
    echo ""
    print_status "Useful commands:"
    echo "   - View logs: docker compose -f docker-compose.ultra-minimal.yml logs -f"
    echo "   - Rebuild:   docker compose -f docker-compose.ultra-minimal.yml up --build -d"
    echo "   - Check files: docker run --rm -v portfolio-static-files:/app alpine ls -la /app"
    echo "   - Stop:      docker compose -f docker-compose.ultra-minimal.yml down"
else
    print_error "Deployment failed. Check the logs:"
    docker compose -f docker-compose.ultra-minimal.yml logs
    exit 1
fi 