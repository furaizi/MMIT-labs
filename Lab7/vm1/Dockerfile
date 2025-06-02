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

RUN mkdir -p /etc/nginx/ssl
COPY certs/ /etc/nginx/ssl
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/index.html /var/www/index.html

RUN update-ca-certificates && \
    htpasswd -bc /etc/nginx/.htpasswd mercury pass && \
    htpasswd -b /etc/nginx/.htpasswd venus pass && \
    htpasswd -b /etc/nginx/.htpasswd earth pass

EXPOSE 8082 8445
CMD ["nginx", "-g", "daemon off;"]