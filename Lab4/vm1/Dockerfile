FROM debian:latest
RUN apt-get update && apt-get install -y \
    iproute2 \
    net-tools \
    iputils-ping \
    vsftpd \
    lftp

COPY vsftpd.conf /etc/vsftpd.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 21 30000-30049
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "vsftpd", "/etc/vsftpd.conf" ]