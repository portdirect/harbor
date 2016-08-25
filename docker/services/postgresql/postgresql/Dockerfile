FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="postgresql" \
    HARBOR_ETCD_COMPONENT="server" \
    LANG="en_US.utf8" \
    PGDATA="/var/lib/postgresql/data"

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk add --no-cache --virtual run-deps \
            "postgresql@edge<9.6" \
            "postgresql-contrib@edge<9.6" && \
    cp -rf /opt/harbor/assets/* /