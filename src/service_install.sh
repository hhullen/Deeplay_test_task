#!/bin/bash
if [[ "$1" == "install" ]]; then
    if ! [[ -f "/etc/systemd/system/hhullen.service" ]]; then
        cp hhullen.service /etc/systemd/system/
    fi
    
elif [[ "$1" == "remove" ]]; then

fi