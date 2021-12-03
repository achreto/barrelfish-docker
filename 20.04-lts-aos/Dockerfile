FROM ubuntu:20.04
MAINTAINER Reto Achermann <achreto@cs.ubc.ca>

COPY install.sh /install.sh
COPY entrypoint.sh /entrypoint.sh

RUN /install.sh && rm -rf /install.sh

ENTRYPOINT ["/entrypoint.sh"]
