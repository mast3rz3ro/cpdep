#!/usr/bin/bash


# Author: mast3rz3ro

		
		# Main help
if [ "$1" = '' ]; then
		echo 'A utility able to find and copy dependencies for executable'
		echo 'Usage: cpdep executable'
		exit
fi

		# Detect system
		env=$(uname)
	if [[ "$env" = 'MSYS'* ]]; then
		usr="/usr/bin"
	elif [[ "$env" = 'MINGW64'* ]]; then
		usr='/mingw64/bin'
	elif [[ "$env" = 'MINGW32'* ]]; then
		usr='/mingw32/bin'
	fi
		
		# Empty the var just in case
		list=''
		
		# Store list of input
for x in "$@"; do
if [ -s "$usr/$x" ]; then
		list+="$usr/$x "
elif [ -s "$x" ]; then
		list+="$x "
else
		echo "Not found: '$x'"
fi
done

		# Create output dir
		mkdir -p ~/"cpdep_out"
		output=~/"cpdep_out"

for x in $list; do
	if [ -s "$x" ]; then
		dep=$(ldd "$x" | awk -F '=> ' '{print $2}' | awk -F ' ' '{print $1}' | awk -F '/c/' '{print $1}' | sed -z 's/\n\n//g' | tr '\n' ' ')
		echo "Copying: '$x'"
		cp "$x" "$output"
		echo "Copying: '$dep'"
		cp $dep "$output"
	else
		echo "Not found: $x"
	fi
done
		echo "Saved into: $output"
		exit 1
		








