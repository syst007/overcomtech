# OvercomTech - Business Website

## Deploy on Ubuntu Server (from scratch)

### Prerequisites

- Ubuntu server (22.04 or 24.04) with SSH access
- Root or sudo access
- Domain name (optional, for production)

### Step 1 — Connect to the server

```bash
ssh user@your-server-ip
```

### Step 2 — Update system packages

```bash
sudo apt update && sudo apt upgrade -y
```

### Step 3 — Install Nginx web server

```bash
sudo apt install nginx -y
```

Start and enable Nginx to run on boot:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

Allow HTTP/HTTPS traffic through the firewall:

```bash
sudo ufw allow 'Nginx Full'
sudo ufw enable
```

Verify Nginx is running:

```bash
sudo systemctl status nginx
```

Your server IP should now show the Nginx welcome page in the browser.

### Step 4 — Upload the website files

On your local machine, copy the files to the server:

```bash
scp -r /path/to/overcomtech/* user@your-server-ip:/tmp/overcomtech/
```

Or if you have Git on the server:

```bash
# On the server
sudo apt install git -y
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git /tmp/overcomtech
```

### Step 5 — Move files to the web root

```bash
sudo rm -rf /var/www/html
sudo mv /tmp/overcomtech /var/www/html
```

Set correct permissions:

```bash
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

### Step 6 — Configure Nginx site

Create the Nginx config file:

```bash
sudo nano /etc/nginx/sites-available/overcomtech
```

Paste this configuration:

```nginx
server {
    listen 80;
    listen [::]:80;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Enable the site:

```bash
sudo ln -sf /etc/nginx/sites-available/overcomtech /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

### Step 7 — (Optional) Set up a domain name with SSL

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

Follow the prompts. Certbot will auto-configure HTTPS and set up auto-renewal.

### Step 8 — Verify

Visit `http://your-server-ip` (or your domain) in a browser. The OvercomTech website should be live.

### Useful commands

```bash
# View Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Restart Nginx
sudo systemctl restart nginx

# Check Nginx status
sudo systemctl status nginx
```

## Project Structure

```
/var/www/html/
├── index.html
├── about.html
├── services.html
├── contact.html
├── css/
│   └── style.css
├── js/
│   └── script.js
└── images/
```

## Web Link
https://syst007-appsocial.hf.space
