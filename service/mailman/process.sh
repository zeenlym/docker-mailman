#!/bin/bash -e
/etc/init.d/mailman start
exec tail -f /dev/null

