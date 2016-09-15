REVISION=`git rev-parse HEAD`

build:
	docker build --no-cache --tag aldea-application --build-arg REVISION=$(REVISION) .
