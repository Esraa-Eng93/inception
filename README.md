# Inception - System Administration with Docker

*This project has been created as part of the 42 curriculum by [ealshorm].

##  Description
The **Inception** project is a fundamental step in learning system administration through virtualization. The goal is to build a small-scale, high-availability infrastructure using **Docker**. Unlike simply pulling ready-made images, this project requires building custom Docker images from a **Debian Bookworm** base. 

The infrastructure consists of:
- **Nginx**: A web server acting as a secure entry point via TLS.
- **WordPress**: A CMS powered by PHP-FPM.
- **MariaDB**: A relational database for data persistence.

All services are interconnected via a private Docker network and utilize Docker volumes to ensure data remains intact even after container restarts.

---

##  Project Design & Technical Choices

### Virtual Machines vs Docker

- **Virtual Machines (VM):** I used a VM (VirtualBox with Debian) as the host environment. VMs virtualize hardware and run a full Guest OS, providing high isolation but at the cost of high resource consumption.
- **Docker:** Inside the VM, I used Docker to virtualize the application layer. Containers share the host kernel, making them lightweight, fast to start, and highly portable.

### Secrets vs Environment Variables
- **Environment Variables:** Used for non-sensitive configurations. However, they can be exposed via `docker inspect`.
- **Secrets:** In this project, we use a `.env` file to manage sensitive data like `MYSQL_PASSWORD`. While standard environment variables are used here for simplicity, they are kept out of Git history for security.

### Docker Network vs Host Network
- **Host Network:** Containers share the host's IP address directly, which reduces isolation.
- **Docker Network (Bridge):** I created a dedicated internal network. This allows containers to communicate using their service names (e.g., `wordpress:9000`) while remaining invisible to the outside world, except for Nginx.

### Docker Volumes vs Bind Mounts
- **Bind Mounts:** Depend on the specific file structure of the host machine.
- **Docker Volumes:** I chose **Volumes** as they are managed entirely by Docker. They offer better performance, are easier to back up, and ensure that WordPress files and Database entries persist in `/home/ealshorm/data` regardless of the container lifecycle.

---

## Instructions

### 1. Installation & Setup
First, clone the repository from the 42 Intra and navigate to the project folder:
```bash
git clone <My_intra_git_link> inception && cd inception

### Execution
From the root of the project, use the provided **Makefile**:

- **make** : Builds the images and starts the infrastructure in detached mode.
- **make stop** : Stops all running containers.
- **make clean** : Stops and removes containers and the custom network.
- **make fclean** : Full cleanup (Removes containers, images, and **volumes**).
- **make re** : Rebuilds the entire project from scratch.

### Access
Open your browser and navigate to: [https://ealshorm.42.fr](https://ealshorm.42.fr)  


---

##  Resources

### Documentation & References
- **Docker Engine:** [Official Docker Docs](https://docs.docker.com/)
- **Nginx Configuration:** [Nginx Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html)
- **MariaDB:** [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
- **PHP-FPM:** [PHP-FPM official documentation](https://www.php.net/manual/en/install.fpm.php)

###  AI Usage Disclosure
In compliance with 42 curriculum requirements, I utilized AI as a technical thought partner for the following tasks:

- **Debugging:** Identifying the root cause of the **502 Bad Gateway** error and fixing PHP-FPM connection issues.
- **Technical Comparisons:** Structuring the conceptual differences between Docker and VMs, and Volumes vs Bind Mounts for academic clarity.
- **Documentation:** Organizing this README to ensure it meets all the specific technical requirements of the project.

---
