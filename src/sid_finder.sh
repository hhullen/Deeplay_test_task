#!/bin/bash

path=$1
ip=$2
is_path=1

check_path() {
    is_permitted=`find $1 -type f -perm -u=r`

    if [[ "`whoami`" == "root" ]]; then
        is_permitted="permitted"
    fi

    if [[ -f $1 && -z "$is_permitted" ]]; then
        echo "Permission denied to read specified log file for this user"
        is_path=0
    elif ! [[ -f $1 ]] && [[ -z "$is_permitted" ]]; then
        is_path=0
    fi
}

print_manual() {
    echo
    echo 'The script search log file to find "sid" values for specfified IP inside notations'
    echo
    echo 'FOR EXAMPLE: ./scriptname [PATH] [IP ADDRESS]'
    echo
    echo 'PATH:'
    echo '    Path to log file. Notice: log file has to be in "Combined Log Format".'
    echo '    Note of "Combined Log Format" has to uncludes space-separated fields:'
    echo '        - Hostname or IP address of accesser of site;'
    echo '        - RFC 1413 identity of client. This is noted as unreliable, and is usually blank (represented by a hyphen (-) in the file)'
    echo '        - Username of user accessing document. Will be a hyphen for public web-sites that have no user access controls'
    echo '        - Timestamp string surrounded by square brackets, e.g. [12/Dec/2012:12:12:12 -0500]'
    echo '        - HTTP request surrounded by double quotes, e.g., "GET /stuff.html HTTP/1.1"'
    echo '        - HTTP status code'
    echo '        - Number of bytes transferred in requested object'
    echo '        - User agent string sent by client (surrounded by double quotes). Can be used to identify what browser was used'
    echo 'IP ADDRESS:'
    echo '    IP address, inside notation of log where "sid" need to be found'
    echo
}


if [[ -n "$path" && -n "$ip" && -z "$3" ]]; then
    check_path $path
    if [[ $is_path -eq 1 ]]; then
        cat log.txt | awk '{if ($1 == "'$ip'") print}' | grep -o "sid=/[a-zA-Z0-9\/]*[a-zA-Z0-9]" | cut -c 6- | sort -d
    fi
elif [[ "$path" == "--help" && -z "$2" ]]; then
    print_manual
else
    echo "Script requires just 2 arguments. For instance: ./scriptname /home/hhullen/log.txt 10.1.192.38"
    echo "Try specify --help flag for more information"
fi
