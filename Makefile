
up:
	@docker-compose -f srcs/docker-compose.yml up --build

down:
	@docker-compose -f srcs/docker-compose.yml down

rmove_volumes:
	sudo chmod 777 /home/kmahdi/data/mariadb
	sudo chmod 777 /home/kmahdi/data/wordpress
	@sudo rm -rf /home/kmahdi/data/wordpress/*
	@sudo rm -rf /home/kmahdi/data/mariadb/*

remove_images:
	@docker-compose -f srcs/docker-compose.yml down --rmi all

clean: down rmove_volumes remove_images

fclean: rmove_volumes remove_images 
	@docker-compose -f srcs/docker-compose.yml down 
	@docker system prune --all

ps:
	@docker-compose -f srcs/docker-compose.yml ps

logs:
	@docker-compose -f srcs/docker-compose.yml logs
