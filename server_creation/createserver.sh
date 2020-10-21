#!/bin/bash

#Configuration.
STEAMCMDDIR=/games/steamcmd
GAMEDIR=/games/installs/$2
SERVERDIR=/games/servers

# File Excludes
FEXCLUDE=(
$GAMEDIR/update.txt
$GAMEDIR/update.sh
$GAMEDIR/servers.txt
)

# The script.
echo "Creating $1..."

# Create necessary folders.
mkdir -p $SERVERDIR/$1/server

# Create the user.
useradd -d /games/servers/$1/ -g servers -s /bin/bash $1
if ! [[ -z $1 ]]
then
	# Create the password.
	passwd $1

	# Give access to the FTP.
	printf "$1\n" >> /etc/vsftpd.allowed_users

	# Restart VSFTPD.
	service vsftpd restart
fi
	
# Hard link files.
./scripts/linkfiles.sh $1 $2

# Copy necessary scripts.
./scripts/copyscripts.sh $1 $2

# Update permissions.
./scripts/updatepermissions.sh $1

# Finished.
echo "Server created..."
