#!/bin/bash

# Lightweight Portfolio Deployment Script for 1GB VPS
echo "🚀 Starting lightweight portfolio deployment..."

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

if [ "$AVAILABLE_MEM" -lt 512 ]; then
    print_warning "Low memory available. Consider freeing up some RAM."
    print_status "Cleaning up Docker system..."
    docker system prune -f
    docker builder prune -f
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
docker compose -f docker compose.lightweight.yml down

# Clean up Docker cache to free memory
print_status "Cleaning Docker cache..."
docker system prune -f
docker builder prune -f

# Build and start the application with memory limits
print_status "Building and starting the application (lightweight mode)..."
if docker compose -f docker compose.lightweight.yml up --build -d; then
    print_success "Deployment successful!"
    print_status "Your portfolio is now running at:"
    echo "   - HTTP:  http://your-domain.com (redirects to HTTPS)"
    echo "   - HTTPS: https://your-domain.com"
    echo ""
    print_status "Container status:"
    docker compose -f docker compose.lightweight.yml ps
    echo ""
    print_status "Memory usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
    echo ""
    print_status "Useful commands:"
    echo "   - View logs: docker compose -f docker-compose.lightweight.yml logs -f"
    echo "   - Stop app:  docker compose -f docker-compose.lightweight.yml down"
    echo "   - Restart:   docker compose -f docker-compose.lightweight.yml restart"
else
    print_error "Deployment failed. Check the logs:"
    docker compose -f docker-compose.lightweight.yml logs
    exit 1
fi 