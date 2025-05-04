function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-pgres-truncate-graph

    DESCRIPTION
    ----------------------------------------------------------------
    Truncates a node's postgres database graph related tables.

    ARGS
    ----------------------------------------------------------------
    node        Ordinal identifier of node.
    "
}

function _main()
{
    local idx_of_node=${1}
    local db_name
    local path_to_sql_script
    local server_host
    local server_port
    local super_user_name

    # Activate node env.
    source "$MPCTL"/cmds/infra/node/activate_env.sh node=$idx_of_node

    db_name=$(get_pgres_app_db_name "$idx_of_node")
    server_host=$(get_pgres_server_host)
    server_port=$(get_pgres_server_port)
    super_user_name=$(get_pgres_super_user_name)
    path_to_sql_script="$MPCTL/cmds/infra/node/pgres_truncate_graph-${idx_of_node}.sql"

    log_break
    log "Node $idx_of_node: postgres dB graph tables truncation begins"
    log "    dB name=${db_name}"
    log "    dB server ${server_host}:${server_port}"
    log "    dB super user=${super_user_name}"
    log "    SQL script=${path_to_sql_script}"

    psql \
        -h "$server_host" \
        -p "$server_port" \
        -U "$super_user_name" \
        -d "$db_name" \
        -f "$path_to_sql_script"

    log "Node $idx_of_node: postgres dB graph tables truncation complete"
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
