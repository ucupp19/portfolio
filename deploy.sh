#!/bin/bash

# Portfolio Deployment Script
echo "🚀 Starting portfolio deployment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if SSL certificates exist
if [ ! -f "./ssl/cert.pem" ] || [ ! -f "./ssl/key.pem" ]; then
    echo "⚠️  SSL certificates not found in ./ssl/ directory"
    echo "📝 You can set up SSL certificates using:"
    echo "   ./setup-ssl.sh"
    echo ""
    echo "🔗 Or manually place your SSL certificates in the ssl/ directory:"
    echo "   - ssl/cert.pem (your SSL certificate)"
    echo "   - ssl/key.pem (your private key)"
    echo ""
    echo "🔗 You can get free SSL certificates from Let's Encrypt using Certbot:"
    echo "   https://letsencrypt.org/getting-started/"
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start the application
echo "🔨 Building and starting the application..."
docker-compose up --build -d

# Check if the container is running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Deployment successful!"
    echo "🌐 Your portfolio is now running at:"
    echo "   - HTTP:  http://your-domain.com (redirects to HTTPS)"
    echo "   - HTTPS: https://your-domain.com"
    echo ""
    echo "📊 Container status:"
    docker-compose ps
    echo ""
    echo "📋 Useful commands:"
    echo "   - View logs: docker-compose logs -f"
    echo "   - Stop app:  docker-compose down"
    echo "   - Restart:   docker-compose restart"
else
    echo "❌ Deployment failed. Check the logs:"
    docker-compose logs
    exit 1
fi 