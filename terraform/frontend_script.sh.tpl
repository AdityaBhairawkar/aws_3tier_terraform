#!/bin/bash
# Update system and install dependencies
sudo apt update -y
sudo apt install -y nginx git

# Navigate to Nginx root directory
cd /var/www/html

# Remove default files
sudo rm -rf *

# Clone frontend code
git clone https://github.com/AdityaBhairawkar/Todo

# Copy frontend files to root
sudo cp -r Todo/frontend/* ./

# Inject backend IP dynamically
sudo sh -c "echo \"const API_URL='http://${backend_ip}:5000/api/todos';\" > /var/www/html/config.js"



# Restart Nginx
sudo systemctl restart nginx

# Fix permissions
chown -R www-data:www-data /var/www/html
