#!/bin/bash

exec 3>&1
exec 4>&2
if [[ $_THEOS_VERBOSE != 1 ]]; then
	exec &>/dev/null
fi

function log { eval "$PRINT_FORMAT_STAGE \"$1\" \"$2\" >&3"; }
function error { eval "$PRINT_FORMAT_ERROR \"$1\" >&4"; exit 1; }
function log_installing { printf "\r\e[K\e[0;36m==> \e[1;39mInstalling: %s%%\e[m" "$1" >&3; }
