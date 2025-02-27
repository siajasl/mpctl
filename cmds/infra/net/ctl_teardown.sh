#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-net-teardown

    DESCRIPTION
    ----------------------------------------------------------------
    Tears down assets for an MPC network.
    "
}

function _main()
{
    log "Network teardown :: begins"
    log_break

    _teardown_processes
    log "Network processes :: stopped"

    _teardown_services
    log "Network services :: stopped"

    _teardown_assets
    log "Network assets :: deleted"

    log_break
    log "Network teardown :: complete"
}

function _teardown_assets()
{
    local path_to_assets=$(get_path_to_assets)

    if [ -d "$path_to_assets" ]; then
        rm -rf "$path_to_assets"
    fi
}

function _teardown_processes()
{
    echo "TODO: _teardown_processes"
}

function _teardown_services()
{
    echo "TODO: _teardown_services"
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
