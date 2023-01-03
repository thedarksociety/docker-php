# Makefile - Docker for PHP
#
# [1] Builds locally and for the DSCR

.PHONY:

REGISTRY=gcr.io/darksociety-containers

apache:
	@docker build --tag=$(REGISTRY)/php:7.2-apache ./image/php/7.2/apache
	@docker build --tag=$(REGISTRY)/php:7.3-apache ./image/php/7.3/apache
	@docker build --tag=$(REGISTRY)/php:7.4-apache ./image/php/7.4/apache
	@docker build --tag=$(REGISTRY)/php:8.0-apache ./image/php/8.0/apache

cli:
	@docker build --tag=$(REGISTRY)/php:7.2-cli ./image/php/7.2/cli
	@docker build --tag=$(REGISTRY)/php:7.3-cli ./image/php/7.3/cli
	@docker build --tag=$(REGISTRY)/php:7.4-cli ./image/php/7.4/cli
	@docker build --tag=$(REGISTRY)/php:8.0-cli ./image/php/8.0/cli

fpm:
	@docker build --tag=$(REGISTRY)/php:7.2-cli ./image/php/7.2/cli
	@docker build --tag=$(REGISTRY)/php:7.3-cli ./image/php/7.3/cli
	@docker build --tag=$(REGISTRY)/php:7.4-cli ./image/php/7.4/cli
	@docker build --tag=$(REGISTRY)/php:8.0-cli ./image/php/8.0/cli

build: apache cli fpm

push:
	@docker push --all-tags $(REGISTRY)/php