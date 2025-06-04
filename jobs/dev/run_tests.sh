#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-dev-run-tests

    DESCRIPTION
    ----------------------------------------------------------------
    Runs unit tests.

    ARGS
    ----------------------------------------------------------------
    filter      Filter to determine which tests to run.

    DEFAULTS
    ----------------------------------------------------------------
    filter      none
    "
}

function _main()
{
    local test_filter=${1}

    pushd "$(get_path_to_monorepo)" || exit

    if [ "${test_filter}" = "none" ]; then
        cargo test --release
    else
        cargo test --release "${test_filter}"
    fi
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

unset _FILTER
unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    case "$KEY" in
        filter) _FILTER=${VALUE} ;;
        help) _HELP="show" ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_FILTER:-"none"}"
fi
