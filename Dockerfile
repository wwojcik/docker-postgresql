FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

RUN apk --update add \
    postgresql \
    postgresql-contrib \
    openssl \
    sudo \
    wget \
    bash \
	&& wget -O /usr/local/bin/gosu --no-check-certificate "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" \
	&& chmod +x /usr/local/bin/gosu \
	&& rm -rf /var/cache/apk/*

ENV LANG en_US.utf8

RUN mkdir /docker-entrypoint-initdb.d

ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.4

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /var/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
