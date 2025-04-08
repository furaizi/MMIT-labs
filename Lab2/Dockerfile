FROM debian:latest
ARG CONFIG_DIR

RUN apt-get update && apt-get install -y \
    dnsutils \
    bind9 \
    bind9utils \
    bind9-doc

WORKDIR /etc/bind
COPY ${CONFIG_DIR} .
RUN chmod +x setup_server.sh
ENTRYPOINT [ "./setup_server.sh" ]