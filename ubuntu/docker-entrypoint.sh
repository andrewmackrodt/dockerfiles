#!/bin/sh

# backup environment variables
if [ ! -f /tmp/docker-entrypoint.env ]; then
    export > /tmp/docker-entrypoint.env
fi

############################################################
# restart as root
############################################################

if [ "$(id -u)" != "0" ]; then
    # write entrypoint args to file, they cannot be passed along to the sudo
    # command if the container was previously started with the option to
    # disable passwordless sudo - however, a special rule exists to allow
    # passwordless sudo to call this file

    for arg in "$@"; do
        # use printf, echo skips args beginning with hyphen '-'
        printf %s "$arg" | base64 -w0
        printf '\n'
    done | tac > ~/.entrypoint.txt

    exec sudo -EH "$0"
fi

# restore args
if [ $# -eq 0 \
        -a ! -z "${SUDO_USER:-}" \
        -a -f "/home/${SUDO_USER}/.entrypoint.txt" \
 ]; then

    while IFS='' read -r arg; do
        set -- "$(printf %s "$arg" | base64 -d)" "$@"
    done <"/home/${SUDO_USER}/.entrypoint.txt"

    rm "/home/${SUDO_USER}/.entrypoint.txt"
fi


ADM_USER=ubuntu


############################################################
# run entrypoint scripts
############################################################

run_entrypoint_scripts () {
    local path=/etc/entrypoint.d

    if [ -z "${2:-}" ]; then
        path="$path/root/$1"
    else
        path="$path/user/$1"
    fi

    local scripts="$(find "$path" -maxdepth 1 -type f -not -name '.*')"

    for f in $scripts; do
        if [ -z "${2:-}" ]; then
            # run root script
            "$f"
        else
            # run user script
            gosu "$2" "$f"
        fi
    done
}

if [ ! -f /var/local/entrypoint.lock ]; then
    run_entrypoint_scripts 'init'
fi

run_entrypoint_scripts 'start'

# run user scripts in a subshell to restore the original environment
(
    if [ -f '/tmp/docker-entrypoint.env' ]; then
        eval $(awk 'BEGIN { for(v in ENVIRON) print v }' \
            | grep -v 'PATH' \
            | sed -E 's/^/unset /' \
            | cut -d'=' -f1 \
        )
        . /tmp/docker-entrypoint.env
    fi

    if [ ! -f /var/local/entrypoint.lock ]; then
        run_entrypoint_scripts 'init' "$ADM_USER"
    fi

    run_entrypoint_scripts 'start' "$ADM_USER"
)

# create the entrypoint lock file to prevent running init tasks
if [ ! -f /var/local/entrypoint.lock ]; then
    date +'%s' > /var/local/entrypoint.lock
fi


############################################################
# set secondary entrypoint
############################################################

# detect the secondary entrypoint if $1 is empty or "-"
if echo "${1:--}" | grep -qE '^-'; then
    if [ ! -z "${ENTRYPOINT0:-}" ]; then
        # remove first argument if --, e.g. command is `docker run chdman -- createcd ...`
        # -- is needed to avoid overriding the entrypoint
        if [ "$1" = '--' ]; then
            shift
        fi

        # do not wrap ENTRYPOINT0 in quotes, it can be many args
        set -- $ENTRYPOINT0 "$@"
    fi
fi


############################################################
# set init system
############################################################

if [ \
        "${S6_ENABLE:-0}" -eq 1 \
        -o "${S6_ENABLE:-0}" -eq 2 -a $# -eq 0 \
 ]; then
    # switch to adm user after exec s6-overlay
    # only if arg count > 0
    [ $# -eq 0 ] || set -- gosu "$ADM_USER" "$@"
    set -- /init "$@"
else
    # fallback to user shell if no ENTRYPOINT0 and no CMD
    if echo "${1:--}" | grep -qE '^-'; then
        ADM_SHELL=$(awk -F':' '$1 == "'$ADM_USER'" { print $7 }' /etc/passwd)

        set -- "$ADM_SHELL" "$@"
    fi

    # switch to adm user after exec tini
    set -- tini -s -g gosu -- "$ADM_USER" "$@"
fi


############################################################
# restore environment and step down user
############################################################

# restore env variables
if [ -f '/tmp/docker-entrypoint.env' ]; then
      eval $(awk 'BEGIN { for(v in ENVIRON) print v }' \
          | grep -v 'PATH' \
          | sed -E 's/^/unset /' \
          | cut -d'=' -f1 \
      )
    . /tmp/docker-entrypoint.env
    rm '/tmp/docker-entrypoint.env'
fi

# export XDG_RUNTIME_DIR
if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u $ADM_USER)"
fi

# export DBUS_SESSION_BUS_ADDRESS
if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" -a -S "$XDG_RUNTIME_DIR/bus" ]; then
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
fi

exec "$@"
