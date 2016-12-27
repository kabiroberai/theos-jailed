#!/bin/bash

source "$STAGE"

regex_info="\[\.\.\.\.] (.*)"
regex_percent="\[ *([0-9]+)%\].*"
regex_error='.*\[ !! \] (.*)'

ios-deploy $RELAUNCH_FLAG -LWb "$appdir" 2>&1 | while read -r line; do
	if [[ $_THEOS_VERBOSE = 1 ]]; then
		echo "$line"
	elif [[ $line =~ $regex_info ]]; then
		log 2 "${BASH_REMATCH[1]}"
	elif [[ $line =~ $regex_percent ]]; then
		log_installing "${BASH_REMATCH[1]}"
	elif [[ $line =~ $regex_error ]]; then
		echo >&3;
		error "${BASH_REMATCH[1]}"
	fi
done
echo >&3;
