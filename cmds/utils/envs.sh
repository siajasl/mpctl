#!/usr/bin/env bash

function load_env_of_node()
{
    local idx_of_node=${1}
    local path_to_node_env

    path_to_node_env="$(get_path_to_node_env "${idx_of_node}")"

    pushd "${path_to_node_env}" || exit
    direnv allow > /dev/null
    popd || exit

    load_project_env "$(get_path_to_node_env "${idx_of_node}")"
}

function load_project_env()
{
    local project_dir=$1
    local tmpfile

    if [[ ! -d "$project_dir" ]]; then
        echo "Error: Project directory '$project_dir' does not exist"
        return 1
    fi

    # Create a temporary file to store the environment.
    tmpfile=$(mktemp)

    # Change to the project directory.
    pushd "$project_dir" || exit

    # Allow direnv to load the .envrc if needed.
    direnv allow 2>/dev/null

    # Export the environment to the temporary file.
    direnv export bash > "${tmpfile}" || exit

    # Change back to the original directory.
    popd || exit

    # Source the exported environment.
    source "${tmpfile}"

    # Remove the temporary file.
    rm "${tmpfile}"

    log "Environment loaded from ${project_dir}"
}
