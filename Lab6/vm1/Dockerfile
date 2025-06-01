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

COPY samba/smb.conf /etc/samba/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
