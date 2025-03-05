#!/usr/bin/env bash

#######################################
# Returns path to primary assets folder.
# Globals:
#   MPCTL - path to mpctl home directory.
#######################################
function get_path_to_assets()
{
    echo "${MPCTL_ASSETS:-$MPCTL/assets}"
}

#######################################
# Returns path to a node's local assets.
# Arguments:
#   Node ordinal identifier.
#######################################
function get_path_to_assets_of_node()
{
    local idx_of_node=${1}

    echo "$(get_path_to_assets)"/nodes/node-"$idx_of_node"
}

#######################################
# Returns path to compiled node binary.
# Globals:
#   CSPR_COMPILE_TARGET
#   CSPR_PATH_TO_BIN.
#######################################
function get_path_to_compiled_node()
{
    local path_to_monorepo=$(get_path_to_monorepo)

    echo $path_to_monorepo

    # local COMPILE_TARGET
    # local PATH_TO_BINARY

    # if ((${#CSPR_PATH_TO_BIN[@]})); then
    #     echo $CSPR_PATH_TO_BIN/casper-node
    # else
    #     COMPILE_TARGET=${CSPR_COMPILE_TARGET:-release}
    #     PATH_TO_BINARY="casper-node/target/$COMPILE_TARGET/casper-node"
    #     echo $(get_path_to_working_directory_file $PATH_TO_BINARY)
    # fi
}

#######################################
# Returns path to the monorepo within which solution has been developed.
#######################################
function get_path_to_monorepo()
{
    local get_path_to_parent=$(get_path_to_parent)

    echo $get_path_to_parent/$MPCTL_NAME_OF_MONREPO
}

#######################################
# Returns path to the monorepo within which solution has been developed.
#######################################
function get_path_to_monorepo_subdir()
{
    local name_of_subdir=${1}

    echo "$(get_path_to_monorepo)/$name_of_subdir"
}

#######################################
# Returns path to a node's logs directory.
# Arguments:
#   Node ordinal identifier.
#######################################
function get_path_to_node_logs()
{
    local idx_of_node=${1:-1}

    echo "$(get_path_to_assets_of_node "$idx_of_node")"/logs
}

#######################################
# Returns path to parent directory within which mpctl has been cloned.
#######################################
function get_path_to_parent()
{
    echo "$( cd "$( dirname "${MPCTL[0]}" )" && pwd )"
}

#######################################
# Returns path to a target binary.
#######################################
function get_path_to_target_binary()
{
    local name_of_binary=${1}
    local build_mode=${2}

    echo "$(get_path_to_monorepo)/target/$build_mode/$name_of_binary"
}
