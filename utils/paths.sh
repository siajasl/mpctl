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
# Returns path to compiled client binary.
# Globals:
#   CSPR_COMPILE_TARGET
#   CSPR_PATH_TO_BIN
#######################################
function get_path_to_compiled_client()
{
    local COMPILE_TARGET
    local PATH_TO_BINARY

    if ((${#CSPR_PATH_TO_BIN[@]})); then
        echo $CSPR_PATH_TO_BIN/casper-client
    else
        COMPILE_TARGET=${CSPR_COMPILE_TARGET:-release}
        PATH_TO_BINARY="casper-client-rs/target/$COMPILE_TARGET/casper-client"
        echo $(get_path_to_working_directory_file $PATH_TO_BINARY)
    fi
}

#######################################
# Returns path to compiled node binary.
# Globals:
#   CSPR_COMPILE_TARGET
#   CSPR_PATH_TO_BIN.
#######################################
function get_path_to_compiled_node()
{
    local COMPILE_TARGET
    local PATH_TO_BINARY

    if ((${#CSPR_PATH_TO_BIN[@]})); then
        echo $CSPR_PATH_TO_BIN/casper-node
    else
        COMPILE_TARGET=${CSPR_COMPILE_TARGET:-release}
        PATH_TO_BINARY="casper-node/target/$COMPILE_TARGET/casper-node"
        echo $(get_path_to_working_directory_file $PATH_TO_BINARY)
    fi
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
# Returns path to a node's local assets.
# Arguments:
#   Node ordinal identifier.
#######################################
function get_path_to_node()
{
    local node_id=${1:-1}

    echo "$(get_path_to_assets)"/nodes/node-"$node_id"
}

#######################################
# Returns path to client binary.
#######################################
function get_path_to_node_client()
{
    echo "$(get_path_to_assets)"/bin/casper-client
}

#######################################
# Returns path to a node's logs directory.
# Arguments:
#   Node ordinal identifier.
#######################################
function get_path_to_node_logs()
{
    local node_id=${1:-1}

    echo "$(get_path_to_node "$node_id")"/logs
}

#######################################
# Returns path to parent directory within which mpctl has been cloned.
#######################################
function get_path_to_parent()
{
    echo "$( cd "$( dirname "${MPCTL[0]}" )" && pwd )"
}
