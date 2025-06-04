#!/usr/bin/env bash

# ---------------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------------

# Default number of parties participating in MPC protocol.
export MPCTL_COUNT_OF_PARTIES=3

# Docker compose file: Hawk main.
export MPCTL_DOCKER_COMPOSE_HAWK="docker-compose.test.yaml"

# Docker compose file: Hawk main.
export MPCTL_DOCKER_COMPOSE_HAWK_GENESIS="docker-compose.test.genesis.yaml"

# Docker compose file: Base services.
export MPCTL_DOCKER_COMPOSE_SERVICES="docker-compose.dev.yaml"

# Docker container id: PostgreSQL dB.
export MPCTL_DOCKER_CONTAINER_PGRES_DB="iris-mpc-dev_db-1"

# Docker file: Hawk main.
export MPCTL_DOCKER_FILE_HAWK="Dockerfile.dev.hawk"

# Docker file: Hawk main.
export MPCTL_DOCKER_FILE_HAWK_GENESIS="Dockerfile.dev.hawk"

# Docker image id: Hawk main.
export MPCTL_DOCKER_IMAGE_HAWK="hawk-server-local-build"

# Docker image id: Hawk genesis.
export MPCTL_DOCKER_IMAGE_HAWK_GENESIS="hawk-server-genesis"

# Name of application monorepo.
export MPCTL_NAME_OF_MONREPO="iris-mpc"

# Names of node binaries.
export -a MPCTL_NODE_BINARY_NAMES=("iris-mpc-hawk" "iris-mpc-hawk-genesis")

# ---------------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------------

# Default: name of application environment.
export MPCTL_DEFAULT_ENVIRONMENT="dev"

# Default: AWS :: credentials.
export MPCTL_DEFAULT_AWS_ACCESS_KEY_ID="test"
export MPCTL_DEFAULT_AWS_SECRET_ACCESS_KEY="test"

# Default: AWS :: service gateway url.
export MPCTL_DEFAULT_AWS_ENDPOINT_URL="http://127.0.0.1:4566"

# Default: AWS :: service region.
export MPCTL_DEFAULT_AWS_REGION="us-east-1"

# Default: PGRES :: credentials.
export MPCTL_DEFAULT_PGRES_APP_USER_NAME="postgres"
export MPCTL_DEFAULT_PGRES_APP_USER_PASSWORD="postgres"
export MPCTL_DEFAULT_PGRES_SUPER_USER_NAME="postgres"
export MPCTL_DEFAULT_PGRES_SUPER_USER_PASSWORD="postgres"

# Default: PGRES :: server host.
export MPCTL_DEFAULT_PGRES_SERVER_HOST="localhost"

# Default: PGRES :: server port.
export MPCTL_DEFAULT_PGRES_SERVER_PORT=5432

# ---------------------------------------------------------------------------------
# Computed
# ---------------------------------------------------------------------------------

##############################################################################
# Returns AWS access key ID.
##############################################################################
function get_aws_access_key_id()
{
    if is_env_var_set "AWS_ACCESS_KEY_ID"; then
        echo "${AWS_ACCESS_KEY_ID}"
    else
        echo "$MPCTL_DEFAULT_AWS_ACCESS_KEY_ID"
    fi
}

##############################################################################
# Returns AWS endpoint URL.
##############################################################################
function get_aws_endpoint_url()
{
    if is_env_var_set "AWS_ENDPOINT_URL"; then
        echo "${AWS_ENDPOINT_URL}"
    else
        echo "${MPCTL_DEFAULT_AWS_ENDPOINT_URL}"
    fi
}

##############################################################################
# Returns AWS region.
##############################################################################
function get_aws_region()
{
    if is_env_var_set "AWS_REGION"; then
        echo "${AWS_REGION}"
    else
        echo "${MPCTL_DEFAULT_AWS_REGION}"
    fi
}

##############################################################################
# Returns AWS secret access key.
##############################################################################
function get_aws_secret_access_key()
{
    if is_env_var_set "AWS_SECRET_ACCESS_KEY"; then
        echo "${AWS_SECRET_ACCESS_KEY}"
    else
        echo "${MPCTL_DEFAULT_AWS_SECRET_ACCESS_KEY}"
    fi
}

##############################################################################
# Returns name of current environment.
##############################################################################
function get_environment_name()
{
    if is_env_var_set "SMPC__ENVIRONMENT"; then
        echo "${SMPC__ENVIRONMENT}"
    else
        echo "${MPCTL_DEFAULT_ENVIRONMENT}"
    fi
}

##############################################################################
# Returns postgres app user name.
##############################################################################
function get_pgres_app_user_name()
{
    if is_env_var_set "SMPC__PGRES_APP_USER_NAME"; then
        echo "${SMPC__PGRES_APP_USER_NAME}"
    else
        echo "${MPCTL_DEFAULT_PGRES_APP_USER_NAME}"
    fi
}

##############################################################################
# Returns postgres app user password.
##############################################################################
function get_pgres_app_user_password()
{
    if is_env_var_set "SMPC__PGRES_APP_USER_PASSWORD"; then
        echo "${SMPC__PGRES_APP_USER_PASSWORD}"
    else
        echo "${MPCTL_DEFAULT_PGRES_APP_USER_PASSWORD}"
    fi
}

##############################################################################
# Returns postgres database server host.
##############################################################################
function get_pgres_server_host()
{
    if is_env_var_set "SMPC__PGRES_SERVER_HOST"; then
        echo "${SMPC__PGRES_SERVER_HOST}"
    else
        echo "${MPCTL_DEFAULT_PGRES_SERVER_HOST}"
    fi
}

##############################################################################
# Returns postgres database server port.
##############################################################################
function get_pgres_server_port()
{
    if is_env_var_set "SMPC__PGRES_SERVER_PORT"; then
        echo "${SMPC__PGRES_SERVER_PORT}"
    else
        echo "${MPCTL_DEFAULT_PGRES_SERVER_PORT}"
    fi
}

##############################################################################
# Returns postgres database super user name.
##############################################################################
function get_pgres_super_user_name()
{
    if is_env_var_set "SMPC__PGRES_SUPER_USER_NAME"; then
        echo "${SMPC__PGRES_SUPER_USER_NAME}"
    else
        echo "${MPCTL_DEFAULT_PGRES_SUPER_USER_NAME}"
    fi
}

##############################################################################
# Returns postgres database super user password.
##############################################################################
function get_pgres_super_user_password()
{
    if is_env_var_set "SMPC__PGRES_SUPER_USER_PASSWORD"; then
        echo "${SMPC__PGRES_SUPER_USER_PASSWORD}"
    else
        echo "${MPCTL_DEFAULT_PGRES_SUPER_USER_PASSWORD}"
    fi
}
