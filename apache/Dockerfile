FROM rhscl/httpd-24-rhel7

USER root

ENV WEBDAV_PATH=/var/www/html

COPY 90-webdav.conf /etc/httpd/conf.d

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY fix-permissions.sh /usr/local/bin/fix-permissions.sh

RUN rm /etc/httpd/conf.d/welcome.conf && \
    chmod 755 /usr/local/bin/entrypoint.sh && \
    chmod 755 /usr/local/bin/fix-permissions.sh && \
    mkdir -p /secrets && \
    touch /secrets/htpasswd && \
    fix-permissions.sh /secrets && \
    fix-permissions.sh $WEBDAV_PATH

USER 1001

EXPOSE 8000/tcp 8080/tcp 8443/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/run-httpd"]
