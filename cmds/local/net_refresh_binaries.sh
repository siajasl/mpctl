#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-local-net-refresh-binaries

    DESCRIPTION
    ----------------------------------------------------------------
    Refreshes binary set of a local bare metal MPC network.
    "
}

function _main()
{
    local build_mode=${1}
    local idx_of_node

    log_break
    log "MPC network :: refreshing binaries"
    log_break

    source "${MPCTL}"/cmds/local/compile_server.sh mode="${build_mode}"
    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        source "${MPCTL}"/cmds/local/node_refresh_binaries.sh node="${idx_of_node}" compile="false"
    done

    log_break
    log "MPC network :: refreshed binaries"
    log_break
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _BUILD_MODE
unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        mode) _BUILD_MODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_BUILD_MODE:-"release"}"
fi
