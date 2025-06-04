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
    height      Last Iris serial identifier to be indexed in job.
    mode        Execution mode: terminal | detached. Optional.
    node        Ordinal identifier of node.

    DEFAULTS
    ----------------------------------------------------------------
    batchsize   64
    height      100
    mode        terminal
    "
}

function _main()
{
    local idx_of_node=${1}
    local mode=${2}
    local batch_size=${3}

    local path_to_binary
    local path_to_log

    # Set path.
    path_to_binary="$(get_path_to_assets_of_node "${idx_of_node}")/bin/iris-mpc-hawk"

    # Set env.
    source "${MPCTL}"/cmds/local/node_activate_env.sh node="${idx_of_node}" batchsize="${batch_size}"

    # Start process:
    # ... mode = terminal
    if [ "$mode" == "terminal" ]; then
        "${path_to_binary}"

    # ... mode = detached
    else
        path_to_log="$(get_path_to_assets_of_node "${idx_of_node}")/logs/output.log"
        if [ -f "${path_to_log}" ]
        then
            rm "${path_to_log}"
        fi
        nohup "${path_to_binary}" > "${path_to_log}" 2>&1 &
    fi
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _HELP
unset _IDX_OF_NODE
unset _MODE
unset _BATCH_SIZE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        batchsize) _BATCH_SIZE=${VALUE} ;;
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
        "${_IDX_OF_NODE:-0}" \
        "${_MODE:-"terminal"}" \
        "${_BATCH_SIZE:-64}"
fi
