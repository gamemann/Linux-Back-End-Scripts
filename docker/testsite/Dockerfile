# Let's receive it from Ubuntu.
FROM ubuntu:20.04

# Update.
RUN apt-get update

# Create /run/php directory.
RUN mkdir -p /run/php

# Install NGINX + PHP
RUN apt-get install -y nginx php7.2-fpm supervisor net-tools && rm -rf /var/lib/apt/lists/*

# Add the test user.
RUN groupadd website && \
        useradd -d /var/www/test01 -g website -s /bin/false website

# Add website folder.
RUN mkdir /var/www/test01

# Copy over needed files.
COPY files/site-test01 /etc/nginx/sites-available/site-test01
COPY files/socket.conf /etc/php/7.2/fpm/pool.d/test01.conf
COPY files/index.php /var/www/test01/index.php
COPY files/supervisord.conf /etc/supervisor/supervisord.conf

# Link NGINX file.
RUN ln -s /etc/nginx/sites-available/site-test01 /etc/nginx/sites-enabled/site-test01

# Remove DEFAULT site link.
RUN rm -f /etc/nginx/sites-enabled/default

# Assign ownership.
RUN chown -R website:website /var/www/test01

# Copy startup file.
COPY files/startup.sh /startup.sh

# Expose port 80 and 443.
EXPOSE 80 443

# Startup script.
CMD ["./startup.sh"]