#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-ls | mpctl-dev-view-commands

    DESCRIPTION
    ----------------------------------------------------------------
    Displays set of supported commands.
    "
}

function _main()
{
    echo "
    mpctl-dev-apply-linter

    mpctl-dkr-build-image
    mpctl-dkr-net-down
    mpctl-dkr-net-start
    mpctl-dkr-net-stop
    mpctl-dkr-net-up
    mpctl-dkr-net-view-status
    mpctl-dkr-node-start
    mpctl-dkr-node-stop
    mpctl-dkr-services-down
    mpctl-dkr-services-up

    mpctl-local-compile-binaries
    mpctl-local-net-setup
    mpctl-local-net-start
    mpctl-local-net-start-genesis
    mpctl-local-net-teardown
    mpctl-local-node-activate-env
    mpctl-local-node-start
    mpctl-local-node-start-genesis
    mpctl-local-node-update-binaries
    mpctl-local-node-view-logs

    mpctl-services-aws-sm-rotate-keys
    mpctl-services-pgres-dump
    mpctl-services-pgres-restore
    mpctl-services-pgres-truncate-graph-tables
    mpctl-services-pgres-truncate-iris-tables
    mpctl-services-pgres-truncate-state-tables

    mpctl-testing-generate-iris-serial-ids-for-deletion
    mpctl-testing-init-db-from-plain-text-iris-file
    mpctl-testing-init-plain-text-iris-file
    "
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

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
