FROM debian:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    iproute2 \
    tcpdump \
    net-tools \
    iputils-ping \
    traceroute \
    dnsutils \
    samba \
    smbclient \
    nmap

CMD ["sleep", "infinity"]