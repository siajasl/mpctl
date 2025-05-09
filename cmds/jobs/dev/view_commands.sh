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
    mpctl-dev-view-commands

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

    mpctl-local-compile
    mpctl-local-compile-client
    mpctl-local-compile-key-manager
    mpctl-local-compile-other
    mpctl-local-compile-server
    mpctl-local-net-setup
    mpctl-local-net-teardown
    mpctl-local-node-activate-env
    mpctl-local-node-start
    mpctl-local-node-view-logs

    mpctl-services-aws-sm-rotate-keys
    mpctl-services-pgres-dump
    mpctl-services-pgres-restore
    mpctl-services-pgres-truncate

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
