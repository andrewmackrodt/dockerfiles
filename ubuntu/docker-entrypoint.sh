#!/bin/sh

# backup environment variables
if [ ! -f /tmp/docker-entrypoint.env ]; then
    env > /tmp/docker-entrypoint.env
fi

############################################################
# restart as root
############################################################

if [ "$(id -u)" != "0" ]; then
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

    exec sudo -EH "$@"
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
{
    if [ -f '/tmp/docker-entrypoint.env' ]; then
        eval $(env | cut -d'=' -f1 | grep -v 'PATH' | xargs echo unset)
        eval $(sed -E 's/^/export /' '/tmp/docker-entrypoint.env')
    fi

    if [ ! -f /var/local/entrypoint.lock ]; then
        run_entrypoint_scripts 'init' "$ADM_USER"
    fi

    run_entrypoint_scripts 'start' "$ADM_USER"
}

# create the entrypoint lock file to prevent running init tasks
if [ ! -f /var/local/entrypoint.lock ]; then
    date +'%s' > /var/local/entrypoint.lock
fi


############################################################
# set secondary entrypoint
############################################################

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


############################################################
# set init system (if container not started as root)
############################################################

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


############################################################
# restore environment and step down user
############################################################

# restore env variables
if [ -f '/tmp/docker-entrypoint.env' ]; then
    eval $(env | cut -d'=' -f1 | grep -v 'PATH' | xargs echo unset)
    eval $(sed -E 's/^/export /' '/tmp/docker-entrypoint.env')
    rm '/tmp/docker-entrypoint.env'
fi

exec "$@"
