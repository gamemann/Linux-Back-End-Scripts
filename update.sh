#!/bin/bash
#Configuration.
STEAMCMDDIR=/games/steamcmd
GAMEDIR=/games/installs/$1
SERVERDIR=/games/servers
SERVERLIST=/games/installs/$1/servers.txt

# File Excludes
FEXCLUDE=(
$GAMEDIR/update.txt
$GAMEDIR/update.sh
$GAMEDIR/servers.txt
)

# The script.
echo "Updating installation base..."

# Run SteamCMD and update the game.
$STEAMCMDDIR/steamcmd.sh +runscript $GAMEDIR/update.txt

echo "Updating servers..."

while read line
do
	echo "Updating $line..."
	
	# Hard link files again.
	./scripts/linkfiles.sh $line $1

	# Update permissions.
	./scripts/updatepermissions.sh $line $1

	# Finished.
	echo "Finished updating $line..."
done <$SERVERLIST

echo "Update complete..."
