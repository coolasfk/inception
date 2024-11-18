all:
	docker-compose up --build -d

clean:
	docker-compose down
	docker system prune -af

fclean: clean
	docker volume rm mariadb-data wordpress-data

re: fclean all