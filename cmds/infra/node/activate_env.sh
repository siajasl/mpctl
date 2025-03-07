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
    local idx_of_node=${1}

    # TODO: Review set of environment variables.

    # AWS
    export AWS_ENDPOINT_URL=http://127.0.0.1:4566
    export AWS_ACCESS_KEY_ID=test
    export AWS_SECRET_ACCESS_KEY=test
    export AWS_REGION=$MPCTL_DEFAULT_AWS_REGION

    # SMPC
    export SMPC__ENVIRONMENT=dev
    export SMPC__DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${idx_of_node}"
    export SMPC__PARTY_ID="${idx_of_node}"
    export SMPC__AWS__ENDPOINT="http://127.0.0.1:4566"
    export SMPC__REQUESTS_QUEUE_URL="http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/smpcv2-${idx_of_node}-dev.fifo"
    export SMPC__NODE_HOSTNAMES='["127.0.0.1","127.0.0.1","127.0.0.1"]'
    export SMPC__HAWK_SERVER_HEALTHCHECK_PORT="300${idx_of_node}"
    export SMPC__MODE_OF_COMPUTE="CPU"
    export SMPC__MODE_OF_DEPLOYMENT="STANDARD"
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
