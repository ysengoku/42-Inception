COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
	@mkdir -p $(HOME)/$(USER)/data/db
	@mkdir -p $(HOME)/data/wordpress
	@docker compose -f $(COMPOSE_FILE) up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) down --rmi all -v --remove-orphans

start:
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

clean:	down
	@docker system prune -f -a --volumes

fclean: clean
	@rm -rf $(HOME)/$(USER)/data/db
	@rm -rf $(HOME)/data/wordpress

re: fclean all

.PHONY: all up down start stop clean fclean re
