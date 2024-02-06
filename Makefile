NAME = nginx

GREEN = \033[0;32m
RED = \033[0;31m
NC = \033[0m #

# > /dev/null 2>&1 || true

Build:
	@echo "$(GREEN)The image $(NAME) is building...$(NC)"
	@docker build -t $(NAME) srcs/requirements/nginx/
	@echo "$(GREEN)The image $(NAME) has been built.$(NC)"

Run:
	@echo "$(GREEN)The container $(NAME) is running...$(NC)"
	@docker run -it $(NAME)

Remove:
	@echo "$(RED)Removing the image $(NAME)...$(NC)"
	@docker rmi -f $(NAME) 
	@echo "$(GREEN)The image $(NAME) has been removed.$(NC)"
