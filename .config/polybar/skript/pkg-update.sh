#!/bin/bash
aur=$(cower -u | wc -l)
list=$(cower -u)
if [[ "$aur" != "0" ]]
then
	roxterm -e 'sh -c "fetchpkg -Syu ; echo Done ; $list ; read"'
else
	roxterm -e 'sh -c "fetchpkg -Syu ; echo Done ; read"'
fi
	