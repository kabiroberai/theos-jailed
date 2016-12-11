#!/bin/bash

exec 3>&1
exec 4>&2
if [[ $_THEOS_VERBOSE != 1 ]]; then
	exec &>/dev/null
fi

function log { eval "$PRINT_FORMAT_STAGE \"$1\" \"$2\" 1>&3"; }
function error { eval "$PRINT_FORMAT_ERROR \"$1\" 1>&4"; exit 1; }
