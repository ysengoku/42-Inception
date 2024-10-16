COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
	@mkdir -p -m 775 $(HOME)/data
	@mkdir -p -m 775 $(HOME)/data/mariadb
	@mkdir -p -m 775 $(HOME)/data/wordpress
	@docker compose -f $(COMPOSE_FILE) -p inception up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) -p inception down --rmi all -v --remove-orphans

start:
	@docker compose -f $(COMPOSE_FILE) -p inception start

stop:
	@docker compose -f $(COMPOSE_FILE) -p inception stop

config:
	@docker compose -f $(COMPOSE_FILE) -p inception config

clean:	down
	@docker system prune -f -a --volumes

fclean: clean
	@rm -rf $(HOME)/data/mariadb
	@rm -rf $(HOME)/data/wordpress

re: fclean all

.PHONY: all up down start stop clean fclean re
