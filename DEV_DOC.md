# 🛠 Developer Documentation - Inception

This documentation is intended for developers who want to set up, modify, or maintain the Inception infrastructure.

---

## 1. Environment Setup

### Prerequisites
Before starting, ensure your development environment (Virtual Machine or Linux host) has the following installed:
* **Docker Engine** (v20.10+)
* **Docker Compose** (v2.0+)
* **GNU Make**
* **OpenSSL** (for generating local certificates)

### Configuration Files & Secrets
The project relies on environment variables for security and portability. You must create a `.env` file in the `srcs/` directory.

**Example `.env` structure:**
```env
# Database Settings
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=wp_user_password

# WordPress Settings
DOMAIN_NAME=intra.42.fr
WP_ADMIN_USER=admin_login
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@42.fr

WP_USER=author_user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=author@42.fr
```
Note: The .env file is ignored by Git to prevent leaking secrets.

## 2. Build and Launch
The infrastructure is orchestrated using a Makefile that wraps Docker Compose commands for a consistent workflow.

### Initial Build
To build custom images from Dockerfiles and launch the services:
```bash
make
```
This command creates necessary host directories, builds images based on Debian Bookworm, and starts containers in detached mode.

### Rebuilding Services
If you modify a Dockerfile or a configuration file (like nginx.conf), use:

```Bash
make re
```

## 3. Container & Volume Management
Developers can use the following commands to manage the stack:

**View active containers:**
```bash
docker ps
```
**View resource usage (CPU/Memory)**
```bash
docker stats
```
**Stop services**
```bash
make stop
```
**Clean containers and networks**
```bash
make clean
```
**Full reset (Removes containers, images, and volumes)**
```bash
make fclean
```
**Enter a container's shell for debugging**
```bash
docker exec -it <container_name> sh
```

## 4. Data Persistence & Storage
To comply with the requirement of data persistence, the project uses Docker Volumes mapped to specific paths on the host system.

Storage Locations
By default, the project is configured to store persistent data at:

* MariaDB Data: /home/ealshorm/data/mariadb
* WordPress Files: /home/ealshorm/data/wordpress

How it Persists
1- The Makefile ensures these directories exist on the host before launching containers.
2- In docker-compose.yml, these host paths are mounted as volumes.
3- Even if containers are deleted (make clean), the data remains in these folders.
4- To completely wipe the data, you must run make fclean which targets the removal of these specific host directories.


## 5. Network Architecture
The services communicate over a custom bridge network named inception.

* Isolation: Only the Nginx service is exposed to the host's ports (443).

* Service Discovery: WordPress connects to MariaDB using the service name mariadb as the hostname.
