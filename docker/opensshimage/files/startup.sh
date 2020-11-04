#!/bin/bash
echo "Starting Docker container for test01 :)"

# Ensure NGINX and PHP 7.2 FPM are started.
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
