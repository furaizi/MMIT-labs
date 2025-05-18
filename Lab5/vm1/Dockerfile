FROM debian:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    nfs-kernel-server \
    rpcbind \
    acl \
    wget \
    procps \
    iputils-ping \
    iproute2 \
    net-tools

COPY exports /etc/exports
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "sleep", "infinity" ]