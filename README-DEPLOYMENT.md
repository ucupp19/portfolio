# Portfolio Deployment Guide

This guide will help you deploy your portfolio to a VPS using Docker and nginx with HTTPS support.

## Prerequisites

- A VPS with Docker and Docker Compose installed
- A domain name pointing to your VPS
- SSL certificates for your domain

## Quick Start

1. **Clone your repository to your VPS**
   ```bash
   git clone <your-repo-url>
   cd portfolio
   ```

2. **Set up SSL certificates with Certbot**
   ```bash
   chmod +x setup-ssl.sh
   ./setup-ssl.sh
   ```

3. **Make the deployment script executable**
   ```bash
   chmod +x deploy.sh
   ```

4. **Deploy your application**
   ```bash
   ./deploy.sh
   ```

## Manual Deployment

If you prefer to deploy manually:

```bash
# Build and start the application
docker-compose up --build -d

# Check the status
docker-compose ps

# View logs
docker-compose logs -f
```

## Getting SSL Certificates with Certbot

### Step 1: Install Certbot

```bash
# Update package list
sudo apt update

# Install Certbot
sudo apt install certbot

# Verify installation
certbot --version
```

### Step 2: Get SSL Certificates

```bash
# Stop any services using ports 80/443 first
sudo systemctl stop nginx
sudo systemctl stop apache2

# Get certificates for your domain
sudo certbot certonly --standalone -d yourdomain.com

# For multiple domains/subdomains
sudo certbot certonly --standalone -d yourdomain.com -d www.yourdomain.com
```

### Step 3: Set Up Certificate Auto-Renewal

```bash
# Test auto-renewal
sudo certbot renew --dry-run

# Add to crontab for automatic renewal
sudo crontab -e

# Add this line to run twice daily
0 12 * * * /usr/bin/certbot renew --quiet
```

### Step 4: Copy Certificates for Docker

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

### Option 2: Self-signed (Development)

For testing purposes, you can create self-signed certificates:

```bash
mkdir ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ssl/key.pem -out ssl/cert.pem \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
```

## Configuration

### Environment Variables

The application uses the following environment variables:
- `NODE_ENV=production` (set automatically in docker-compose.yml)

### Nginx Configuration

The `nginx.conf` file includes:
- HTTP to HTTPS redirect
- SSL/TLS security settings
- Gzip compression
- Security headers
- Static asset caching
- React Router support

### Ports

- **80**: HTTP (redirects to HTTPS)
- **443**: HTTPS

## Management Commands

```bash
# View logs
docker-compose logs -f

# Stop the application
docker-compose down

# Restart the application
docker-compose restart

# Update and redeploy
git pull
./deploy.sh

# Check container status
docker-compose ps

# Access container shell
docker-compose exec portfolio sh
```

## Troubleshooting

### SSL Certificate Issues
- Ensure certificates are in the correct format (PEM)
- Check file permissions (should be readable by nginx)
- Verify certificate validity and expiration

### Port Conflicts
- Ensure ports 80 and 443 are not used by other services
- Check if nginx or Apache is running on the host

### Build Issues
- Check Docker logs: `docker-compose logs`
- Ensure all dependencies are properly installed
- Verify the build process works locally first

### Performance Issues
- Monitor resource usage: `docker stats`
- Check nginx access logs: `tail -f logs/access.log`
- Optimize images and assets if needed

## Security Considerations

- Keep SSL certificates secure and up-to-date
- Regularly update Docker images and dependencies
- Monitor logs for suspicious activity
- Consider using a reverse proxy for additional security
- Implement rate limiting if needed

## Backup and Recovery

```bash
# Backup SSL certificates
cp -r ssl/ ssl-backup/

# Backup nginx configuration
cp nginx.conf nginx.conf.backup

# Backup logs
cp -r logs/ logs-backup/
```

## Monitoring

The application includes a health check endpoint at `/health` that returns a simple "healthy" response.

You can monitor it with:
```bash
curl https://yourdomain.com/health
``` 