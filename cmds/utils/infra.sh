#!/usr/bin/env bash

##############################################################################
# Builds a binary.
##############################################################################
function do_build_binary()
{
    local build_mode=${1}
    local build_path
    local build_subdir=${2}
    local build_target=${3}

    build_path="$(get_path_to_monorepo)"
    if [ ! -d "${build_path}" ]; then
        log_error "Invalid build path: $build_path"
        return
    fi

    log "Compiling binary: ${build_subdir} :: ${build_target} :: ${build_mode}"

    pushd "${build_path}" || exit
    if [ "${build_mode}" == "debug" ]; then
        cargo build --bin "${build_target}"
    else
        cargo build --bin "${build_target}" --"${build_mode}"
    fi
    popd || exit
}
