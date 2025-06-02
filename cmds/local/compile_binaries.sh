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
    type        Binary type: all | client | key-manager | node | other. Optional.

    DEFAULTS
    ----------------------------------------------------------------
    mode        release
    type        node
    "
}

function _main()
{
    local build_mode=${1}
    local typeof=${2}

    if [ "${typeof:-""}" = "all" ]; then
        _main "${build_mode}" "client"
        _main "${build_mode}" "key-manager"
        _main "${build_mode}" "node"
        _main "${build_mode}" "other"

    elif [ "${typeof:-""}" = "client" ]; then
        _compile_client "${build_mode}"

    elif [ "${typeof:-""}" = "key-manager" ]; then
        _compile_key_manager "${build_mode}"

    elif [ "${typeof:-""}" = "node" ]; then
        _compile_node "${build_mode}"

    elif [ "${typeof:-""}" = "other" ]; then
        _compile_other "${build_mode}"

    else
        log_error "Unrecognized binary type: ${typeof}"
    fi
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

    # do_build_binary "$build_mode" "iris-mpc" "iris-mpc-hawk"
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
unset _TYPEOF

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        mode) _BUILD_MODE=${VALUE} ;;
        type) _TYPEOF=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_BUILD_MODE:-"release"}" "${_TYPEOF:-"node"}"
fi
