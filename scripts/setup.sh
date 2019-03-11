#!/bin/bash

# Base on Bitnami  prepare.sh

set -o errexit
set -o nounset
set -o pipefail


# Load libraries
# shellcheck source=/dev/null
. /libbitnami.sh
# shellcheck source=/dev/null
. /functionsdb.sh

info "** Starting Ghost setup **"


cd "$GHOST_APP_DIR"|| error "Folder not exist : $GHOST_APP_DIR"

if [[ -d "${GHOST_APP_DIR}/content" && ! -L "${GHOST_APP_DIR}/content" ]] ; then
    info "Exist old Ghost app"
    #ghost start
else
   
    result=$(waittime 60) 

    if [ "$result" -eq "-1" ]; then
       error "Error Connecting to Db!"
       exit 100
    else
       info "....  Ghost Setup  ....."  
       info "....  Create ghost ....."
       info ghost install "${GHOST_VERSION}" local  
       ghost install  "${GHOST_VERSION}" --local --ip 0.0.0.0 --url "${GHOST_URL}" --db mysql --port "${GHOST_PORT_NUMBER}" --dbhost "${DATABASE_HOST}" --dbuser "${DATABASE_USER}" --dbpass "${DATABASE_PASSWORD}" --dbname "${DATABASE_NAME}" 
       cp config.development.json config.production.json 

       info "Configure User : ${GHOST_USER} "

       user_=$(urlencode "${GHOST_USER}")
       email_=$(urlencode "${GHOST_EMAIL}") 
       password_=$(urlencode "${GHOST_PASSWORD}")
       title_=$(urlencode "${GHOST_BLOG_TITLE}")

       
       #info  curl -H "cache-control: no-cache" -X POST "http://127.0.0.1:${GHOST_PORT_NUMBER}/ghost/api/v0.1/authentication/setup/?setup%5B0%5D%5Bname%5D=${user_}&setup%5B0%5D%5Bemail%5D=${email_}&setup%5B0%5D%5Bpassword%5D=${password_}&setup%5B0%5D%5BblogTitle%5D=${title_}"
       
       info "Wait 10s to configure Ghost"
       sleep 10s
        
       curl -H "cache-control: no-cache" -X POST "http://127.0.0.1:${GHOST_PORT_NUMBER}/ghost/api/v0.1/authentication/setup/?setup%5B0%5D%5Bname%5D=${user_}&setup%5B0%5D%5Bemail%5D=${email_}&setup%5B0%5D%5Bpassword%5D=${password_}&setup%5B0%5D%5BblogTitle%5D=${title_}"
       
       sleep 5s
       info "....  End Ghost Setup  ....." 
       pgrep node | xargs -r kill -9
    fi

fi
