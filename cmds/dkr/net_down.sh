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
    pushd "$(get_path_to_monorepo)" || exit

    if [ "$binary" == "genesis" ]; then
        docker_filename="docker-compose.test.genesis.yaml"
    else
        docker_filename="docker-compose.test.yaml"
    fi

    docker-compose -f $docker_filename down --volumes

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
