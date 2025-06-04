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
    # Hawk server: main.
    _build_image "${MPCTL_DOCKER_FILE_HAWK}" "${MPCTL_DOCKER_IMAGE_HAWK}"

    # Hawk server: genesis.
    _build_image "${MPCTL_DOCKER_FILE_HAWK}" "${MPCTL_DOCKER_IMAGE_HAWK_GENESIS}"
}

function _build_image()
{
    local image_fname=${1}
    local image_fpath
    local image_tag=${2}

    image_fpath="$(get_path_to_monorepo)/${image_fname}"

    pushd "$(get_path_to_monorepo)" || exit
    docker build -f "${image_fpath}" -t "${image_tag}:latest" .
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
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
