#!/bin/bash

# Ultra-lightweight Portfolio Deployment Script for 256MB VPS
echo "🚀 Starting ultra-lightweight portfolio deployment..."

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
    print_warning "Very low memory available. Aggressive cleanup needed."
    print_status "Performing aggressive Docker cleanup..."
    docker system prune -af
    docker builder prune -af
    docker image prune -af
    docker container prune -f
    docker volume prune -f
    docker network prune -f
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
docker compose -f docker-compose.ultra-lightweight.yml down

# Aggressive cleanup to free memory
print_status "Performing aggressive Docker cleanup..."
docker system prune -af
docker builder prune -af
docker image prune -af

# Build and start with ultra-lightweight configuration
print_status "Building and starting application (ultra-lightweight mode)..."
print_warning "This may take longer due to memory constraints..."

if docker compose -f docker-compose.ultra-lightweight.yml up --build -d; then
    print_success "Ultra-lightweight deployment successful!"
    print_status "Your portfolio is now running at:"
    echo "   - HTTP:  http://your-domain.com (redirects to HTTPS)"
    echo "   - HTTPS: https://your-domain.com"
    echo ""
    print_status "Container status:"
    docker compose -f docker-compose.ultra-lightweight.yml ps
    echo ""
    print_status "Memory usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
    echo ""
    print_status "System memory after deployment:"
    free -h
    echo ""
    print_status "Useful commands:"
    echo "   - View logs: docker compose -f docker-compose.ultra-lightweight.yml logs -f"
    echo "   - Stop app:  docker compose -f docker-compose.ultra-lightweight.yml down"
    echo "   - Restart:   docker compose -f docker-compose.ultra-lightweight.yml restart"
    echo "   - Monitor:   watch -n 5 'free -h && docker stats --no-stream'"
else
    print_error "Deployment failed. Check the logs:"
    docker compose -f docker-compose.ultra-lightweight.yml logs
    exit 1
fi 