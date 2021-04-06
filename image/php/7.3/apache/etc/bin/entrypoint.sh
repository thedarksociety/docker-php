#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value


# apache complains about an unclean shutdown, this fixes it
rm -rf /var/run/apache2/apache2.pid

# source the environment vars and init apache
source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND



