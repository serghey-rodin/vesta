#!/bin/bash

if [ -e "/etc/exim4/domains/" ]; then
    for domain in $(ls /etc/exim4/domains/); do
        domain_link=$(readlink /etc/exim4/domains/$domain)
        chown Debian-exim:mail $domain_link
        chown Debian-exim:mail /etc/exim4/domains/$domain/*

        # Checking if dovecot user exists before set dovecot as owner. If dovecot user doesn't exist (dovecot is not installed), owner is assign to Exim user
        if id "dovecot" >/dev/null 2>&1; then
            chown -R dovecot:mail /etc/exim4/domains/$domain/passwd
        else
            chown -R $MAIL_USER:mail /etc/exim4/domains/$domain/passwd
        fi
    done
fi

exit
