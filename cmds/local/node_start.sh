#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-local-node-start

    DESCRIPTION
    ----------------------------------------------------------------
    Starts an MPC node on bare metal.

    ARGS
    ----------------------------------------------------------------
    binary      Binary to execute: standard | genesis. Optional.
    mode        Compilation mode: terminal | detached. Optional.
    node        Ordinal identifier of node.

    DEFAULTS
    ----------------------------------------------------------------
    binary      standard
    mode        terminal
    "
}

function _main()
{
    local binary=${2}
    local binary_dir_of_node
    local binary_fpath
    local idx_of_node=${1}
    local log_fpath
    local mode=${3}

    # Set paths.
    binary_dir_of_node="$(get_path_to_assets_of_node "${idx_of_node}")/bin"
    if [ "${binary}" == "genesis" ]; then
        binary_fpath="${binary_dir_of_node}/iris-mpc-hawk-genesis"
    else
        binary_fpath="${binary_dir_of_node}/iris-mpc-hawk"
    fi
    log_fpath="$(get_path_to_assets_of_node "${idx_of_node}")/logs/output.log"

    # Set node config.
    source "${MPCTL}"/cmds/local/node_activate_env.sh node="${idx_of_node}"

    # Start in either detached or terminal mode.
    if [ "$mode" == "detached" ]; then
        if [ -f "${log_fpath}" ]
        then
            rm "${log_fpath}"
        fi
        if [ "${binary}" == "genesis" ]; then
            nohup "${binary_fpath}" --max-height=1000 > "${log_fpath}" 2>&1 &
        else
            nohup "${binary_fpath}" > "${log_fpath}" 2>&1 &
        fi
    else
        if [ "${binary}" == "genesis" ]; then
            "${binary_fpath}" --max-height=1000
        else
            "${binary_fpath}"
        fi
    fi
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _BINARY
unset _HELP
unset _IDX_OF_NODE
unset _MODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        binary) _BINARY=${VALUE} ;;
        help) _HELP="show" ;;
        mode) _MODE=${VALUE} ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main \
        "${_IDX_OF_NODE:-"0"}" \
        "${_BINARY:-"standard"}" \
        "${_MODE:-"terminal"}"
fi
