#!/bin/bash

# Base on Bitnami  prepare.sh

# Load libraries
# shellcheck source=/dev/null
. /libfs.sh


echo "Ensure DIR Exist"

for dir in "${GHOST_WWW_DIR}" "${GHOST_APP_DIR}" ; do
    echo  "Ensure DIR Exist $dir"
    ensure_dir_exists "$dir"
done

mkdir /home/nonroot
chown -hR 1001:1001  /home/nonroot

chmod -R g+rwX "${GHOST_WWW_DIR}" "${GHOST_APP_DIR}"
chmod -R 755 "${GHOST_WWW_DIR}"
chown -hR 1001:1001  "${GHOST_WWW_DIR}"
chown -hR 1001:1001  "${GHOST_APP_DIR}"

