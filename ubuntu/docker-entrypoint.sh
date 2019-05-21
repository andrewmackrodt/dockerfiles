#!/bin/sh

# backup environment variables
if [ ! -f /tmp/docker-entrypoint.env ]; then
    env > /tmp/docker-entrypoint.env
fi

############################################################
# restart as root
############################################################

if [ "$(id -u)" != "0" ]; then
    exec sudo -EH "$0" "$@"
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
        eval $(env | cut -d'=' -f1 | grep -v 'PATH' | xargs echo unset)
        eval $(sed -E 's/^/export /' '/tmp/docker-entrypoint.env' | sed -E 's/=(.+)/="\1"/')
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
    if [ $# -eq 0 ]; then
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
    eval $(env | cut -d'=' -f1 | grep -v 'PATH' | xargs echo unset)
    eval $(sed -E 's/^/export /' '/tmp/docker-entrypoint.env' | sed -E 's/=(.+)/="\1"/')
    rm '/tmp/docker-entrypoint.env'
fi

exec "$@"
