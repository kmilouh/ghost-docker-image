#!/bin/bash

# Base on Bitnami  run.sh

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
# shellcheck source=/dev/null
. /libbitnami.sh
# shellcheck source=/dev/null
. /functionsdb.sh

info "** Starting Ghost **" 


cd "$GHOST_APP_DIR" 
info "Ghost PWD => $(pwd)" 

result=$(waittime 60) 
echo "$result"
if [ "$result" -eq "-1" ]; then
    error "Error Connecting to Db!"
else
    info "Ghost Start"  
    node "${GHOST_APP_DIR}current/index.js"
fi


     



 