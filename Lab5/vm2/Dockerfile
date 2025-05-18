FROM debian:latest

RUN apt update && apt install -y \
    nfs-common \
    rpcbind \
    iputils-ping \
    iproute2 \
    net-tools

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "sleep", "infinity" ]