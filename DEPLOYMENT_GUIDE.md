# Lingo App - Production Deployment Guide

## Prerequisites
- Oracle Cloud VPS with Ubuntu/CentOS
- PostgreSQL installed and running
- Node.js 18+ installed
- PM2 or similar process manager
- Nginx (optional, for reverse proxy)

## 1. Database Setup on Oracle Cloud

### Connect to your PostgreSQL instance:
```bash
sudo -u postgres psql
```

### Create the database and configure user:
```sql
-- Create the lingo database
CREATE DATABASE lingo;

-- Grant all privileges to portfolio_user on lingo database
GRANT ALL PRIVILEGES ON DATABASE lingo TO portfolio_user;

-- Connect to the lingo database
\c lingo

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO portfolio_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO portfolio_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO portfolio_user;

-- Exit PostgreSQL
\q
```

### Test the connection:
```bash
psql -h localhost -U portfolio_user -d lingo
# Enter password: ATOSANb6...
```

## 2. VPS Setup

### Clone the repository:
```bash
git clone https://github.com/SalahBoussetah/lingo.git
cd lingo
```

### Install dependencies:
```bash
npm install
```

### Environment Configuration:
```bash
# Copy the production environment file
cp .env.production .env

# Edit the .env file with your actual values
nano .env
```

**Update these values in .env:**
- Replace `YOUR_ORACLE_CLOUD_IP` with your actual Oracle Cloud instance IP
- Replace `YOUR_PRODUCTION_PUBLISHABLE_KEY` with your Clerk production publishable key
- Replace `YOUR_PRODUCTION_SECRET_KEY` with your Clerk production secret key
- Replace `YOUR_PRODUCTION_STRIPE_KEY` with your Stripe live API key
- Replace `YOUR_PRODUCTION_WEBHOOK_SECRET` with your Stripe live webhook secret
- Replace `https://yourdomain.com` with your actual domain

## 3. Database Migration

### Push the database schema:
```bash
npm run db:push
```

### Seed the database with initial data:
```bash
npm run db:seed
```

### (Optional) Add production data:
```bash
npm run db:prod
```

## 4. Build and Deploy

### Build the application:
```bash
npm run build
```

### Install PM2 globally:
```bash
npm install -g pm2
```

### Create PM2 ecosystem file:
```bash
cat > ecosystem.config.js << 'EOF'
module.exports = {
  apps: [{
    name: 'lingo-app',
    script: 'npm',
    args: 'start',
    cwd: '/path/to/your/lingo',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
  }]
}
EOF
```

### Start the application:
```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

## 5. Nginx Configuration (Optional)

### Install Nginx:
```bash
sudo apt update
sudo apt install nginx
```

### Create Nginx configuration:
```bash
sudo nano /etc/nginx/sites-available/lingo
```

### Add this configuration:
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/lingo /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 6. SSL Certificate (Let's Encrypt)

### Install Certbot:
```bash
sudo apt install certbot python3-certbot-nginx
```

### Get SSL certificate:
```bash
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

## 7. Firewall Configuration

### Configure UFW:
```bash
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 5432  # PostgreSQL (if external access needed)
sudo ufw enable
```

## 8. Monitoring and Maintenance

### Check application status:
```bash
pm2 status
pm2 logs lingo-app
```

### Monitor system resources:
```bash
pm2 monit
```

### Database backup script:
```bash
#!/bin/bash
# Create backup directory
mkdir -p /home/backups/lingo

# Create backup
pg_dump -h localhost -U portfolio_user -d lingo > /home/backups/lingo/lingo_backup_$(date +%Y%m%d_%H%M%S).sql

# Keep only last 7 days of backups
find /home/backups/lingo -name "*.sql" -mtime +7 -delete
```

### Set up cron job for daily backups:
```bash
crontab -e
# Add this line for daily backup at 2 AM
0 2 * * * /path/to/backup_script.sh
```

## 9. Environment Variables Checklist

Make sure these are properly configured in your `.env` file:

- [ ] `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` - Clerk production publishable key
- [ ] `CLERK_SECRET_KEY` - Clerk production secret key
- [ ] `DATABASE_URL` - Oracle Cloud PostgreSQL connection string
- [ ] `STRIPE_API_KEY` - Stripe live API key
- [ ] `STRIPE_WEBHOOK_SECRET` - Stripe live webhook secret
- [ ] `NEXT_PUBLIC_APP_URL` - Your production domain

## 10. Post-Deployment Testing

1. **Database Connection**: Test that the app can connect to PostgreSQL
2. **Authentication**: Test Clerk authentication flows
3. **Payments**: Test Stripe integration (use test mode first)
4. **Course Content**: Verify that courses and lessons load correctly
5. **User Progress**: Test that user progress is saved properly

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**:
   - Check PostgreSQL is running: `sudo systemctl status postgresql`
   - Verify user permissions and password
   - Check firewall rules

2. **Build Errors**:
   - Clear cache: `rm -rf .next node_modules package-lock.json`
   - Reinstall: `npm install`
   - Rebuild: `npm run build`

3. **PM2 Issues**:
   - Check logs: `pm2 logs lingo-app`
   - Restart app: `pm2 restart lingo-app`
   - Check memory usage: `pm2 monit`

### Useful Commands:
```bash
# Check application logs
pm2 logs lingo-app --lines 100

# Restart application
pm2 restart lingo-app

# Check database connection
psql -h localhost -U portfolio_user -d lingo -c "SELECT version();"

# Check Nginx status
sudo systemctl status nginx

# View Nginx error logs
sudo tail -f /var/log/nginx/error.log
```

## Security Recommendations

1. **Database Security**:
   - Use strong passwords
   - Limit database access to localhost only
   - Regular backups

2. **Application Security**:
   - Keep dependencies updated
   - Use HTTPS only
   - Implement rate limiting

3. **Server Security**:
   - Regular system updates
   - SSH key authentication
   - Fail2ban for intrusion prevention

---

**Note**: Replace all placeholder values with your actual production credentials and domain information before deployment.