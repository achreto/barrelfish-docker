FROM ubuntu:20.04
MAINTAINER Reto Achermann <reto.achermann@inf.ethz.ch>


COPY ../config.pp /config.pp
COPY ../aptsources.list /sources.list
COPY ../install.sh /install.sh
COPY ../eclipseclp /eclipseclp
COPY ../entrypoint.sh /entrypoint.sh

RUN /install.sh && rm -rf /install.sh

ENTRYPOINT ["/entrypoint.sh"]
