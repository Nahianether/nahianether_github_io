#!/bin/bash

# Flutter Web Auto-Deployment Script
# This script should be run on your VPS

set -e  # Exit on any error

echo "🚀 Starting Flutter Web Deployment..."

# Configuration (adjust these paths according to your setup)
PROJECT_DIR="/var/www/intishar.xyz"
WEB_ROOT="/var/www/html"
BACKUP_DIR="/var/backups/website"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Backup current website
log "📦 Creating backup of current website..."
if [ -d "$WEB_ROOT" ]; then
    sudo tar -czf "$BACKUP_DIR/website-backup-$(date +%Y%m%d-%H%M%S).tar.gz" -C "$WEB_ROOT" .
    log "✅ Backup created successfully"
fi

# Navigate to project directory
log "📁 Navigating to project directory..."
cd $PROJECT_DIR

# Pull latest changes
log "🔄 Pulling latest changes from git..."
git pull origin master

# Install/Update Flutter dependencies
log "📦 Installing Flutter dependencies..."
flutter pub get

# Build Flutter web app
log "🔨 Building Flutter web app..."
flutter build web --release

# Copy build files to web server
log "📋 Copying build files to web server..."
sudo cp -r build/web/* $WEB_ROOT/

# Set proper permissions
log "🔐 Setting proper permissions..."
sudo chown -R www-data:www-data $WEB_ROOT/
sudo chmod -R 755 $WEB_ROOT/

# Restart/Reload nginx
log "🔄 Reloading nginx..."
sudo systemctl reload nginx

# Clean up old backups (keep last 5)
log "🧹 Cleaning up old backups..."
cd $BACKUP_DIR
ls -t website-backup-*.tar.gz | tail -n +6 | xargs -r rm

log "✅ Deployment completed successfully!"
log "🌐 Website should now be live at intishar.xyz"