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

    local backup_dir="$(get_path_to_assets)/data/db-backups"
    local db_name=$(get_pgres_app_db_name "$idx_of_node")

    log_break
    log "Node $idx_of_node: postgres dB restore begins"
    log_break

    exec_pgres_script "${db_name}" "${backup_dir}/${db_name}.sql"

    log_break
    log "Node $idx_of_node: postgres dB restore complete"
    log_break
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}"/utils/main.sh

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
