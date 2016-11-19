REVISION=`git rev-parse HEAD`

.PHONY: image db app volumes networks import_default-files

image:
	docker build --tag aldea-application --build-arg REVISION=$(REVISION) .

db:
	docker-compose up -d aldea-database

app:
	docker-compose run -p 3000:3000 aldea-application ash

volumes:
	@docker volume create --name neeco_public || true

networks:
	@docker network create neeco_aldea-cuenta || true
