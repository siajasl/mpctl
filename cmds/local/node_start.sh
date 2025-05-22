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
    batchsize   Size of indexation batches. Optional.
    binary      Binary to execute: standard | genesis. Optional.
    height      Last Iris serial identifier to be indexed in job.
    mode        Compilation mode: terminal | detached. Optional.
    node        Ordinal identifier of node.

    DEFAULTS
    ----------------------------------------------------------------
    batchsize   64
    binary      standard
    height      150
    mode        terminal
    "
}

function _main()
{
    local binary=${2}
    local idx_of_node=${1}
    local height_max=${3}
    local mode=${4}
    local size_of_batch=${5}

    local binary_dir_of_node
    local binary_fpath
    local log_fpath

    # Set paths.
    binary_dir_of_node="$(get_path_to_assets_of_node "${idx_of_node}")/bin"
    if [ "${binary}" == "genesis" ]; then
        binary_fpath="${binary_dir_of_node}/iris-mpc-hawk-genesis"
    else
        binary_fpath="${binary_dir_of_node}/iris-mpc-hawk"
    fi
    log_fpath="$(get_path_to_assets_of_node "${idx_of_node}")/logs/output.log"

    # Set node config.
    source "${MPCTL}"/cmds/local/node_activate_env.sh node="${idx_of_node}" batchsize="${size_of_batch}"

    # Start in either detached or terminal mode.
    if [ "$mode" == "detached" ]; then
        if [ -f "${log_fpath}" ]
        then
            rm "${log_fpath}"
        fi
        if [ "${binary}" == "genesis" ]; then
            nohup "${binary_fpath}" --max-height="${height_max}" > "${log_fpath}" 2>&1 &
        else
            nohup "${binary_fpath}" > "${log_fpath}" 2>&1 &
        fi
    else
        if [ "${binary}" == "genesis" ]; then
            "${binary_fpath}" --max-height="${height_max}"
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
unset _MAX_HEIGHT
unset _MODE
unset _SIZE_OF_BATCH

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        batchsize) _SIZE_OF_BATCH=${VALUE} ;;
        binary) _BINARY=${VALUE} ;;
        help) _HELP="show" ;;
        height) _MAX_HEIGHT=${VALUE} ;;
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
        "${_MAX_HEIGHT:-"150"}" \
        "${_MODE:-"terminal"}" \
        "${_SIZE_OF_BATCH:-64}"
fi
