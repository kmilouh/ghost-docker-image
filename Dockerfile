FROM bitnami/minideb-extras-base  as BASE

RUN install_packages build-essential ca-certificates curl ghostscript wget git \
                     imagemagick libbz2-1.0 libc6 libgcc1 libncurses5 libreadline7 \
                     libsqlite3-0 libsqlite3-dev libssl-dev libssl1.0.2 libssl1.1 \
                     libstdc++6 libtinfo5 pkg-config unzip wget zlib1g libuv1 mysql-client

#DATABASE_HOST        : Database server host
#DATABASE_PORT_NUMBER : Database server port
#DATABASE_USER        : Ghost database user
#DATABASE_NAME        : Ghost database name
#DATABASE_PASSWORD    : Ghost database password
#GHOST_HOST           : Hostname used to access to Ghost. Used by ghost application to create internal routes.
#GHOST_PORT_NUMBER    : The port number where the application will run.
#GHOST_USER           : Admin username
#GHOST_EMAIL          : Admin email used to authenticate
#GHOST_BLOG_TITLE     : Title of the blog
#GHOST_PASSWORD       : Password to authenticate
#GHOST_DATA_DIR       : Folder to store Data 

ENV GHOST_APP_DIR="/bootcam/ghost/" \
    GHOST_WWW_DIR="/bootcam/" \
    DATABASE_HOST="" \ 
    DATABASE_PORT_NUMBER=3306 \    
    DATABASE_USER="" \
    DATABASE_NAME="" \
    DATABASE_PASSWORD="" \
    GHOST_URL="" \
    GHOST_HOST="" \
    GHOST_PORT_NUMBER=3000 \
    GHOST_USER="" \
    GHOST_EMAIL="" \
    GHOST_BLOG_TITLE="" \
    GHOST_PASSWORD="" \
    NODE_ENV=production \
    GHOST_VERSION="2.15.0"

# Volume
VOLUME $GHOST_APP_DIR

# Create a nonroot user  
RUN useradd -r -u 1001 -g root nonroot

RUN wget https://nodejs.org/dist/v10.15.2/node-v10.15.2-linux-x64.tar.xz && tar -xf node-v10.15.2-linux-x64.tar.xz  -C /usr --strip-components=1  && \
    npm install -g yarn ghost-cli && rm node-v10.15.2-linux-x64.tar.xz

# Copy scripts
COPY scripts /
# Run prepare.sh
RUN  /prepare.sh

# Default etcd ports
EXPOSE ${GHOST_PORT_NUMBER}  

# Set the nonroot active
USER nonroot

# Entry Point
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]

