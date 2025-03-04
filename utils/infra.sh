#!/usr/bin/env bash

#######################################
# Builds a binary.
#######################################
function do_build_binary()
{
    local build_mode=${1}
    local build_subdir=${2}
    local build_target=${3}

    local build_path="$(get_path_to_monorepo)/$build_subdir"
    if [ ! -d "$build_path" ]; then
        log_error "Invalid build path: $build_path"
        return
    fi

    pushd $build_path
    log "Compiling binary: $build_subdir :: $build_target :: $build_mode"
    if [ "$build_mode" == "debug" ]; then
        cargo build --bin $build_target
    else
        cargo build --bin $build_target --$build_mode
    fi
    popd || exit
}
