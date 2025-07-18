#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dkr-services-down

    DESCRIPTION
    ----------------------------------------------------------------
    Brings down base dockerised services, i.e. localstack & PostgreSQL.
    "
}

function _main()
{
    pushd "$(get_path_to_monorepo)" || exit
    docker-compose -f "${MPCTL_DKR_COMPOSE_SERVICES}" down --volumes
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
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
