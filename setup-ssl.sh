#!/bin/bash

# SSL Certificate Setup Script for Portfolio
echo "🔐 Setting up SSL certificates with Certbot..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please don't run this script as root. Run as regular user with sudo privileges."
    exit 1
fi

# Get domain name from user
read -p "Enter your domain name (e.g., example.com): " DOMAIN_NAME

if [ -z "$DOMAIN_NAME" ]; then
    print_error "Domain name is required!"
    exit 1
fi

print_status "Setting up SSL certificates for: $DOMAIN_NAME"

# Check if Certbot is installed
if ! command -v certbot &> /dev/null; then
    print_status "Installing Certbot..."
    sudo apt update
    sudo apt install -y certbot
    print_success "Certbot installed successfully"
else
    print_success "Certbot is already installed"
fi

# Stop services that might use ports 80/443
print_status "Stopping services that might use ports 80/443..."
sudo systemctl stop nginx 2>/dev/null || true
sudo systemctl stop apache2 2>/dev/null || true
sudo systemctl stop apache 2>/dev/null || true

# Check if ports are available
if sudo netstat -tuln | grep -q ":80 "; then
    print_error "Port 80 is still in use. Please stop the service using it."
    exit 1
fi

# Create ssl directory
mkdir -p ssl

# Get SSL certificates
print_status "Requesting SSL certificates from Let's Encrypt..."
if sudo certbot certonly --standalone -d "$DOMAIN_NAME" --non-interactive --agree-tos --email admin@"$DOMAIN_NAME"; then
    print_success "SSL certificates obtained successfully!"
else
    print_error "Failed to obtain SSL certificates. Please check your domain configuration."
    exit 1
fi

# Copy certificates to project directory
print_status "Copying certificates to project directory..."
sudo cp "/etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem" "./ssl/cert.pem"
sudo cp "/etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem" "./ssl/key.pem"

# Set proper permissions
sudo chown "$USER:$USER" ./ssl/*
chmod 600 ./ssl/key.pem
chmod 644 ./ssl/cert.pem

print_success "Certificates copied and permissions set correctly"

# Set up auto-renewal
print_status "Setting up certificate auto-renewal..."

# Create renewal script
cat > renew-certs.sh << EOF
#!/bin/bash
# Certificate renewal script for $DOMAIN_NAME

# Stop the portfolio container
cd \$(dirname \$0)
docker-compose down

# Renew certificates
sudo certbot renew --quiet

# Copy renewed certificates
sudo cp "/etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem" "./ssl/cert.pem"
sudo cp "/etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem" "./ssl/key.pem"
sudo chown \$USER:\$USER ./ssl/*
chmod 600 ./ssl/key.pem
chmod 644 ./ssl/cert.pem

# Restart the portfolio container
docker-compose up -d

echo "\$(date): Certificates renewed for $DOMAIN_NAME" >> ssl-renewal.log
EOF

chmod +x renew-certs.sh

# Add to crontab for automatic renewal
(crontab -l 2>/dev/null; echo "0 12 * * * $(pwd)/renew-certs.sh") | crontab -

print_success "Auto-renewal configured to run daily at 12:00 PM"

# Test renewal
print_status "Testing certificate renewal..."
if sudo certbot renew --dry-run; then
    print_success "Certificate renewal test passed!"
else
    print_warning "Certificate renewal test failed. Please check manually."
fi

# Display certificate information
print_status "Certificate information:"
echo "Domain: $DOMAIN_NAME"
echo "Certificate expires: $(sudo openssl x509 -in "/etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem" -text -noout | grep "Not After" | cut -d: -f2-)"
echo "Certificate location: /etc/letsencrypt/live/$DOMAIN_NAME/"
echo "Project certificates: ./ssl/"

print_success "SSL setup completed successfully!"
echo ""
print_status "Next steps:"
echo "1. Run: ./deploy.sh"
echo "2. Your portfolio will be available at: https://$DOMAIN_NAME"
echo "3. Certificates will auto-renew daily"
echo "4. Check renewal logs: tail -f ssl-renewal.log" 