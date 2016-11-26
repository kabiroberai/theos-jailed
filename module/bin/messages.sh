#!/bin/bash

# Print init message if $1 is not empty
[[ -n $1 ]] && eval "$PRINT_FORMAT_MAKING \"$1\""
function log { eval "$PRINT_FORMAT_STAGE \"$1\" \"$2\""; }
function error { eval "$PRINT_FORMAT_ERROR \"$1\" >&2"; exit 1; }
