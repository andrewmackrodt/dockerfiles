#!/bin/sh

############################################################
# restart as root
############################################################

if [ "$(id -u)" != "0" ]; then
    # backup environment variables
    env > "/tmp/docker-entrypoint.env"

    # detect init system to use if pid 1
    # i.e. the container was not started as root user
    if [ $$ = 1 ]; then
        if [ "${S6_ENABLE:-0}" = "0" ]; then
            set -- tini -s -g "$0" -- "$@"
        else
            set -- /init "$0" "$@"
        fi
    else
        set -- "$0" "$@"
    fi

    exec sudo -E "$@"
fi

############################################################
# functions
############################################################

set_timezone () {
    if [ -z "${TZ:-}" ]; then
        return
    fi

    local zone_file="/usr/share/zoneinfo/$TZ"

    if [ -f "$zone_file" ]; then
        ln -fns "$zone_file" /etc/localtime
        echo "$TZ" > /etc/timezone
    else
        echo "ERR unknown timezone '$TZ'" >&2
    fi
}

set_uidgid () {
    # existing container user details
    ADM_PASSWD=$(grep -E "^$ADM_USER:" /etc/passwd)
    ADM_UID=$(echo "$ADM_PASSWD" | cut -d':' -f3)
    ADM_GID=$(echo "$ADM_PASSWD" | cut -d':' -f4)
    ADM_HOME=$(echo "$ADM_PASSWD" | cut -d':' -f6)

    PUID="${PUID:-$ADM_UID}"

    # PUID user details
    PUID_PASSWD=$(grep -E ":x:$PUID:" /etc/passwd | head -n1)
    PUID_USER=$(echo "$PUID_PASSWD" | cut -d':' -f1)
    PUID_GID=$(echo "$PUID_PASSWD" | cut -d':' -f4)
    PUID_HOME=$(echo "$PUID_PASSWD" | cut -d':' -f6)

    PGID="${PGID:-${PUID_GID:-$ADM_GID}}"

    # update pgid
    if [ "$PGID" != "$ADM_GID" ]; then
        set_gid
    fi

    # update puid and add to puid user groups
    if [ "$PUID" != "$ADM_UID" ]; then
        set_uid
    fi
}

get_adm_user () {
    echo $(awk -F':' '{ print $3, $1 }' /etc/passwd \
        | sort -n \
        | grep -E "\b($(awk -F':' '$1 == "adm" { print $4 }' /etc/group | tr ',' '|'))\b" \
        | tail -n1 \
        | awk '{ print $2 }')
}

set_gid () {
    # replace container gid with pgid in /etc/passwd and /etc/group
    sed -i -E "s/^($ADM_USER:x:[^:]+):[^:]+:/\1:$PGID:/" /etc/passwd
    sed -i -E "s/^($ADM_USER:x):[^:]+:/\1:$PGID:/" /etc/group

    # update file gid

    local exclude_mounts="$( \
      mount \
        | sed -n -E "s#^[^ ]+ on ($ADM_HOME.+?) type.+#\\1#p" \
        | sed -E "s#.+#-not -path '\\0' -not -path '\\0/*'#" \
        | tr $"\n" " " \
    )"

    eval find "$ADM_HOME" $exclude_mounts -print0 | xargs -0 -r chgrp "$PGID"
}

set_uid () {
    # replace container uid with puid in /etc/passwd
    sed -i -E "s/^($ADM_USER:x):[^:]+:/\1:$PUID:/" /etc/passwd

    # update container user home and groups if existing user with puid
    # otherwise update file permissions to puid
    if [ ! -z "$PUID_PASSWD" ]; then
        # add container user to all groups containing puid user
        sed -i -E "s/([:,]$PUID_USER\b)/\1,$ADM_USER/" /etc/group

        # update container user home if uid user is different
        if [ ! -z "$PUID_HOME" ]; then
            # create puid home if it doesn't exist
            if [ ! -d "$PUID_HOME" ]; then
                mkdir -p "$PUID_HOME"
                chown "$PUID:$PUID_GID" "$PUID_HOME"
            fi
        fi
    fi

    # update file uid

    local exclude_mounts="$( \
      mount \
        | sed -n -E "s#^[^ ]+ on ($ADM_HOME.+?) type.+#\\1#p" \
        | sed -E "s#.+#-not -path '\\0' -not -path '\\0/*'#" \
        | tr $"\n" " " \
    )"

    eval find "$ADM_HOME" $exclude_mounts -print0 | xargs -0 -r chown "$PUID"
}

############################################################
# continue as root
############################################################

ADM_USER=$(get_adm_user)

# detect the secondary entrypoint if $1 is empty or "-"
if echo "${1:--}" | grep -q -E "^-"; then
    # detect image specific entrypoint
    program=${ENTRYPOINT0:-}

    if [ -z "$program" ]; then
        # fallback to user shell
        program=$(awk -F':' '$1 == "'$ADM_USER'" { print $7 }' /etc/passwd)
    fi

    set -- "$program" "$@"
fi

# configure the environment
set_timezone
set_uidgid

# detect init system to use if pid 1, i.e. the container was started as root
if [ $$ = 1 ]; then
    if [ "${S6_ENABLE:-0}" = "0" ]; then
        # switch to adm user before exec tini
        # tini does not start services so does not need root
        program=$1; shift
        set -- gosu "$ADM_USER" tini "$program" -- "$@"
    else
        # switch to adm user after exec s6-overlay
        # s6 starts services and assumes root
        set -- /init gosu "$ADM_USER" "$@"
    fi
else
    # just switch the user if not pid 1, e.g. container started as non root
    set -- gosu "$ADM_USER" "$@"
fi

# restore env variables
if [ -f "/tmp/docker-entrypoint.env" ]; then
    eval $(env | cut -d"=" -f1 | grep -v "PATH" | xargs echo unset)
    eval $(sed -E "s/^/export /" "/tmp/docker-entrypoint.env")
    rm "/tmp/docker-entrypoint.env"
fi

exec "$@"
