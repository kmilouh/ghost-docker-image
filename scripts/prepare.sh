#!/bin/bash

# Base on Bitnami  prepare.sh

# Load libraries
# shellcheck source=/dev/null
. /libfs.sh
# shellcheck source=/dev/null
. /functionsdb.sh

ensure_disk_write_read
mkdir -p "${GHOST_APP_DIR}/content"
chown -hR 1001:1001  "${GHOST_APP_DIR}/content"



