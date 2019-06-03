FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

# create directories
RUN for d in /opt/redream /saves /config /bios /cache; do \
      mkdir "$d"; \
      chown ubuntu:adm "$d"; \
      chmod 2770 "$d"; \
    done

ARG REDREAM_VERSION

# install redream to /opt/redream
RUN wget -qO- "https://redream.io/download/redream.x86_64-linux-v$REDREAM_VERSION.tar.gz" > redream.tar.gz \
 && tar zxf redream.tar.gz -C /opt/redream \
 && rm -f redream.tar.gz \
 && chown -R ubuntu:adm /opt/redream \
 && chmod -R g+w /opt/redream

# create a symlink to redream bin
RUN ln -s /opt/redream/redream /usr/local/bin/redream

# link cache directory
RUN ln -s /cache /opt/redream/cache

# copy files to container
COPY redream-bootstrap /usr/local/bin/redream-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# export volumes
VOLUME /saves
VOLUME /config
VOLUME /bios
VOLUME /cache

# set directories to be chowned on container start
ENV USER_DIRS /saves:/config:/bios:/cache${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/redream-bootstrap
