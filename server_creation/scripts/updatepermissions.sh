#!/bin/bash

# Configuration
SERVERDIR=/games/servers

# Remove protection off of private files.
chattr -i $SERVERDIR/$1/server/start_server.sh

echo "Updating permissions for $1."
echo "Please ensure you run this as root."

# Chown the server folder.
chown -R $1:servers $SERVERDIR/$1/
echo "$1 now owns their server..."

# Chmod the entire folder to 775
chmod -R 775 $SERVERDIR/$1/
echo "$1 now has full permission to operate their server..."

# Restrict the start_server.sh from being edited.
chmod 570 $SERVERDIR/$1/server/start_server.sh
chattr +i $SERVERDIR/$1/server/start_server.sh
echo "Restricting appropriate files..."

# Done
echo "DONE!"
