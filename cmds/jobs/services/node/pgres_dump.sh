function _help() {
    echo "
    COMMAND
    ----------------------------------------------------------------
    mpctl-infra-node-dump-pgres-db

    DESCRIPTION
    ----------------------------------------------------------------
    Backs up a node's postgres database.

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
    local server_host=$(get_pgres_server_host)
    local server_port=$(get_pgres_server_port)
    local super_user_name=$(get_pgres_super_user_name)
    local super_user_password=$(get_pgres_super_user_password)

    log_break
    log "Node $idx_of_node: postgres dB dump begins"
    log "    dB name=${db_name}"
    log "    dB server ${server_host}:${server_port}"
    log "    dB super user=${super_user_name}"
    log "    dB dump path=${backup_dir}"

    mkdir -p ${target_dir}

    docker exec \
        -i "${MPCTL_DOCKER_CONTAINER_PGRES_DB}" /bin/bash \
        -c "PGPASSWORD=${super_user_password} pg_dump -a --inserts -U ${super_user_name} -d ${db_name}" \
        > "${backup_dir}/${db_name}.sql"

    log "Node $idx_of_node: postgres dB dump complete"
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
