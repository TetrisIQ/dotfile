#!/bin/fish

cal -w | grep (date | cut -d " " -f2 | sed 's/.$//') | cut -d " " -f1

