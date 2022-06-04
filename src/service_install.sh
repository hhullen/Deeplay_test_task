#!/bin/bash

install_service() {
    if ! [[ -f "/etc/systemd/system/hhullen.service" ]]; then
        cp src/hhullen.service /etc/systemd/system/
        echo "-Service file copied"
    else
        echo "-Service file already exists"
    fi

    if ! [[ -f "/var/log/hhullen-log.txt" ]]; then
        touch /var/log/hhullen-log.txt
        echo "-Log file copied"
    else
        echo "-Log file already exists"
    fi

    if ! [[ -f "/usr/bin/app.jar" ]]; then
        cp executable/app.jar /usr/bin/app.jar
        echo "-Java app copied"
    else
        echo "-Java app already exists"
    fi
}

remove_service() {
    if [[ -f "/etc/systemd/system/hhullen.service" ]]; then
        rm /etc/systemd/system/hhullen.service
        echo "-service file removed"
    fi

    if [[ -f "/var/log/hhullen-log.txt" ]]; then
        rm /var/log/hhullen-log.txt
        echo "-log file removed"
    fi

    if [[ -f "/usr/bin/app.jar" ]]; then
        rm /usr/bin/app.jar
        echo "-java app removed"
    fi
}

stop_service() {
    ACTIVE=`systemctl status hhullen | grep "Active" | grep "active"`
    if [[ -n "$ACTIVE" ]]; then
        systemctl stop hhullen
    fi
}

if [[ "$1" == "install" && "`whoami`" == "root" ]]; then
    install_service
    systemctl daemon-reload
    systemctl enable hhullen
    systemctl start hhullen
elif [[ "$1" == "remove" && "`whoami`" == "root" ]]; then
    stop_service
    remove_service
    systemctl daemon-reload
else
    echo "Make sure you are root"
fi
