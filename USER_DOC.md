# 📖 User Documentation - Inception

This document provides essential information on how to manage, access, and monitor the Inception infrastructure.

---

## 1. Services Provided
The infrastructure (stack) provides a fully functional, containerized web environment consisting of:
* **Nginx**: A high-performance web server configured with TLS (SSL) to ensure secure connections.
* **WordPress**: The world's most popular Content Management System (CMS), pre-configured to run with PHP-FPM.
* **MariaDB**: A reliable relational database management system that stores all website content and user data.

---

## 2. Managing the Project (Start & Stop)
The project is managed using a `Makefile` for simplicity and automation. From the root of the repository, use the following commands:

* **To Start the Project:**
    ```bash
    make
    ```
    *This will build the images, create the network and volumes, and start the containers in the background.*

* **To Stop the Project:**
    ```bash
    make stop
    ```
    *This stops the running containers without removing them.*

* **To Remove Everything:**
    ```bash
    make fclean
    ```
    *This stops the services and deletes all containers, networks, and persistent data volumes.*

---

## 3. Accessing the Website
Once the stack is running, you can access the services through your web browser:

### 🌐 The Website
Navigate to: **`https://ealshorm.42.fr`** *(Note: You must use the `https://` protocol as the server is configured for SSL only.)*

### ⚙️ Administration Panel (WordPress Dashboard)
To manage the website content, themes, and plugins:
1.  Go to: **`https://ealshorm.42.fr/wp-admin`**
2.  Log in using the Administrator credentials (see Section 4).

---

## 4. Credentials Management
Security is a priority; therefore, no passwords are hardcoded in the source code. All credentials are managed through a hidden environment file.

* **Location:** `srcs/.env`
* **Contained Data:**
    * `MYSQL_ROOT_PASSWORD`: The master password for the database.
    * `MYSQL_USER` / `MYSQL_PASSWORD`: Credentials for the WordPress database connection.
    * `WP_ADMIN_USER` / `WP_ADMIN_PASSWORD`: Credentials for the WordPress Dashboard.
    * `WP_USER` / `WP_USER_PASSWORD`: Credentials for a secondary WordPress editor/user.

> **⚠️ Warning:** Never share the `.env` file or commit it to a public repository.

---

## 5. Checking Service Status
To ensure that all services are running correctly, you can perform the following checks:

### Container Status
Run the following command to see all active containers:
```bash
docker ps
```
Expected Result: You should see three containers (nginx, wordpress, mariadb).


### Health Check (Internal)
To ensure that Nginx is responding correctly and the SSL certificate is working from within the machine, use the following command:
```bash
curl -k https://localhost
```
### Logs
If a service is not behaving as expected, you can inspect the logs for specific errors using the following commands:

#### For Web Server issues:
```bash
docker logs nginx
```
#### For Website/PHP issues:
```bash
docker logs wordpress
```
#### For Database issues:
```bash
docker logs mariadb
```
