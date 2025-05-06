declare IDX_OF_NODE=2

export SMPC__DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${IDX_OF_NODE}"
export SMPC__CPU_DATABASE__URL="postgres://postgres:postgres@localhost:5432/SMPC_dev_${IDX_OF_NODE}"
export SMPC__CPU_DATABASE__MIGRATE=true
export SMPC__PARTY_ID="${IDX_OF_NODE}"
export SMPC__HAWK_SERVER_HEALTHCHECK_PORT="300${IDX_OF_NODE}"
export SMPC__REQUESTS_QUEUE_URL="http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/smpcv2-${IDX_OF_NODE}-dev.fifo"
export SMPC__NODE_HOSTNAMES='["127.0.0.1","127.0.0.1","127.0.0.1"]'
