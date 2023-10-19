#!/bin/bash
set -e

echo "Setting DAV based on ENV..."

WEBDAV_USER=${WEBDAV_USER:-coder}
WEBDAV_PASS=${WEBDAV_PASS:-$(openssl rand -base64 18)}
WEBDAV_PORT=${WEBDAV_PORT:-8080}
WEBDAV_CONF=${WEBDAV_CONF:-/etc/httpd/conf.d/90-webdav.conf}
WEBDAV_PATH=${WEBDAV_PATH:-/var/www/html}
  
echo "
You can modify modify the follow environment settings:

WEBDAV_USER: $WEBDAV_USER
WEBDAV_PASS: $WEBDAV_PASS
WEBDAV_PORT: $WEBDAV_PORT
WEBDAV_CONF: $WEBDAV_CONF
WEBDAV_PATH: $WEBDAV_PATH

"

# create .htaccess if it does not exist
if [ ! -e ${WEBDAV_PATH}/.htaccess ]; then

echo "Auto creating ${WEBDAV_PATH}/.htaccess"

echo "# This file is created automatically
# create an empty .htaccess to avoid this file being created automatically

# disable indexes
Options -Indexes

# require user logins
Require valid-user
" > ${WEBDAV_PATH}/.htaccess

fi

# set webdav path  
$(which sed) -i 's@/var/www/html@'"${WEBDAV_PATH}"'@g' ${WEBDAV_CONF}

# set webdav port
$(which sed) -i 's@^Listen.*@'"Listen 0.0.0.0:${WEBDAV_PORT}"'@g' /etc/httpd/conf/httpd.conf

# setup auth digest
# echo "$WEBDAV_USER:WEBDav:$(echo -n "$WEBDAV_USER:dav:$WEBDAV_PASS" | md5sum | cut -c1-32)" >  /secrets/htpasswd
# setup auth basic
$(which htpasswd) -Bb /secrets/htpasswd $WEBDAV_USER $WEBDAV_PASS

exec $@
