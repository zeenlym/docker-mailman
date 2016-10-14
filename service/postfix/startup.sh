#!/bin/bash -e
FIRST_START_DONE="${CONTAINER_STATE_DIR}/postfix-first-start-done"

# container first start
if [ ! -e "$FIRST_START_DONE" ]; then
    log-helper info initializing postfix configuration

    postconf -e "relay_domains = ${MAILMAN_EMAIL_HOST}"
    postconf -e 'mailman_destination_recipient_limit = 1'
    postconf -e 'transport_maps = hash:/etc/postfix/transport'
    echo "${MAILMAN_EMAIL_HOST} mailman:" > /etc/postfix/transport
    postmap -v /etc/postfix/transport


    # configure TLS in postfix
    # ------------------------
    # enable tls for server and client
    postconf -e 'smtpd_tls_security_level = may'
    postconf -e 'smtp_tls_security_level = may'
    # disable unsafe protocols like SSL3 and older
    postconf -e 'smtpd_tls_mandatory_protocols = !SSLv2, !SSLv3'
    postconf -e 'smtpd_tls_protocols = !SSLv2, !SSLv3'
    postconf -e 'smtp_tls_mandatory_protocols = !SSLv2, !SSLv3'
    postconf -e 'smtp_tls_protocols = !SSLv2, !SSLv3'
    # do not use ciphers shorter than 128 bit
    postconf -e 'smtpd_tls_mandatory_ciphers = high'
    postconf -e 'smtpd_tls_ciphers = high'
    postconf -e 'smtp_tls_mandatory_ciphers = high'
    postconf -e 'smtp_tls_ciphers = high'
    touch $FIRST_START_DONE
fi

exit 0

