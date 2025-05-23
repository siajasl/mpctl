#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-net-start

    DESCRIPTION
    ----------------------------------------------------------------
    Starts an MPC network.
    "
}

function _main()
{
    local binary=${2}
    local docker_fpath
    local docker_service
    local idx_of_node=${1}

    docker_fpath="$(get_path_to_docker_compose_file_of_net "${binary}")"
    docker_service="hawk_participant_${idx_of_node}"

    docker-compose -f "${docker_fpath}" start "${docker_service}"
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _BINARY
unset _HELP
unset _IDX_OF_NODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        binary) _BINARY=${VALUE} ;;
        help) _HELP="show" ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "$_IDX_OF_NODE" "${_BINARY:-"standard"}"
fi
