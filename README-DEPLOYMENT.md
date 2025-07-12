# Portfolio Deployment Guide

This guide will help you deploy your portfolio to a VPS using Docker and nginx with HTTPS support. The deployment uses a multi-stage Docker build with nginx serving the built React application.

## 🚀 Quick Start

1. **Clone your repository to your VPS**
   ```bash
   git clone https://github.com/ucupp19/portfolio.git
   cd portfolio
   ```

2. **Set up SSL certificates with Certbot**
   ```bash
   chmod +x setup-ssl.sh
   ./setup-ssl.sh
   ```

3. **Deploy your application**
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

## 📋 Prerequisites

- **VPS Requirements**:
  - Ubuntu/Debian-based system
  - Docker and Docker Compose installed
  - Ports 80 and 443 available
  - Domain name pointing to your VPS IP

- **Local Development**:
  - Node.js (v20.19+ or v22.12+)
  - Git

## 🐳 Docker Configuration

### Multi-Stage Build Process

The deployment uses a multi-stage Docker build:

1. **Build Stage**: Uses Node.js 22 Alpine to build the React application
2. **Production Stage**: Uses nginx Alpine to serve the built application

### Docker Compose Setup

```yaml
services:
  portfolio:
    build: .
    container_name: portfolio-app
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./ssl:/etc/nginx/ssl:ro
      - ./logs:/var/log/nginx
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    networks:
      - portfolio-network
```

## 🔐 SSL Certificate Setup

### Automatic Setup (Recommended)

The `setup-ssl.sh` script automates the entire SSL certificate process:

```bash
./setup-ssl.sh
```

This script will:
- Install Certbot if not present
- Request SSL certificates from Let's Encrypt
- Copy certificates to the project directory
- Set up automatic renewal
- Configure proper file permissions

### Manual SSL Setup

If you prefer manual setup:

#### Step 1: Install Certbot
```bash
sudo apt update
sudo apt install -y certbot
```

#### Step 2: Get SSL Certificates
```bash
# Stop services using ports 80/443
sudo systemctl stop nginx
sudo systemctl stop apache2

# Get certificates for your domain
sudo certbot certonly --standalone -d yourdomain.com

# For multiple domains/subdomains
sudo certbot certonly --standalone -d yourdomain.com -d www.yourdomain.com
```

#### Step 3: Copy Certificates
```bash
# Create ssl directory
mkdir -p ssl

# Copy certificates (adjust domain name)
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ./ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ./ssl/key.pem

# Set proper permissions
sudo chown $USER:$USER ./ssl/*
chmod 600 ./ssl/key.pem
chmod 644 ./ssl/cert.pem
```

#### Step 4: Set Up Auto-Renewal
```bash
# Test auto-renewal
sudo certbot renew --dry-run

# Add to crontab for automatic renewal
sudo crontab -e

# Add this line to run twice daily
0 12 * * * /usr/bin/certbot renew --quiet
```

### Development SSL (Self-signed)

For testing purposes, create self-signed certificates:

```bash
mkdir ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ssl/key.pem -out ssl/cert.pem \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
```

## 🌐 Nginx Configuration

The `nginx.conf` includes comprehensive settings for production deployment:

### Security Features
- HTTP to HTTPS redirect
- SSL/TLS security settings (TLSv1.2, TLSv1.3)
- Security headers (HSTS, XSS Protection, Content Security Policy)
- Gzip compression for better performance

### Performance Optimizations
- Static asset caching (1 year for assets, 1 hour for HTML)
- React Router support (SPA routing)
- Optimized SSL cipher suites

### Key Configuration Sections

```nginx
# HTTP to HTTPS redirect
server {
    listen 80;
    server_name _;
    return 301 https://$host$request_uri;
}

# HTTPS server with SSL
server {
    listen 443 ssl http2;
    server_name _;
    
    # SSL configuration
    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;
    
    # Security headers
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    
    # React Router support
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

## 🚀 Deployment Process

### Automatic Deployment

The `deploy.sh` script handles the complete deployment:

```bash
./deploy.sh
```

This script:
- Checks Docker status
- Validates SSL certificates
- Stops existing containers
- Builds and starts the application
- Provides deployment status and useful commands

### Manual Deployment

```bash
# Build and start the application
docker compose up --build -d

# Check the status
docker compose ps

# View logs
docker compose logs -f
```

## 📊 Management Commands

### Container Management
```bash
# View logs
docker compose logs -f

# Stop the application
docker compose down

# Restart the application
docker compose restart

# Update and redeploy
git pull
./deploy.sh

# Check container status
docker compose ps

