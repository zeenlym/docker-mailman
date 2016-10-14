#!/bin/bash -e
FIRST_START_DONE="${CONTAINER_STATE_DIR}/mailman-first-start-done"

# container first start
if [ ! -e "$FIRST_START_DONE" ]; then
    log-helper info Initialising mailman configuration
    envsubst < ${CONTAINER_SERVICE_DIR}/mailman/config/mm_cfg.py > /etc/mailman/mm_cfg.py
    /usr/lib/mailman/bin/check_perms -f > /dev/null

    if [[ ! -e /var/lib/mailman/lists/mailman ]]; then
        log-helper info creating mailman list
        newlist -q mailman ${MAILMAN_ADM} ${MAILMAN_ADM_PASS}
    fi

    mmsitepass -c ${MAILMAN_SITE_PASS}
    touch $FIRST_START_DONE
fi

exit 0

