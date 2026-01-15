NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/${USER}/data

all:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	docker-compose -f $(COMPOSE_FILE) down

clean: down
	docker system prune -a -f

fclean: clean
	sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all down clean fclean re