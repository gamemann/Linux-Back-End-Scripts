# Let's receive it from Ubuntu.
FROM ubuntu:20.04

# Update.
RUN apt-get update

# Install common.
RUN apt-get install -y software-properties-common

# Add PHP.
RUN add-apt-repository ppa:ondrej/php

# Update again.
RUN apt-get update

# Create /run/php directory.
RUN mkdir -p /run/php

# Install NGINX + PHP + OpenSSH
RUN apt-get install -y nginx php7.2-fpm supervisor net-tools openssh-server && rm -rf /var/lib/apt/lists/*

# Fix OpenSSH bug.
RUN mkdir -p /run/sshd

# Add the test user.
RUN groupadd website && \
	useradd -d /var/www/test01 -g website -s /bin/bash website

# Add website folder.
RUN mkdir -p /var/www/test01/public && mkdir -p /var/www/test/.ssh

# Copy over needed files.
COPY files/site-test01 /etc/nginx/sites-available/site-test01
COPY files/socket.conf /etc/php/7.2/fpm/pool.d/test01.conf
COPY files/index.php /var/www/test01/public/index.php
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/sshd_config /etc/ssh/sshd_config
COPY files/pubkey /var/www/test01/.ssh/authorized_keys

# Link NGINX file.
RUN ln -s /etc/nginx/sites-available/site-test01 /etc/nginx/sites-enabled/site-test01

# Remove DEFAULT site link.
RUN rm -f /etc/nginx/sites-enabled/default

# Assign ownership.
RUN chown -R website:website /var/www/test01

# Do .ssh permissions.
RUN chmod 700 /var/www/test01/.ssh; chmod 600 /var/www/test01/.ssh/authorized_keys

# Copy startup file.
COPY files/startup.sh /startup.sh

# Expose port 80 and 443. If you're running multiple containers including NGINX and want to use 80/443, I'd suggest commenting out the line below and mapping ports instead (e.g. -p 1234:80 and -p 12345:443) and then using an NGINX reverse proxy.
EXPOSE 80 443

# Startup script.
CMD ["./startup.sh"]
