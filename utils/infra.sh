#!/usr/bin/env bash

#######################################
# Builds a binary.
#######################################
function do_build_binary()
{
    local build_subdir=${1}
    local build_target=${2}
    local build_mode=${3}

    local build_path="$(get_path_to_monorepo)/$build_subdir"
    if [ ! -d "$build_path" ]; then
        log_error "Invalid build path: $build_path"
        return
    fi

    pushd $build_path
    log "Building binary: mode=$build_mode :: binary=$build_target"
    if [ "$build_mode" == "debug" ]; then
        cargo build --bin $build_target
    else
        cargo build --bin $build_target --$build_mode
    fi
    popd || exit
}
