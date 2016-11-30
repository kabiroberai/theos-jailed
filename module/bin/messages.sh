#!/bin/bash

function log { eval "$PRINT_FORMAT_STAGE \"$1\" \"$2\""; }
function error { eval "$PRINT_FORMAT_ERROR \"$1\" >&2"; exit 1; }
