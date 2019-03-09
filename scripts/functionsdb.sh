#!/bin/bash

# Base on Bitnami  prepare.sh

set -o errexit
set -o nounset
set -o pipefail


# Load libraries
# shellcheck source=/dev/null
. /libbitnami.sh

########################
# Wait for Database
# Arguments:
#   $1 - time to wait
#########################
waittime() {

    info "Wait for mariadb database"

    number=$1
    result=-1

    for i in $(seq 1 "${number}");
        do 
                 if mysqladmin -u"${DATABASE_USER}" -p"${DATABASE_PASSWORD}" -h"${DATABASE_HOST}" processlist > /dev/null 2>&1
                 then
                     result=$i
                     i=number
                     info "Database Up." 
                     break
                 else
                     sleep 1s
                 fi                
    done  

    echo "${result}"
}

# Take from
# 
# https://stackoverflow.com/questions/296536/how-to-urlencode-data-for-curl-command/10660730
#
########################
# Encode url 
# Arguments:
#   $1 - string to encode
#########################
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}