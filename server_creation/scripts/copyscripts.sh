#!/bin/bash

# Configuration
SERVERDIR=/games/servers
PORT=27015
IP=192.168.223.31

echo "Copying over files needed for the server to operate."

# Ensure the port is available. If not, then choose a different one.
echo "Check if the port is available..."
while true
do
	# Check if the port is in use, if not, then use it.
	if ! grep -Fxq "$IP:$PORT" $SERVERDIR/available.txt
	then
		# Use the port and break the loop.
		break
	fi
	
	echo "Port $PORT is in use. Incrementing the port value..."

	PORT=$((PORT + 1))
done

# Give the address.
echo "Address: $IP:$PORT..."

# Create the start_server.sh server.
echo $'#!/bin/bash\necho "Starting server..."\nscreen -mS '"$1"' ./srcds_run -game '"$2"' -console -usercon -ip '"$IP"' -port '"$PORT"' -nodefaultmap -maxplayers_override 64 +maxplayers 64 -condebug'$'\n''echo "Server started..."' > $SERVERDIR/$1/server/start_server.sh

echo "Start_server.sh created..."

echo "Done copying needed scripts..."

# Append IP and Port to the available.txt file.
printf "$IP:$PORT\n" >> "$SERVERDIR/available.txt"
