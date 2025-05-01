#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-dkr-build-server-image

    DESCRIPTION
    ----------------------------------------------------------------
    Builds server docker image.

    ARGS
    ----------------------------------------------------------------
    image       Image to build: all | standard | genesis. Optional.

    DEFAULTS
    ----------------------------------------------------------------
    image       all
    "
}

function _main()
{
    local image=${1}

    pushd "$(get_path_to_monorepo)" || exit

    if [ "$image" == "all" ]; then
        docker build \
            -f Dockerfile.dev.hawk.genesis \
            -t hawk-server-local-build-genesis:latest .
        docker build \
            -f Dockerfile.dev.hawk \
            -t hawk-server-local-build-genesis:latest .
    elif [ "$image" == "genesis" ]; then
        docker build \
            -f Dockerfile.dev.hawk.genesis \
            -t hawk-server-local-build-genesis:latest .
    else
        docker build \
            -f Dockerfile.dev.hawk \
            -t hawk-server-local-build:latest .
    fi

    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _IMAGE
unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        image) _IMAGE=${VALUE} ;;
        help) _HELP="show" ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_IMAGE:-"all"}"
fi
