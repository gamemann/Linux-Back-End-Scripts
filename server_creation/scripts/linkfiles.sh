#!/bin/bash

#Configuration.
GAMEDIR=/games/installs/$2
SERVERDIR=/games/servers

# File Excludes.
FEXCLUDE=(
$GAMEDIR/update.txt
$GAMEDIR/update.sh
$GAMEDIR/servers.txt
)

# Start the hard-linking process.
echo "Hard linking files for $1..."
	
# Copy all hard links from the game's  installation base to the server's directory.
IFS=$'\n';for f in $(find $GAMEDIR/ -name '*'); do 
	# Check exclude list.
	isExcluded=0

	for item in "${FEXCLUDE[@]}"; do
		[[ $f == "$item" ]] && isExcluded=1		
	done
		
	if [ $isExcluded == 1 ]
	then
		echo "Excluding - $f"
	else
		finalName="${f/$GAMEDIR\/}"

		if [ -f "$f" ]
		then
			# We can finally link after confirming it is not a directory.
			echo "Linking - $f"
			echo "Final Name - $finalName"

			# Let's link!
			cd $GAMEDIR
			cp -fl --parents $finalName $SERVERDIR/$1/server/
		fi
	fi
done

echo "Server files hard-linked..."
