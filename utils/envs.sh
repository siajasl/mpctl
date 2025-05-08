function load_env_of_node()
{
    local idx_of_node=${1}
    local path_to_node_env=$(get_path_to_node_env ${idx_of_node})

    pushd "${path_to_node_env}" > /dev/null
    direnv allow > /dev/null
    popd > /dev/null

    load_project_env $(get_path_to_node_env ${idx_of_node})
}

function load_project_env()
{
    local project_dir=$1

    if [[ ! -d "$project_dir" ]]; then
        echo "Error: Project directory '$project_dir' does not exist"
        return 1
    fi

    # Create a temporary file to store the environment.
    local tmpfile=$(mktemp)

    # Change to the project directory.
    pushd "$project_dir" > /dev/null

    # Allow direnv to load the .envrc if needed.
    direnv allow 2>/dev/null

    # Export the environment to the temporary file.
    direnv export bash > "${tmpfile}" > /dev/null

    # Change back to the original directory.
    popd > /dev/null

    # Source the exported environment.
    source "${tmpfile}"

    # Remove the temporary file.
    rm "${tmpfile}"

    log "Environment loaded from ${project_dir}"
}
