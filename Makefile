COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
	@mkdir -p $(HOME)/data/db
	@mkdir -p $(HOME)/data/wordpress
	@docker compose -f $(COMPOSE_FILE) -p inception up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) -p inception down --rmi all -v --remove-orphans

start:
	@docker compose -f $(COMPOSE_FILE) -p inception start

stop:
	@docker compose -f $(COMPOSE_FILE) -p inception stop

clean:	down
	@docker system prune -f -a --volumes

fclean: clean
	@sudo rm -rf $(HOME)/data/db
	@sudo rm -rf $(HOME)/data/wordpress

re: fclean all

.PHONY: all up down start stop clean fclean re
