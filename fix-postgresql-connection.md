# Fix PostgreSQL External Connection Issues

## Problem
Getting `ETIMEDOUT` error when connecting from Vercel to Oracle Cloud PostgreSQL because:
1. PostgreSQL is configured for local connections only
2. Firewall is blocking port 5432
3. PostgreSQL authentication needs external access setup

## Solution Steps

### 1. Configure PostgreSQL for External Connections

```bash
# On your Ubuntu server
sudo nano /etc/postgresql/*/main/postgresql.conf
```

Find and modify this line:
```conf
# Change from:
#listen_addresses = 'localhost'

# To:
listen_addresses = '*'
```

### 2. Configure PostgreSQL Authentication

```bash
sudo nano /etc/postgresql/*/main/pg_hba.conf
```

Add this line at the end (replace with your actual IP range or use 0.0.0.0/0 for all IPs):
```conf
# Allow connections from anywhere (use specific IP ranges for better security)
host    all             all             0.0.0.0/0               md5

# Or for better security, allow only Vercel IP ranges:
# host    all             all             76.76.19.0/24           md5
# host    all             all             64.23.132.0/24          md5
```

### 3. Restart PostgreSQL

```bash
sudo systemctl restart postgresql
```

### 4. Configure Oracle Cloud Firewall

#### Option A: Oracle Cloud Console (Recommended)
1. Go to Oracle Cloud Console
2. Navigate to Networking → Virtual Cloud Networks
3. Select your VCN → Security Lists → Default Security List
4. Add Ingress Rule:
   - Source CIDR: `0.0.0.0/0` (or Vercel IP ranges for better security)
   - IP Protocol: TCP
   - Destination Port Range: `5432`

#### Option B: Command Line
```bash
# On your Ubuntu server
sudo ufw allow 5432
sudo ufw reload
```

### 5. Test the Connection

From your local machine or another server:
```bash
# Test connection (replace with your actual IP and credentials)
psql -h 158.178.204.36 -U portfolio_user -d lingo -c "SELECT version();"
```

### 6. Update Your Environment Variables

Make sure your Vercel environment variables are correct:
```env
DATABASE_URL="postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo"
```

## Security Recommendations

### Option 1: Restrict to Vercel IP Ranges (Most Secure)
Instead of allowing all IPs (0.0.0.0/0), use Vercel's IP ranges:

```conf
# In pg_hba.conf, replace the 0.0.0.0/0 line with:
host    all             all             76.76.19.0/24           md5
host    all             all             64.23.132.0/24          md5
host    all             all             64.23.147.0/24          md5
host    all             all             76.223.126.0/24         md5
```

### Option 2: Use SSL Connection
Add SSL requirement to pg_hba.conf:
```conf
hostssl all             all             0.0.0.0/0               md5
```

And update your DATABASE_URL:
```env
DATABASE_URL="postgresql://portfolio_user:SATOSANb6...@158.178.204.36:5432/lingo?sslmode=require"
```

## Troubleshooting

### Check if PostgreSQL is running:
```bash
sudo systemctl status postgresql
```

### Check if port 5432 is listening:
```bash
sudo netstat -tlnp | grep 5432
```

### Check PostgreSQL logs:
```bash
sudo tail -f /var/log/postgresql/postgresql-*-main.log
```

### Test local connection first:
```bash
sudo -u postgres psql -d lingo -c "SELECT version();"
```

## Quick Setup Script

Run this on your Ubuntu server:

```bash
#!/bin/bash
# Quick PostgreSQL external access setup

# Backup original configs
sudo cp /etc/postgresql/*/main/postgresql.conf /etc/postgresql/*/main/postgresql.conf.backup
sudo cp /etc/postgresql/*/main/pg_hba.conf /etc/postgresql/*/main/pg_hba.conf.backup

# Configure PostgreSQL for external connections
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf

# Add external access to pg_hba.conf
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Restart PostgreSQL
sudo systemctl restart postgresql

# Open firewall
sudo ufw allow 5432

echo "PostgreSQL configured for external access!"
echo "Don't forget to configure Oracle Cloud Security Lists!"
```

Save this as `setup-postgres-external.sh`, make it executable with `chmod +x setup-postgres-external.sh`, and run it with `./setup-postgres-external.sh`.