# 🚀 Automatic Deployment Setup

This guide will help you set up automatic deployment of your Flutter web portfolio to your VPS using GitHub Actions.

## 📋 Prerequisites

- VPS with Ubuntu/Linux
- Flutter installed on VPS
- Nginx/Apache web server
- SSH access to VPS
- GitHub repository

## 🔧 Setup Instructions

### Step 1: Prepare Your VPS

1. **SSH into your VPS:**
   ```bash
   ssh your-username@intishar.xyz
   ```

2. **Clone your repository to VPS:**
   ```bash
   sudo mkdir -p /var/www/intishar.xyz
   sudo chown $USER:$USER /var/www/intishar.xyz
   cd /var/www/intishar.xyz
   git clone https://github.com/yourusername/nahianether_github_io.git .
   ```

3. **Install Flutter on VPS (if not already installed):**
   ```bash
   # Download Flutter
   cd /opt
   sudo wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz
   sudo tar xf flutter_linux_3.24.3-stable.tar.xz
   sudo chown -R $USER:$USER /opt/flutter
   
   # Add to PATH
   echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
   source ~/.bashrc
   
   # Verify installation
   flutter --version
   ```

4. **Make deployment script executable:**
   ```bash
   chmod +x deploy.sh
   ```

### Step 2: Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions → New repository secret

Add these secrets:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `VPS_HOST` | `intishar.xyz` | Your VPS domain/IP |
| `VPS_USERNAME` | `your-username` | SSH username |
| `VPS_SSH_KEY` | `-----BEGIN PRIVATE KEY-----...` | Your SSH private key |
| `VPS_PORT` | `22` | SSH port (usually 22) |

### Step 3: Generate SSH Key (if needed)

If you don't have an SSH key:

**On your local machine:**
```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

**Copy public key to VPS:**
```bash
ssh-copy-id your-username@intishar.xyz
```

**Copy private key content for GitHub secret:**
```bash
cat ~/.ssh/id_rsa
```

### Step 4: Configure Nginx (if using Nginx)

**Edit nginx config:**
```bash
sudo nano /etc/nginx/sites-available/intishar.xyz
```

**Example nginx config:**
```nginx
server {
    listen 80;
    server_name intishar.xyz www.intishar.xyz;
    
    root /var/www/html;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Enable gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;
}
```

**Enable site and restart nginx:**
```bash
sudo ln -s /etc/nginx/sites-available/intishar.xyz /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### Step 5: Test Deployment

1. **Manual test on VPS:**
   ```bash
   cd /var/www/intishar.xyz
   ./deploy.sh
   ```

2. **Push to GitHub to trigger auto-deployment:**
   ```bash
   git add .
   git commit -m "test: trigger deployment"
   git push origin master
   ```

3. **Check GitHub Actions:**
   - Go to your repository → Actions tab
   - Watch the deployment workflow run
   - Check for any errors in the logs

## 🎯 How It Works

### Automatic Deployment Process:

1. **Trigger:** Push to `master` branch
2. **GitHub Actions runs:**
   - Checks out code
   - Sets up Flutter
   - Installs dependencies
   - Runs tests
   - Builds web app
   - Connects to VPS via SSH
   - Runs deployment script

3. **VPS Deployment Script:**
   - Creates backup of current site
   - Pulls latest changes
   - Builds Flutter web app
   - Copies files to web server
   - Sets proper permissions
   - Reloads nginx
   - Cleans up old backups

### 🔍 Troubleshooting

**Common Issues:**

1. **SSH Connection Failed:**
   - Check VPS_HOST, VPS_USERNAME, VPS_PORT secrets
   - Verify SSH key is correct
   - Ensure SSH service is running on VPS

2. **Flutter Build Failed:**
   - Check Flutter version compatibility
   - Verify all dependencies are installed
   - Check build logs for specific errors

3. **Permission Denied:**
   - Ensure user has sudo privileges
   - Check file permissions on web directory
   - Verify nginx user (www-data) has access

4. **Deployment Script Failed:**
   - Check script permissions: `chmod +x deploy.sh`
   - Verify paths in script match your setup
   - Check nginx config syntax: `sudo nginx -t`

**View Logs:**
```bash
# Nginx logs
sudo tail -f /var/log/nginx/error.log

# System logs
sudo journalctl -u nginx -f
```

## 🛡️ Security Best Practices

1. **Use SSH keys instead of passwords**
2. **Limit SSH access by IP if possible**
3. **Keep VPS system updated**
4. **Use HTTPS with SSL certificates**
5. **Regular backups (automated in deployment script)**

## 📞 Support

If you encounter any issues:
1. Check GitHub Actions logs
2. SSH into VPS and check logs
3. Review nginx configuration
4. Verify all secrets are correctly set

---

**🎉 Once set up, every push to master will automatically deploy your portfolio to intishar.xyz!**