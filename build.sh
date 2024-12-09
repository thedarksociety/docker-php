#!/usr/bin/env bash

# Release script for Github Actions
# Version: 0.1 [2020-11-28]
#
# - Build and push Docker containers from a Github
#   repository on a release.
#
# Author: Dark Society <developers@darksociety.cloud>
# Copyright (c) 2021, The Dark Society

set -eo pipefail

export PROJECT_DIR=$HOME/Development/docker/docker-php/tests

# apache build
mkdir -p "${PROJECT_DIR}"/build/php/5.6
cp -r image/php/5.6 tests/build/php/5.6/apache
