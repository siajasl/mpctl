#!/usr/bin/env bash

function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-jobs-init-db-from-plain-text-iris-file

    DESCRIPTION
    ----------------------------------------------------------------
    Initializes database from previously generated plain text iris files.
    "
}

function _main()
{
    local skip_hnsw_graph=${1}

    # Override default values.
    export SMPC_INIT_DB_URL_PARTY_1="postgres://postgres:postgres@localhost:5432/SMPC_dev_0"
    export SMPC_INIT_DB_URL_PARTY_2="postgres://postgres:postgres@localhost:5432/SMPC_dev_1"
    export SMPC_INIT_DB_URL_PARTY_3="postgres://postgres:postgres@localhost:5432/SMPC_dev_2"
    export SMPC_INIT_PATH_TO_PRNG_STATE="$(get_path_to_assets)/data/tmp/prng_state"
    export SMPC_INIT_PATH_TO_IRIS_PLAINTEXT="$(get_path_to_assets)/data/iris-plaintext/store.ndjson"
    export SMPC_INIT_SKIP_HNSW_GRAPH="${skip_hnsw_graph}"

    pushd "$(get_path_to_monorepo)" || exit
    source "./scripts/tools/init_db_from_plaintext_iris_file.sh"
    popd || exit
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/cmds/utils/main.sh

unset _HELP
unset _SKIP_GRAPH_INSERTS

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        skip-graph-inserts) _SKIP_GRAPH_INSERTS=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "${_SKIP_GRAPH_INSERTS:-"true"}"
fi
