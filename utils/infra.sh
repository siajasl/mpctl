#!/usr/bin/env bash

##############################################################################
# Builds a binary.
##############################################################################
function do_build_binary()
{
    local build_mode=${1}
    local build_subdir=${2}
    local build_target=${3}
    local build_path

    build_path="$(get_path_to_monorepo)/${build_subdir}"
    if [ ! -d "${build_path}" ]; then
        log_error "Invalid build path: $build_path"
        return
    fi

    pushd "$build_path" || exit
    log "Compiling binary: ${build_subdir} :: ${build_target} :: ${build_mode}"
    if [ "$build_mode" == "debug" ]; then
        cargo build --bin "${build_target}"
    else
        cargo build --bin "${build_target}" --"${build_mode}"
    fi
    popd || exit
}

##############################################################################
# Returns name of application environment.
##############################################################################
function get_app_environment_name()
{
    if is_env_var_set SMPC__ENVIRONMENT; then
        echo "$SMPC__ENVIRONMENT"
    else
        echo "$MPCTL_DEFAULT_APP_ENVIRONMENT_NAME"
    fi
}
