FROM debian:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    iproute2 \
    tcpdump \
    net-tools \
    iputils-ping \
    traceroute \
    dnsutils \
    nginx \
    apache2-utils \
    openssl \
    curl

RUN mkdir -p /usr/local/share/ca-certificates
COPY planet-ca.crt /usr/local/share/ca-certificates
RUN update-ca-certificates

CMD [ "sleep", "infinity" ]

