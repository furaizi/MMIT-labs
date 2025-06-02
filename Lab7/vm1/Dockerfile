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
    openssl

RUN mkdir -p /etc/nginx/ssl
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx/index.html /var/www/index.html
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8082 8445
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "sleep", "infinity" ]