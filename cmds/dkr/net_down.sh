#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-net-down

    DESCRIPTION
    ----------------------------------------------------------------
    Brings down MPC network.

    ARGS
    ----------------------------------------------------------------
    binary      Binary to execute: standard | genesis. Optional.

    DEFAULTS
    ----------------------------------------------------------------
    binary      standard
    "
}

function _main()
{
    local binary="${1}"

    pushd "$(get_path_to_monorepo)" || exit
    if [ "${binary}" == "genesis" ]; then
        docker-compose -f "${MPCTL_DKR_COMPOSE_HAWK_GENESIS}" down --volumes
    else
        docker-compose -f "${MPCTL_DKR_COMPOSE_HAWK}" down --volumes
    fi
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

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
