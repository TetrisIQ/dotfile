#!/bin/bash
green='\E[32m'
bold='\033[1m'
normal='\033[0m'
red='\e[91m'
var="Y"
TEMPDIR="/home/alex"

#Create a directory and cd into it
if [ "$(printenv TEMPDIR)" == NULL ]
	then 
		echo -e "Using old tmpDir"
		TEMPDIR=$(printenv TEMPDIR)
	else 
		echo -e "\\n$bold$green"Creating a temp directory to work in..."$normal\\n"
		TEMPDIR=$(mktemp -d)
		export aurTmpDir="$TEMPDIRTMP"
	fi
	
cd "$TEMPDIR"
echo -e "\\n$bold$green"Working in $TEMPDIR"$normal\\n"

cower -ud

#Build script
echo -e "\\n$bold$green"Building AUR packages"$normal\\n"
for dir in $TEMPDIR/*; do
  read -p "Build => $dir ? [Y/n]" var
  if [ "$var" == y ] || [ "$var" == Y ]
  then
    cd "$dir"
	  makepkg
	  notify-send 'AUR-Needs Interaction!' 'Interaction reqired ' --icon=dialog-information
	  sudo pacman -U *.pkg.tar.xz
	#echo -e "$red" Remove => "$dir ? [y/N]"
	var="N"
    read -p "Remove => $dir ? [y/N] " var
    if [ "$var" == y ] || [ "$var" == Y ]
    then
      cd ..
      rm "$dir -dfr"
    fi
  fi
done
var="N"
#echo -e "$red" Remove => "$TEMPDIR ? [y/N]"
read -p "Remove => $TEMPDIR ? [y/N]" var
if [ "$var" == y ] || [ "$var" == Y ]
  then
    cd ../..
    rm "$TEMPDIR -dfr"
fi
