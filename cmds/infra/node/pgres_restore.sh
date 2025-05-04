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
    local path_to_dump
    local server_host
    local server_port
    local super_user_name
    local docker_container_id="iris-mpc-dev_db-1"

    # Activate node env.
    source "$MPCTL"/cmds/infra/node/activate_env.sh node=$idx_of_node

    db_name=$(get_pgres_app_db_name "$idx_of_node")
    server_host=$(get_pgres_server_host)
    server_port=$(get_pgres_server_port)
    super_user_name=$(get_pgres_super_user_name)
    path_to_dump="${MPCTL}/data/db_backups/${db_name}.tar.gz"

    log_break
    log "Node $idx_of_node: postgres dB restore begins"
    log "    dB name=${db_name}"
    log "    dB server ${server_host}:${server_port}"
    log "    dB super user=${super_user_name}"
    log "    dB restore path=${path_to_dump}"

    log "Enter dB super-user password"
    pg_restore \
        -v \
        -f ${path_to_dump} \
        -h ${server_host} \
        -p ${server_port} \
        -U ${super_user_name}

    docker exec \
    -i "${docker_container_id}" /bin/bash \
        -c "PGPASSWORD=${super_user_password} psql --username ${super_user_name} ${db_name}" \
        < ${path_to_dump}

    log "Node $idx_of_node: postgres dB restore complete"
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
