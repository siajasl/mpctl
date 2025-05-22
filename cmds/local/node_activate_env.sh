#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-activate-env

    DESCRIPTION
    ----------------------------------------------------------------
    Activates a node's environment.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local idx_of_node=${1}
    local size_of_batch=${2}

    export RUST_LOG=info
    export RUST_BACKTRACE=full
    export SMPC__ENVIRONMENT=dev
    export SMPC__SERVICE__SERVICE_NAME=smpcv2-server-dev
    export SMPC__MODE_OF_COMPUTE=CPU
    export SMPC__MODE_OF_DEPLOYMENT=STANDARD
    export SMPC__DATABASE__MIGRATE=true
    export SMPC__DATABASE__CREATE=true
    export SMPC__DATABASE__LOAD_PARALLELISM=8
    export SMPC__MAX_BATCH_SIZE=${size_of_batch}
    export SMPC__OVERRIDE_MAX_BATCH_SIZE=true
    export SMPC__MAX_DB_SIZE=10000
    export SMPC__HAWK_REQUEST_PARALLELISM=10
    export SMPC__AWS__REGION=us-east-1
    export SMPC__AWS__ENDPOINT=http://127.0.0.1:4566
    export SMPC__KMS_KEY_ARNS='["arn:aws:kms:us-east-1:000000000000:key/00000000-0000-0000-0000-000000000000","arn:aws:kms:us-east-1:000000000000:key/00000000-0000-0000-0000-000000000001","arn:aws:kms:us-east-1:000000000000:key/00000000-0000-0000-0000-000000000002"]'
    export SMPC__SERVICE_PORTS='["4000","4001","4002"]'
    export SMPC__HEALTHCHECK_PORTS='["3000","3001","3002"]'
    export SMPC__SHARES_BUCKET_NAME="wf-smpcv2-dev-sns-requests"
    export SMPC__RESULTS_TOPIC_ARN="arn:aws:sns:us-east-1:000000000000:iris-mpc-results.fifo"
    export AWS_ENDPOINT_URL=http://127.0.0.1:4566
    export AWS_ACCESS_KEY_ID=test
    export AWS_SECRET_ACCESS_KEY=test
    export AWS_REGION=us-east-1

    export SMPC__DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${idx_of_node}"
    export SMPC__CPU_DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${idx_of_node}"
    export SMPC__CPU_DATABASE__MIGRATE=true
    export SMPC__PARTY_ID="${idx_of_node}"
    export SMPC__HAWK_SERVER_HEALTHCHECK_PORT="300${idx_of_node}"
    export SMPC__REQUESTS_QUEUE_URL="http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/smpcv2-${idx_of_node}-dev.fifo"
    export SMPC__NODE_HOSTNAMES='["127.0.0.1","127.0.0.1","127.0.0.1"]'

    # TODO: deterimine how to correctly use direnv.
    # load_project_env "$(get_path_to_assets_of_node ${idx_of_node})/env"
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _HELP
unset _IDX_OF_NODE
unset _SIZE_OF_BATCH

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        batchsize) _SIZE_OF_BATCH=${VALUE} ;;
        help) _HELP="show" ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main \
        "${_IDX_OF_NODE}" \
        "${_SIZE_OF_BATCH:-64}"
fi
