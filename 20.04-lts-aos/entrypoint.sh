#!/bin/bash

cd /source

if [ "$1" == "" ]; then
    exec "/bin/bash"
else
    exec "$@"
fi
