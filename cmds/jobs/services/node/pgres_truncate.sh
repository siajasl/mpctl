function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-pgres-truncate

    DESCRIPTION
    ----------------------------------------------------------------
    Truncates a node's postgres database tables.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    group       Group of table to truncate: all | graph | iris.

    DEFAULTS
    ----------------------------------------------------------------
    group       graph
    "
}

function _main()
{
    local idx_of_node=${1}
    local table_group=${2}

    log_break
    log "Node $idx_of_node: postgres dB table truncation begins"

    if [ "${table_group:-""}" = "all" ]; then
        _do_truncation "$idx_of_node" "graph"
        _do_truncation "$idx_of_node" "iris"

    elif [ "${table_group:-""}" = "graph" ]; then
        _do_truncation "$idx_of_node" "graph"

    elif [ "${table_group:-""}" = "iris" ]; then
        _do_truncation "$idx_of_node" "iris"

    else
        log_error "Unrecognized table group: ${table_group}"
    fi

    log_break
    log "Node $idx_of_node: postgres dB table truncation complete"
}

function _do_truncation() {
    local idx_of_node=${1}
    local table_group=${2}
    local db_name
    local path_to_sql

    db_name=$(get_pgres_app_db_name "$idx_of_node")
    path_to_sql="$MPCTL/cmds/jobs/services/node/pgres_truncate_${table_group}-${idx_of_node}.sql"

    exec_pgres_script "${db_name}" "${path_to_sql}"
}

# ----------------------------------------------------------------
# ENTRY POINT
# ----------------------------------------------------------------

source "${MPCTL}/utils/main.sh"

unset _HELP
unset _IDX_OF_NODE
unset _GROUP

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)
    case "$KEY" in
        help) _HELP="show" ;;
        node) _IDX_OF_NODE=${VALUE} ;;
        group) _GROUP=${VALUE} ;;
        *)
    esac
done

if [ "${_HELP:-""}" = "show" ]; then
    _help
else
    _main "$_IDX_OF_NODE" "${_GROUP:-"graph"}"
fi
