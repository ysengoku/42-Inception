COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
	@mkdir -p $(HOME)/data
	@mkdir -p $(HOME)/data/mariadb
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/website
	@mkdir -p $(HOME)/data/fail2ban
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
	@sudo rm -rf $(HOME)/data/mariadb
	@sudo rm -rf $(HOME)/data/wordpress
	@sudo rm -rf $(HOME)/data/website
	@sudo rm -rf $(HOME)/data/fail2ban

re: fclean all

.PHONY: all up down start stop clean fclean re
