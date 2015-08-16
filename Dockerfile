FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV LANG=en_US.utf8 \
    PG_MAJOR=9.4 \
    PG_VERSION=9.4.4 \
    PATH=/var/lib/postgresql/$PG_MAJOR/bin:$PATH \
    PGDATA=/var/lib/postgresql/data \
    TIMEZONE=Europe/Warsaw


RUN apk --update add \
    postgresql \
    postgresql-contrib \
    openssl \
    sudo \
    wget \
    tzdata \
    bash && \
	wget -O /usr/local/bin/gosu --no-check-certificate "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && \
	chmod +x /usr/local/bin/gosu && \
    rm -rf /var/cache/apk/* && \
    mkdir /docker-entrypoint-initdb.d && \
    mkdir -p /var/run/postgresql && \
    chown -R postgres /var/run/postgresql && \
    cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo "$TIMEZONE" >  /etc/timezone


VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
