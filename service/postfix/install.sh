#!/bin/bash -e
# this script is run during the image build

cat /container/service/postfix/config/aliases >> /etc/aliases
newaliases


