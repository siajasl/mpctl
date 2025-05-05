function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-restore-pgres-db

    DESCRIPTION
    ----------------------------------------------------------------
    Restores a node's postgres database.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local idx_of_node=${1}
    local db_name
    local path_to_sql

    log_break
    log "Node $idx_of_node: postgres dB restore begins"
    log_break

    db_name=$(get_pgres_app_db_name "$idx_of_node")
    path_to_sql="${MPCTL}/data/db-backups/${db_name}.sql"

    exec_pgres_script "${db_name}" "${path_to_sql}"

    log_break
    log "Node $idx_of_node: postgres dB restore complete"
    log_break
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
