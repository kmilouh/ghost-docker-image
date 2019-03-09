#!/bin/bash

# Base on Bitnami  entrypoint.sh

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
# shellcheck source=/dev/null
. /libbitnami.sh

info "Welcome to the Ghost docker image"
# shellcheck source=/dev/null
#. /prepare.sh 

if [[ "$*" = "/run.sh" ]]; then
    # run and continue.
    /setup.sh    
fi

info "Running $*"
cd "$GHOST_APP_DIR" &&  exec "$@"