# Access container shell
docker compose exec portfolio sh
```

### SSL Certificate Management
```bash
# Check certificate expiration
openssl x509 -in ssl/cert.pem -text -noout | grep "Not After"

# Manual certificate renewal
sudo certbot renew

# View renewal logs
tail -f ssl-renewal.log
```

### Log Management
```bash
# View nginx access logs
tail -f logs/access.log

# View nginx error logs
tail -f logs/error.log

# View Docker logs
docker compose logs -f
```

## 🔧 Configuration

### Environment Variables

The application uses the following environment variables:
- `NODE_ENV=production` (set automatically in docker-compose.yml)

### Port Configuration

- **Port 80**: HTTP (redirects to HTTPS)
- **Port 443**: HTTPS

### Volume Mounts

- `./ssl:/etc/nginx/ssl:ro` - SSL certificates (read-only)
- `./logs:/var/log/nginx` - Nginx logs

## 🛠️ Troubleshooting

### SSL Certificate Issues
```bash
# Check certificate validity
openssl x509 -in ssl/cert.pem -text -noout

# Verify certificate chain
openssl verify ssl/cert.pem

# Check certificate expiration
openssl x509 -in ssl/cert.pem -noout -dates
```

### Port Conflicts
```bash
# Check what's using ports 80/443
sudo netstat -tuln | grep -E ':80|:443'

# Stop conflicting services
sudo systemctl stop nginx
sudo systemctl stop apache2
```

### Build Issues
```bash
# Check Docker logs
docker compose logs

# Rebuild without cache
docker compose build --no-cache

# Check disk space
df -h
```

### Performance Issues
```bash
# Monitor resource usage
docker stats

# Check nginx access logs
tail -f logs/access.log

# Monitor SSL handshakes
grep "SSL" logs/error.log
```

## 🔒 Security Considerations

### SSL/TLS Security
- Uses TLSv1.2 and TLSv1.3 only
- Implements secure cipher suites
- Includes HSTS header for HTTPS enforcement
- Automatic certificate renewal

### Application Security
- Security headers (XSS Protection, Content Security Policy)
- No sensitive data in client-side code
- Proper file permissions for SSL certificates

### Server Security
- Regular updates for Docker images
- Monitor logs for suspicious activity
- Consider implementing rate limiting
- Use firewall rules to restrict access

## 💾 Backup and Recovery

### Backup SSL Certificates
```bash
# Backup SSL certificates
cp -r ssl/ ssl-backup-$(date +%Y%m%d)/

# Backup nginx configuration
cp nginx.conf nginx.conf.backup

# Backup logs
cp -r logs/ logs-backup-$(date +%Y%m%d)/
```

### Recovery Process
```bash
# Restore SSL certificates
cp -r ssl-backup-*/ssl/ ./

# Restore nginx configuration
cp nginx.conf.backup nginx.conf

# Redeploy
./deploy.sh
```

## 📈 Monitoring

### Health Check
The application includes a health check endpoint:
```bash
curl https://yourdomain.com/health
# Returns: "healthy"
```

### Performance Monitoring
```bash
# Monitor container resources
docker stats portfolio-app

# Check nginx performance
tail -f logs/access.log | grep -E "(GET|POST)"

# Monitor SSL certificate status
openssl x509 -in ssl/cert.pem -noout -dates
```

### Log Monitoring
```bash
# Real-time log monitoring
tail -f logs/access.log logs/error.log

# Search for errors
grep -i error logs/error.log

# Monitor SSL handshakes
grep "SSL" logs/error.log
```

## 🔄 Updates and Maintenance

### Application Updates
```bash
# Pull latest changes
git pull origin main

# Redeploy
./deploy.sh
```

### SSL Certificate Renewal
Certificates auto-renew daily at 12:00 PM via cron job. Manual renewal:
```bash
# Test renewal
sudo certbot renew --dry-run

# Manual renewal
sudo certbot renew

# Copy renewed certificates
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ./ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ./ssl/key.pem
sudo chown $USER:$USER ./ssl/*
chmod 600 ./ssl/key.pem
chmod 644 ./ssl/cert.pem

# Restart application
docker compose restart
```

### System Updates
```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Update Docker images
docker compose pull
docker compose up -d
```

## 📞 Support

If you encounter issues:

1. Check the logs: `docker compose logs -f`
2. Verify SSL certificates: `openssl x509 -in ssl/cert.pem -text -noout`
3. Test connectivity: `curl -I https://yourdomain.com`
4. Check container status: `docker compose ps`

For additional help, check the main [README.md](README.md) or create an issue on GitHub. 