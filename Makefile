# Makefile - Docker for PHP
#
# [1] Builds locally and for the DSCR

.PHONY:

REGISTRY=gcr.io/darksociety-containers

apache:
	@docker build --tag=$(REGISTRY)/php:7.2-apache ./image/php/7.2/apache
	@docker build --tag=$(REGISTRY)/php:7.3-apache ./image/php/7.3/apache
