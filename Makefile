REVISION=`git rev-parse HEAD`

.PHONY: image db app migrate volumes networks import_default-files

image:
	docker build --tag aldea-application --build-arg REVISION=$(REVISION) .

db:
	docker-compose up -d aldea-database

app:
	docker-compose run -p 3000:3000 aldea-application ash

migrate:
	docker-compose run --rm aldea-application bundle exec rails db:migrate

volumes:
	@docker volume create --name neeco_aldea || true
	@docker volume create --name neeco_public || true

networks:
	@docker network create neeco_aldea || true
	@docker network create neeco_aldea-cuenta || true

import_default-files: volumes
	docker run --rm -i -v neeco_public:/work aldea-application ash -c "cd /app/uploads/ && cp -r --parents images/events/default.png /work/"
