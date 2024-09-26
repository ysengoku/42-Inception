COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
	@docker compose -f $(COMPOSE_FILE) up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) down

start:
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

clean:	down

fclean: clean

re: fclean all

.PHONY: all up down start stop clean fclean re
