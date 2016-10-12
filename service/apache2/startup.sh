#!/bin/bash -e
# this script is run during the image build

# Enable mods
a2enmod cgid

# Copy configurations
envsubst < /container/service/apache2/config/mailman.conf > /etc/apache2/sites-available/mailman.conf
a2dissite 000-default && a2ensite mailman.conf

# Misc


