#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-net-pgres-truncate

    DESCRIPTION
    ----------------------------------------------------------------
    Truncates a network's postgres database tables.
    "
}

function _main()
{
    local idx_of_node

    log_break
    log "Network postgres dB tables truncation begins"
    log_break

    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        source "$MPCTL"/cmds/infra/node/pgres_truncate.sh node=$idx_of_node
    done

    log_break
    log "Network postgres dB tables truncation complete"
    log_break
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
