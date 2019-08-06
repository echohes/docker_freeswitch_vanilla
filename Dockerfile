FROM debian:9.9-slim

LABEL maintainer="Vadim Gaisin, hes88@mail.ru"

RUN apt-get update \
    && apt-get install -y gnupg2 wget \
    && wget -O - https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && apt-get update \
    && apt-get install -y freeswitch-meta-vanilla \
    freeswitch-mod-translate \
    freeswitch-mod-xml-curl \
    freeswitch-mod-xml-rpc \
    freeswitch-mod-odbc-cdr \
    freeswitch-mod-shout \
    unixodbc \
    unixodbc-dev \
    odbc-postgresql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["freeswitch"]
#Parameters can be overridden
CMD ["-np"]
