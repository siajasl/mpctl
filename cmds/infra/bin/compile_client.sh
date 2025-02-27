#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-bin-compile-client

    DESCRIPTION
    ----------------------------------------------------------------
    Compiles client binary.

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
    local mode=${1}
    local path_to_monorepo="$(get_path_to_monorepo)"
    local path_to_build="$path_to_monorepo/iris-mpc"

    if [ ! -d "$path_to_monorepo" ]; then
        log "ERROR: monorepo must be cloned into $(get_path_to_parent) before compilation can occur"
    else
        if [ ! -d "$path_to_build" ]; then
            log "ERROR: invalid build path: $path_to_build"
        else
            pushd $path_to_build
            if [ "$mode" = "debug" ]; then
                cargo build --bin client
            else
                cargo build --bin client --release
            fi
            popd || exit
        fi
    fi
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _HELP
unset _MODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        mode) _MODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_MODE:-"release"}"
fi
