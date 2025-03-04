function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-activate-env

    DESCRIPTION
    ----------------------------------------------------------------
    Activates a node's environment variables.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local node_idx=${1}

    # TODO: Review set of environment variables.

    # AWS
    export AWS_ENDPOINT_URL=http://127.0.0.1:4566
    export AWS_ACCESS_KEY_ID=test
    export AWS_SECRET_ACCESS_KEY=test
    export AWS_REGION=$MPCTL_AWS_REGION

    # SMPC
    export SMPC__ENVIRONMENT=dev
    export SMPC__DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${node_idx}"
    export SMPC__PARTY_ID="${node_idx}"
    export SMPC__AWS__ENDPOINT="http://127.0.0.1:4566"
    export SMPC__REQUESTS_QUEUE_URL="http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/smpcv2-${node_idx}-dev.fifo"
    export SMPC__NODE_HOSTNAMES='["127.0.0.1","127.0.0.1","127.0.0.1"]'
    export SMPC__HAWK_SERVER_HEALTHCHECK_PORT="300${node_idx}"
    export SMPC__MODE_OF_COMPUTE="CPU"
    export SMPC__MODE_OF_DEPLOYMENT="STANDARD"
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "$MPCTL"/utils/main.sh

unset _HELP
unset _NODE_ID

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        node) _NODE_ID=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "$_NODE_ID"
fi
