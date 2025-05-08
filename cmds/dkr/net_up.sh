#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-net-up

    DESCRIPTION
    ----------------------------------------------------------------
    Brings up MPC network.

    ARGS
    ----------------------------------------------------------------
    binary      Binary to execute: standard | genesis. Optional.
    mode        Mode: detached | other. Optional.

    DEFAULTS
    ----------------------------------------------------------------
    binary      standard
    mode        detached
    "
}

function _main()
{
    local binary=${1}
    local mode=${2}
    local docker_fpath

    # TODO: use specific docker files.
    if [ "$binary" == "genesis" ]; then
        docker_fpath="Dockerfile.dev.hawk"
    else
        docker_fpath="Dockerfile.dev.hawk"
    fi

    pushd "$(get_path_to_monorepo)" || exit
    if [ "$mode" == "detached" ]; then
        docker-compose -f ${docker_fpath} up --detach
    else
        docker-compose -f ${docker_fpath} up
    fi
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

unset _BINARY
unset _HELP
unset _MODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        binary) _BINARY=${VALUE} ;;
        help) _HELP="show" ;;
        mode) _MODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main \
        "${_BINARY:-"standard"}" \
        "${_MODE:-"detached"}"
fi
