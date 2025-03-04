#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-bin-compile-other

    DESCRIPTION
    ----------------------------------------------------------------
    Compiles other server related binaries.

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

    declare -a build_targets=(
        "hawk-genesis-indexer"
        "hawk_main"
        "hnsw_algorithm_metrics"
        "hnsw_network_stats_example"
        "local_hnsw"
        "generate_benchmark_data"
    )

    for build_target in "${build_targets[@]}"
    do
        do_build_binary "$build_mode" "$build_subdir" "$build_target"
    done
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
