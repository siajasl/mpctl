#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-rotate

    DESCRIPTION
    ----------------------------------------------------------------
    Rotates asymmetric key-pairs for a node within an MPC network.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local idx_of_node=${1}

    log_break
    log "Rotating keys for node $idx_of_node"
    log_break

    # Activate node env.
    source "$MPCTL"/cmds/infra/node/activate_env.sh node=$idx_of_node

    # Rotate keys via AWS KMS.
    pushd "$(get_path_to_monorepo)" || exit
    cargo run --bin \
        key-manager -- \
            --region $MPCTL_DEFAULT_AWS_REGION \
            --node-id $idx_of_node \
            --env dev \
        rotate \
            --public-key-bucket-name wf-dev-public-keys
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _HELP
unset _IDX_OF_NODE

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "$_IDX_OF_NODE"
fi
