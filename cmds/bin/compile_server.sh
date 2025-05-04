#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-bin-compile-server-cpu

    DESCRIPTION
    ----------------------------------------------------------------
    Compiles CPU server binary.

    ARGS
    ----------------------------------------------------------------
    mode        Compilation mode: debug | release. Optional.

    DEFAULTS
    ----------------------------------------------------------------
    mode        release
    "
}

function _main()
{
    local build_mode=${1}

    do_build_binary "$build_mode" "iris-mpc" "iris-mpc-hawk"
    do_build_binary "$build_mode" "iris-mpc" "iris-mpc-hawk-genesis"
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _HELP
unset _BUILD_MODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
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
