.PHONY: db app networks

db:
	docker-compose up -d aldea-database

app:
	docker-compose run -p 3000:3000 aldea-application ash

networks:
	@docker network create neeco_aldea-cuenta || true
	@docker network create neeco_aldea-imagen || true
