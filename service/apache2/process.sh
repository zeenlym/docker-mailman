#!/bin/bash -e
/etc/init.d/apache2 start
exec tail -f /dev/null

