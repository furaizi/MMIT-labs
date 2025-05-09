FROM debian:latest
ARG CONFIG_DIR
ARG CA_DIR
ARG MAIL_HOSTNAME
ENV DEBIAN_FRONTEND=noninteractive
ENV HOSTNAME=${MAIL_HOSTNAME}

RUN apt-get update && apt-get install -y \
    dnsutils \
    bind9 \
    bind9utils \
    bind9-doc \
    openssl \
    postfix \
    dovecot-core \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-lmtpd \
    dovecot-sieve \
    dovecot-managesieved && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "postfix postfix/mailname string ${MAIL_HOSTNAME}" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections

COPY ${CONFIG_DIR}/dns /etc/bind
COPY ${CONFIG_DIR}/certs /etc/ssl/local
COPY ${CONFIG_DIR}/postfix /etc/postfix
COPY ${CONFIG_DIR}/dovecot /etc/dovecot

WORKDIR /usr/local/bin
COPY ${CONFIG_DIR}/setup.sh . 
EXPOSE 25 465 587 993 995
RUN chmod +x setup.sh
# ENTRYPOINT [ "./setup.sh" ]
    