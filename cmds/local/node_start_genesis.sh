#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-local-node-start-genesis

    DESCRIPTION
    ----------------------------------------------------------------
    Starts an MPC genesis node on bare metal.

    ARGS
    ----------------------------------------------------------------
    batchsize   Size of indexation batches. Optional.
    height      Last Iris serial identifier to be indexed in job.
    mode        Compilation mode: terminal | detached. Optional.
    node        Ordinal identifier of node.

    DEFAULTS
    ----------------------------------------------------------------
    batchsize   64
    height      150
    mode        terminal
    "
}

function _main()
{
    local idx_of_node=${1}
    local height_max=${2}
    local mode=${3}
    local size_of_batch=${4}

    local path_to_binary
    local path_to_log

    # Set path.
    path_to_binary="$(get_path_to_assets_of_node "${idx_of_node}")/bin/iris-mpc-hawk-genesis"

    # Set env.
    source "${MPCTL}"/cmds/local/node_activate_env.sh node="${idx_of_node}" batchsize="${size_of_batch}"

    # Start process:
    # ... mode = terminal
    if [ "$mode" == "terminal" ]; then
        "${path_to_binary}" --max-height="${height_max}" --perform-snapshot="false"
    # ... mode = detached
    else
        path_to_log="$(get_path_to_assets_of_node "${idx_of_node}")/logs/output.log"
        if [ -f "${path_to_log}" ]
        then
            rm "${path_to_log}"
        fi
        nohup "${path_to_binary}" --max-height="${height_max}" --perform-snapshot="false" > "${path_to_log}" 2>&1 &
    fi
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

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
        "${_MAX_HEIGHT:-"150"}" \
        "${_MODE:-"terminal"}" \
        "${_SIZE_OF_BATCH:-64}"
fi
