# Inception

A comprehensive Docker-based infrastructure project that orchestrates multiple services to create a fully functional web application environment using WordPress, MariaDB, Nginx, and various bonus services.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Services](#services)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Technical Specifications](#technical-specifications)
- [Security](#security)
- [Troubleshooting](#troubleshooting)

## Overview

Inception is a system administration and DevOps project that sets up a complete web infrastructure using Docker containers. Each service runs in a dedicated container, built from custom Dockerfiles, ensuring isolation, scalability, and maintainability.

### Key Features

- **Containerized Architecture**: Each service runs in its own isolated Docker container
- **Custom Docker Images**: All images built from scratch (Alpine or Debian base)
- **Secure Communications**: TLS/SSL encrypted connections via Nginx
- **Data Persistence**: Volume mounting for database and WordPress files
- **Advanced Caching**: Redis integration for improved performance
- **Database Management**: Adminer interface for easy database administration
- **File Transfer**: FTP server for remote file management
- **Bonus Services**: Django application and static site hosting

## Architecture

The infrastructure follows a multi-tier architecture:

```
┌─────────────────────────────────────────────────────────┐
│                     Docker Host                          │
│                                                          │
│  ┌────────────┐  ┌──────────┐  ┌────────────┐         │
│  │   Nginx    │  │  Django  │  │ Static Site│         │
│  │  (HTTPS)   │  │  :3000   │  │   :8000    │         │
│  └─────┬──────┘  └──────────┘  └────────────┘         │
│        │                                                │
│  ┌─────▼──────┐  ┌──────────┐  ┌────────────┐         │
│  │ WordPress  │──│  Redis   │  │  Adminer   │         │
│  │   :9000    │  │  Cache   │  │    :80     │         │
│  └─────┬──────┘  └──────────┘  └──────┬─────┘         │
│        │                               │                │
│  ┌─────▼─────────────────────────────▼─────┐          │
│  │            MariaDB :3306                 │          │
│  └──────────────────────────────────────────┘          │
│                                                          │
│  ┌──────────────────────────────────────────┐          │
│  │         FTP Server :21                    │          │
│  │   (WordPress Files Access)                │          │
│  └──────────────────────────────────────────┘          │
│                                                          │
│       Network: inception (Bridge Driver)                │
└─────────────────────────────────────────────────────────┘
```

## Services

### Core Services

#### 🔹 Nginx
- **Port**: 443 (HTTPS)
- **Role**: Reverse proxy and web server
- **Features**: 
  - TLSv1.2/TLSv1.3 encryption
  - Serves WordPress content
  - SSL certificate configuration
  - FastCGI integration with PHP-FPM

#### 🔹 WordPress
- **Port**: 9000 (internal)
- **Role**: Content management system
- **Features**:
  - PHP-FPM 7.4/8.x
  - WP-CLI integration
  - Redis object caching
  - Automatic installation and configuration
  - User management

#### 🔹 MariaDB
- **Port**: 3306 (internal)
- **Role**: Relational database
- **Features**:
  - MySQL-compatible database engine
  - Persistent data storage
  - Optimized configuration
  - Secure authentication

### Bonus Services

#### 🔸 Redis
- **Role**: In-memory caching system
- **Features**:
  - WordPress object caching
  - Performance optimization
  - Session management

#### 🔸 FTP Server
- **Port**: 21
- **Role**: File transfer protocol server
- **Features**:
  - vsftpd implementation
  - Access to WordPress files
  - Secure file management

#### 🔸 Adminer
- **Port**: 80
- **Role**: Database management interface
- **Features**:
  - Web-based database administration
  - MariaDB connection
  - SQL query execution
  - Database visualization

#### 🔸 Django
- **Port**: 3000
- **Role**: Python web framework application
- **Features**:
  - Custom Django application
  - Independent Python environment

#### 🔸 Static Site
- **Port**: 8000
- **Role**: Static website hosting
- **Features**:
  - Lightweight HTTP server
  - HTML/CSS/JS content
  - High-performance static content delivery

## Prerequisites

### System Requirements

- **OS**: Linux (Debian/Ubuntu recommended) or macOS
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: Minimum 10GB free space
- **Processor**: 64-bit dual-core or better

### Software Requirements

- Docker Engine (version 20.10 or later)
- Docker Compose (version 1.29 or later)
- Make
- sudo privileges

### Installation of Prerequisites

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add user to docker group (optional, to run without sudo)
sudo usermod -aG docker $USER
```

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Inception
```

### 2. Configure Environment Variables

Create a `.env` file in the `srcs/` directory:

```bash
cp srcs/.env.example srcs/.env
nano srcs/.env
```

Required environment variables:

```env
# Domain Configuration
DOMAIN_NAME=your-domain.com

# MariaDB Configuration
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=your_mysql_password

# WordPress Configuration
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_TITLE=My WordPress Site
WP_URL=https://your-domain.com

WP_USER=editor
WP_USER_PASSWORD=editor_password
WP_USER_EMAIL=editor@example.com

# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379

# FTP Configuration
FTP_USER=ftpuser
FTP_PASSWORD=ftp_password
```

### 3. Create Data Directories

```bash
sudo mkdir -p /home/kmahdi/data/wordpress
sudo mkdir -p /home/kmahdi/data/mariadb
sudo chown -R $USER:$USER /home/kmahdi/data
```

### 4. Configure Hosts File (Optional for Local Testing)

```bash
sudo nano /etc/hosts
```

Add:
```
127.0.0.1    your-domain.com
```

## Usage

### Starting the Infrastructure

```bash
# Build and start all services
make up

# Or using docker-compose directly
docker-compose -f srcs/docker-compose.yml up --build
```

### Stopping the Infrastructure

```bash
# Stop all services
make down

# Clean up (stop containers & remove volumes)
make clean

# Full cleanup (remove everything including images)
make fclean
```

### Available Make Commands

| Command | Description |
|---------|-------------|
| `make up` | Build and start all containers |
| `make down` | Stop all containers |
| `make rmove_volumes` | Remove volumes and delete data |
| `make remove_images` | Remove all Docker images |
| `make clean` | Stop containers, remove volumes and images |
| `make fclean` | Complete cleanup including system prune |

### Accessing Services

Once running, access the services at:

- **WordPress**: `https://your-domain.com` or `https://localhost`
- **Adminer**: `http://localhost:80` or `http://your-domain.com:80`
- **Django App**: `http://localhost:3000`
- **Static Site**: `http://localhost:8000`
- **FTP Server**: `ftp://localhost:21`

### Managing WordPress

```bash
# Access WordPress container
docker exec -it wordpress bash

# Use WP-CLI
wp --info
wp plugin list
wp theme list
wp user list
```

### Database Management

Access Adminer at `http://localhost:80`:
- **System**: MySQL
- **Server**: mariadb
- **Username**: As configured in .env
- **Password**: As configured in .env
- **Database**: wordpress

## Project Structure

```
Inception/
├── Makefile                          # Build automation
├── README.md                         # Project documentation
└── srcs/
    ├── .env                          # Environment variables (create this)
    ├── .gitignore                    # Git ignore rules
    ├── docker-compose.yml            # Container orchestration
    └── requirements/
        ├── mariadb/                  # MariaDB service
        │   ├── Dockerfile
        │   ├── conf/
        │   │   └── 50-server.cnf     # MariaDB configuration
        │   └── tools/
        │       └── script.sh         # Setup script
        ├── nginx/                    # Nginx service
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf        # Nginx configuration
        ├── wordpress/                # WordPress service
        │   ├── Dockerfile
        │   ├── conf/
        │   │   └── www.conf          # PHP-FPM configuration
        │   └── tools/
        │       └── script.sh         # Setup script
        └── bonus/                    # Bonus services
            ├── adminer/              # Database admin interface
            ├── django/               # Django application
            ├── ftp/                  # FTP server
            ├── redis/                # Cache server
            └── static_site/          # Static website
```

## Technical Specifications

### Docker Configuration

- **Compose Version**: 3.8
- **Network**: Bridge driver (isolated network)
- **Volumes**: 
  - Named volumes with bind mounts
  - Persistent storage for MariaDB and WordPress
- **Restart Policies**: 
  - `unless-stopped` for critical services
  - `on-failure` for dependent services

### Base Images

All services use official base images:
- **Alpine Linux**: Lightweight containers (nginx, redis, ftp)
- **Debian**: Full-featured containers (wordpress, mariadb)

### Networking

- Internal communication via Docker network `inception`
- Only necessary ports exposed to host
- Service discovery by container name
- No `network_mode: host` or `--link` usage

### Volumes and Persistence

```yaml
Volumes:
- /home/kmahdi/data/wordpress -> WordPress files
- /home/kmahdi/data/mariadb -> Database files
```

Both volumes use bind mounts for direct access and backup capabilities.

## Security

### Implemented Security Measures

1. **SSL/TLS Encryption**: All HTTP traffic through Nginx uses HTTPS
2. **Environment Variables**: Sensitive data stored in .env file (not in version control)
3. **Network Isolation**: Services communicate through private Docker network
4. **Port Restrictions**: Only necessary ports exposed to host
5. **User Permissions**: Non-root users in containers where possible
6. **Password Protection**: Strong passwords required for all services

### Security Best Practices

- Never commit `.env` file to version control
- Use strong, unique passwords for all services
- Regularly update base images and dependencies
- Keep Docker and Docker Compose updated
- Monitor container logs for suspicious activity
- Implement firewall rules on production hosts

```bash
# View logs for security monitoring
docker-compose -f srcs/docker-compose.yml logs -f
```

## Troubleshooting

### Common Issues

#### 1. Port Already in Use

```bash
# Check what's using the port
sudo lsof -i :443
sudo lsof -i :80

# Stop the conflicting service
sudo systemctl stop apache2  # Example for Apache
```

#### 2. Permission Denied on Volumes

```bash
# Fix permissions
sudo chown -R $USER:$USER /home/kmahdi/data
sudo chmod -R 755 /home/kmahdi/data
```

#### 3. Database Connection Issues

```bash
# Check MariaDB logs
docker logs mariadb

# Restart MariaDB
docker restart mariadb

# Verify environment variables
docker exec mariadb env | grep MYSQL
```

#### 4. WordPress Not Loading

```bash
# Check WordPress logs
docker logs wordpress

# Verify WordPress files
docker exec wordpress ls -la /var/www/html

# Check Nginx configuration
docker exec nginx nginx -t
```

#### 5. Container Won't Start

```bash
# View container logs
docker logs <container-name>

# Rebuild specific service
docker-compose -f srcs/docker-compose.yml build --no-cache <service-name>
docker-compose -f srcs/docker-compose.yml up <service-name>
```

### Debugging Commands

```bash
# Check all containers status
docker ps -a

# View logs for all services
docker-compose -f srcs/docker-compose.yml logs

# View logs for specific service
docker-compose -f srcs/docker-compose.yml logs <service-name>

# Access container shell
docker exec -it <container-name> sh
# or
docker exec -it <container-name> bash

# Inspect network
docker network inspect inception

# Check volumes
docker volume ls
docker volume inspect srcs_wordpress
docker volume inspect srcs_mariadb
```

### Clean Restart

If experiencing persistent issues:

```bash
# Complete cleanup
make fclean

# Remove all Docker data (CAUTION: removes all Docker data)
docker system prune -a --volumes

# Recreate data directories
sudo mkdir -p /home/kmahdi/data/{wordpress,mariadb}
sudo chown -R $USER:$USER /home/kmahdi/data

# Start fresh
make up
```

## Performance Optimization

### Redis Caching

WordPress is configured to use Redis for object caching, which significantly improves performance:

- Page load times reduced by 50-80%
- Database query reduction
- Improved scalability

### MariaDB Tuning

The MariaDB configuration includes optimizations for:
- Buffer pool size
- Query cache
- Connection handling
- InnoDB settings

### Nginx Optimization

Nginx is configured with:
- FastCGI caching
- Gzip compression
- HTTP/2 support
- Static file caching

## Backup and Recovery

### Manual Backup

```bash
# Backup WordPress files
sudo tar -czf wordpress-backup-$(date +%Y%m%d).tar.gz /home/kmahdi/data/wordpress/

# Backup MariaDB database
docker exec mariadb mysqldump -u root -p$MYSQL_ROOT_PASSWORD --all-databases > mariadb-backup-$(date +%Y%m%d).sql
```

### Restore from Backup

```bash
# Restore WordPress files
sudo tar -xzf wordpress-backup-YYYYMMDD.tar.gz -C /home/kmahdi/data/

# Restore MariaDB database
cat mariadb-backup-YYYYMMDD.sql | docker exec -i mariadb mysql -u root -p$MYSQL_ROOT_PASSWORD
```

## Contributing

To extend or modify this infrastructure:

1. Follow Docker best practices
2. Maintain container isolation
3. Document all changes
4. Test thoroughly before deployment
5. Update this README accordingly

## License

This project is part of the 42 Network curriculum.

## Acknowledgments

Built as part of the **Inception** project at 42 School, focusing on system administration, Docker containerization, and DevOps practices.

---

**Note**: This infrastructure is designed for development and learning purposes. For production deployment, additional hardening, monitoring, and backup solutions should be implemented.
