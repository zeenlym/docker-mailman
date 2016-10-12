#!/bin/bash -e
/etc/init.d/postfix start
exec tail -f /dev/null

