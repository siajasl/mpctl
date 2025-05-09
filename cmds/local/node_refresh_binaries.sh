#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-local-node-refresh-binaries

    DESCRIPTION
    ----------------------------------------------------------------
    Refreshes binary set of a local bare metal MPC node.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local build_mode=${3}
    local compile_binaries=${2}
    local idx_of_node=${1}
    local path_to_assets_of_node

    log "MPC network :: refreshing binaries of node "${idx_of_node}""

    if [ "${compile_binaries}" = "true" ]; then
        source "${MPCTL}"/cmds/local/compile_server.sh mode=release
    fi

    path_to_assets_of_node="$(get_path_to_assets_of_node "${idx_of_node}")"
    cp \
        "$(get_path_to_target_binary "iris-mpc-hawk" "release")" \
        "${path_to_assets_of_node}/bin"
    cp \
        "$(get_path_to_target_binary "iris-mpc-hawk-genesis" "release")" \
        "${path_to_assets_of_node}/bin"

    log "MPC network :: refreshed binaries of node "${idx_of_node}""
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _BUILD_MODE
unset _COMPILE
unset _HELP
unset _IDX_OF_NODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        compile) _COMPILE=${VALUE} ;;
        help) _HELP="show" ;;
        mode) _BUILD_MODE=${VALUE} ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_IDX_OF_NODE}" "${_COMPILE:-true}" "${_BUILD_MODE:-"release"}"
fi
