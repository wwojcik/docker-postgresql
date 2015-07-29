FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV PG_VERSION=9.4 \
    PG_USER=postgres \
    PG_HOME="/var/lib/postgresql"


ENV PGDATA=${PG_HOME}/${PG_VERSION}/data
RUN apk --update add \
    postgresql \
    postgresql-contrib \
    openssl \
    sudo \
    && mkdir -p ${PGDATA} /var/run/postgresql\
    && chown -R postgres:postgres ${PG_HOME} /var/run/postgresql

EXPOSE 5432

USER postgres

RUN ["initdb"]

ADD config/postgresql.conf ${PGDATA}/postgresql.conf
ADD config/pg_hba.conf ${PGDATA}/pg_hba.conf
VOLUME ["/var/lib/postgresql/9.4/data"]
CMD /etc/init.d/postgresql start
#CMD /usr/bin/pg_ctl start -s -w -t 10 -l /var/lib/postgresql/9.4/data/postmaster.log -D /var/lib/postgresql/9.4/data

