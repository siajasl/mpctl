#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-bin-compile

    DESCRIPTION
    ----------------------------------------------------------------
    Compiles complete set of system binaries.

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

    _compile_client "${build_mode}"
    _compile_key_manager "${build_mode}"
    _compile_node "${build_mode}"
    _compile_other "${build_mode}"
}

function _compile_client()
{
    local build_mode=${1}

    do_build_binary "${build_mode}" "iris-mpc" "client"
}

function _compile_key_manager()
{
    local build_mode=${1}

    do_build_binary "$build_mode" "iris-mpc-common" "key-manager"
}

function _compile_node()
{
    local build_mode=${1}

    do_build_binary "$build_mode" "iris-mpc" "iris-mpc-hawk"
    do_build_binary "$build_mode" "iris-mpc-upgrade-hawk" "iris-mpc-hawk-genesis"
}

function _compile_other()
{
    local build_mode=${1}
    local -a build_targets=(
        "hawk_main"
        "hnsw_algorithm_metrics"
        "hnsw_network_stats_example"
        "init-test-dbs"
        "generate_benchmark_data"
        "local_hnsw"
    )

    for build_target in "${build_targets[@]}"
    do
        do_build_binary "$build_mode" "iris-mpc-cpu" "$build_target"
    done
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

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
