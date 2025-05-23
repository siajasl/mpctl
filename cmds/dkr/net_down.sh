#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-net-down

    DESCRIPTION
    ----------------------------------------------------------------
    Brings down MPC network.
    "
}

function _main()
{
    local binary="${1}"
    local docker_compose_fpath

    if [ "${binary}" == "genesis" ]; then
        docker_compose_fpath="${MPCTL_DOCKER_COMPOSE_HAWK_GENESIS}"
    else
        docker_compose_fpath="${MPCTL_DOCKER_COMPOSE_HAWK}"
    fi

    pushd "$(get_path_to_monorepo)" || exit
    docker-compose -f "${docker_compose_fpath}" down --volumes
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _BINARY
unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        binary) _BINARY=${VALUE} ;;
        help) _HELP="show" ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_BINARY:-"standard"}"
fi
