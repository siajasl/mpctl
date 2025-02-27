#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-bin-compile-server-cpu-other

    DESCRIPTION
    ----------------------------------------------------------------
    Compiles other CPU server related binaries.

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

    local build_subdir="iris-mpc-cpu"

    do_build_binary $build_subdir "hawk_main" "$build_mode"
    do_build_binary $build_subdir "hnsw_algorithm_metrics" "$build_mode"
    do_build_binary $build_subdir "hnsw_network_stats_example" "$build_mode"
    do_build_binary $build_subdir "local_hnsw" "$build_mode"
    do_build_binary $build_subdir "generate_benchmark_data" "$build_mode"
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
