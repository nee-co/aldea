REVISION=`git rev-parse HEAD`

.PHONY: image dev-image up_db up_app setup_db volumes networks

image:
	docker build --no-cache --tag aldea-application --build-arg REVISION=$(REVISION) .

dev-image:
	docker build --tag aldea-application --build-arg REVISION=$(REVISION) .

up_db:
	docker-compose up -d aldea-database

up_app:
	docker-compose up -d aldea-application

setup_db:
	docker-compose run --rm aldea-application bundle exec rails db:setup

volumes:
	@docker volume create --name neeco_aldea || true

networks:
	@docker network create neeco_aldea || true
	@docker network create neeco_aldea-cuenta || true
