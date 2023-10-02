PHP Images for the DSCR
=======================

### Description

Base images for PHP versions 7 and 8 configured to work with as a boilerplate, deployed to the GCR.

> I had a `date()` with PHP and had to `mktime()` for it.


## TL;DR

```sh
$ docker run --name php [image]
```


## Facts

 * Version 0.2.3
 * [Repository on GitHub](https://github.com/thedarksociety/docker-php)


Getting Started
---------------

The more and more I develop locally, the more and more I find myself needing custom containers. Not to mention
it helps to learn the options of this service. Enter `docker-php` a project to rapidly configure my PHP environments
and make mistakes doing it.


### Requirements

 * [Git](https://git-scm.org)
 * [Docker](http://docker.io)


### Supported Versions

 * [`7.2`, (Dockerfile)](link)
 * [`7.3`, (Dockerfile)](link)
 * [`7.4`, (Dockerfile)](link)
 * [`8.0`, (Dockerfile)](link)
 * [`8.1`, (Dockerfile)](link)
 * [`8.2`, (Dockerfile)](link)


Usage
-----

### Features

  * Timezone
  * PHP Extension Installer
  * Composer


#### Timezone

Whether it has been due to copypasta or forgotten settings in previous ENV setups continuing 
through to final builds, whatever it is, timezones should be explicitly set for Denver.

[The solution](https://stackoverflow.com/questions/45587214/configure-timezone-in-dockerized-nginx-php-fpm?noredirect=1&lq=1).


#### PHP Extension Installer

This installer helps to decrease image size, by removing unneeded packages. It is installed
locally to the image, so running `docker pull mlocati/php-extension-installer` updates any 
versions of the libraries that may have been updated since the last pull.

[The solution](https://github.com/mlocati/docker-php-extension-installer)


### Pulling the Image

```sh
$ docker pull gcr.io/darksociety-containers/php:7.2-apache
```


### Environment

| Package | Description |
| ------- | ----------- |
| git | Git is used for pulling down libs and services, this is across all my projects. |
| zip | For obvious reasons.|


### Scripts

| Script | Description |
| ------- | ----------- |
| docker-entrypoint.sh | Configuration and initiation for the container. |
| docker-healthcheck.sh |Confirm the container is running and in a health state.|


Developers
---------

**Rye Miller**
 * [Github](https://github.com/iods)
 * [Homepage](http://ryemiller.io)
 * [@ryemiller](http://twitter.com/ryemiller)

**Tiffany Creamer**
 * [Github](https://github.com/tnondairy)


Changelog
---------

### [2021-21-1]
  * Merge of iods/docker-php and thedarksociety/docker-php repos

### [2020-11-27]
  * Addition of PHP Docker Repository


Known Issues
------------

Any known issues can be viewed or added on [GitHub](https://github.com/thedarksociety/docker-php/issues).


Versioning
----------

For transparency into the release cycle and in striving to maintain backwards compatibility, this project is
maintained under [the Semantic Versioning Guidelines](http://semver.og).


License
-------

This project/code is released under [the MIT license](https://github.com/thedarksociety/docker-php/LICENSE)


Copyright
---------

Copyright (c) 2020-2021, Rye Miller
