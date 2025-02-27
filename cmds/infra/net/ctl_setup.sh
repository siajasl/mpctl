#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-net-setup

    DESCRIPTION
    ----------------------------------------------------------------
    Sets up assets for an MPC network.
    "
}

function _main()
{
    log "MPC network setup -> begins"
    log_break

    _setup_fs
    log "Assets directory -> initialised"

    log_break
    log "MPC network setup -> ends"
}

function _setup_fs()
{
    local path_to_assets=$(get_path_to_assets)

    local path_to_node
    local idx_of_node

    mkdir -p "$path_to_assets"

    for idx_of_node in $(seq 1 "$MPCTL_COUNT_OF_PARTIES")
    do
        path_to_node="$path_to_assets"/nodes/node-"$idx_of_node"
        mkdir -p "$path_to_node"
        mkdir "$path_to_node/bin"
        mkdir "$path_to_node/config"
        mkdir "$path_to_node/keys"
        mkdir "$path_to_node/logs"
        mkdir "$path_to_node/storage"
    done
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
