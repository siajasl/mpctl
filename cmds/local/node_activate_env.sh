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

    source "$MPCTL/resources/envs/local.base.env"
    source "$MPCTL/resources/envs/local.node.${idx_of_node}.env"
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
