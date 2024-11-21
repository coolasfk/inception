all:
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down
	docker system prune -af || true

fclean: clean
	-docker volume rm mariadb-data wordpress-data nginx-data || true

re: fclean all
