#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-net-setup

    DESCRIPTION
    ----------------------------------------------------------------
    Sets up assets for an MPC network.
    "
}

function _main()
{
    log_break
    log "MPC network setup :: begins"

    _setup_fs
    log "    assets directory created"

    _setup_config_of_net
    log "    environment files assigned"

    _setup_binaries
    log "    binaries assigned"

    _setup_keys
    log "    secret keys initialised"

    log "MPC network setup :: ends"
    log_break
}

##############################################################################
# Initialises a networks's binary files.
##############################################################################
function _setup_binaries()
{
    local idx_of_node
    local path_to_assets_of_net
    local path_to_assets_of_node

    # Compile binary set.
    source "${MPCTL}/cmds/local/compile.sh"

    # Copy network wide binaries.
    path_to_assets_of_net=$(get_path_to_assets_of_net)
    cp \
        "$(get_path_to_target_binary "client" "release")" \
        "${path_to_assets_of_net}/bin"
    cp \
        "$(get_path_to_target_binary "key-manager" "release")" \
        "${path_to_assets_of_net}/bin"

    # Copy node specific binaries.
    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        path_to_assets_of_node="$(get_path_to_assets_of_node "${idx_of_node}")"
        cp \
            "$(get_path_to_target_binary "iris-mpc-hawk" "release")" \
            "${path_to_assets_of_node}/bin"
        cp \
            "$(get_path_to_target_binary "iris-mpc-hawk-genesis" "release")" \
            "${path_to_assets_of_node}/bin"
    done
}

##############################################################################
# Initialises a networks's configuration files.
##############################################################################
function _setup_config_of_net()
{
    local idx_of_node

    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        _setup_config_of_node "${idx_of_node}"
    done
}

##############################################################################
# Initialises a node's configuration files.
##############################################################################
function _setup_config_of_node()
{
    local idx_of_node=${1}
    local path_to_assets_of_node

    path_to_assets_of_node="$(get_path_to_assets_of_node "${idx_of_node}")"

    # Env vars.
    cp \
        "$(get_path_to_resources)/envs/direnv.toml" \
        "${path_to_assets_of_node}/env"
    cp \
        "$(get_path_to_resources)/envs/.envrc" \
        "${path_to_assets_of_node}/env"
    cp \
        "$(get_path_to_resources)/envs/local.base.env" \
        "${path_to_assets_of_node}/env/base.env"
    cp \
        "$(get_path_to_resources)/envs/local.node.${idx_of_node}.env" \
        "${path_to_assets_of_node}/env/node.env"
}

##############################################################################
# Initialises filesystem network assets.
##############################################################################
function _setup_fs()
{
    local idx_of_node
    local path_to_assets_of_node

    mkdir -p "$(get_path_to_assets_of_net)/bin"
    for idx_of_node in $(seq 0 "$((MPCTL_COUNT_OF_PARTIES - 1))")
    do
        path_to_assets_of_node="$(get_path_to_assets_of_node "${idx_of_node}")"
        mkdir -p "${path_to_assets_of_node}/bin"
        mkdir "${path_to_assets_of_node}/env"
        mkdir "${path_to_assets_of_node}/logs"
    done
}

##############################################################################
# Executes key-manager in order to generate rotating keys for each node within AWS KMS.
##############################################################################
function _setup_keys()
{
    source ${MPCTL}/cmds/jobs/services/aws_sm_rotate.sh

    # export AWS_ACCESS_KEY_ID="$(get_aws_access_key_id)"
    # export AWS_ENDPOINT_URL="$(get_aws_endpoint_url)"
    # export AWS_REGION="$(get_aws_region)"
    # export AWS_SECRET_ACCESS_KEY="$(get_aws_secret_access_key)"

    # echo $AWS_ACCESS_KEY_ID
    # echo $AWS_ENDPOINT_URL
    # echo $AWS_REGION
    # echo $AWS_SECRET_ACCESS_KEY

    # source $(get_path_to_monorepo)/scripts/tools/init-servers.sh
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _HELP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main
fi
