#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-services-net-aws-sm-rotate

    DESCRIPTION
    ----------------------------------------------------------------
    Rotates asymmetric key-pairs for all nodes within an MPC network.
    "
}

function _main()
{
    local idx_of_node

    log_break
    log "Rotating secret key rotation"
    log_break

    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        source "${MPCTL}"/cmds/jobs/services/node_aws_sm_rotate.sh node="${idx_of_node}"
    done

    log_break
    log "Rotating secret key rotation completed"
    log_break
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

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
