.PHONY: db app network

db:
	docker-compose up -d aldea-database

app:
	docker-compose run -p 3000:3000 aldea-application ash

network:
	@docker network create neeco_develop || true

