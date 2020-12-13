#!/bin/bash

#source "scriptUtils.sh"
#set -x

command -v docker > /dev/null
if [[ $? -eq 1 ]]
then
    fatalln "docker not present in PATH. Quitting."
fi

command -v docker-compose > /dev/null
if [[ $? -eq 1 ]]
then
    fatalln "docker-compose not present in PATH. Quitting."
fi


