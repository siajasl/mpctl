#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-build-image

    DESCRIPTION
    ----------------------------------------------------------------
    Builds Hawk server docker image.
    "
}

function _main()
{
    local docker_filepath="$(get_path_to_monorepo)/Dockerfile.dev.hawk"

    _build_image "Dockerfile.dev.hawk"
    # _build_image "Dockerfile.genesis.dev.hawk"
}

function _build_image()
{
    local docker_filepath="$(get_path_to_monorepo)/${1}"

    pushd "$(get_path_to_monorepo)" || exit
    docker build \
        -f "${docker_filepath}" \
        -t hawk-server-local-build:latest .
    popd | exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main
fi
