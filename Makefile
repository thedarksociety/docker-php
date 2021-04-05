
.PHONY: build

REGISTRY=gcr.io/darksociety-containers/


up:
	@docker-compose up -d

build:
	@docker-compose build --no-cache --force-rm


stop:
	@docker-compose stop


down:
	@docker-compose down --remove-orphans


restart:
	@make down
	@make up


destroy:
	@docker-compose down --rmi all --volumes --remove-orphans
