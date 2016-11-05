REVISION=`git rev-parse HEAD`

.PHONY: image up_db up_app setup_db volumes networks import_default-files

image:
	docker build --tag aldea-application --build-arg REVISION=$(REVISION) .

up_db:
	docker-compose up -d aldea-database

up_app:
	docker-compose up -d aldea-application

setup_db:
	docker-compose run --rm aldea-application bundle exec rails db:setup

volumes:
	@docker volume create --name neeco_aldea || true
	@docker volume create --name neeco_public || true

networks:
	@docker network create neeco_aldea || true
	@docker network create neeco_aldea-cuenta || true

import_default-files: volumes
	docker run --rm -i -v neeco_public:/work aldea-application ash -c "cd /app/uploads/ && cp -r --parents images/events/default.png /work/"
