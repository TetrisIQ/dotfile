#!/bin/bash
date=$(date | cut -d " " -f2)
kw=$(cal -w | grep $date | cut -d " " -f1)
echo "$kw"


#cal -w | grep (date | cut -d " " -f2 | sed 's/.$//') | cut -d " " -f1

