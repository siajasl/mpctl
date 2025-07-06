#!/usr/bin/env bash

# Default credentials of application user.
export MPCTL_DEFAULT_PGRES_APP_USER_NAME="postgres"
export MPCTL_DEFAULT_PGRES_APP_USER_PASSWORD="postgres"

# Default credentials of super user.
export MPCTL_DEFAULT_PGRES_SUPER_USER_NAME="postgres"
export MPCTL_DEFAULT_PGRES_SUPER_USER_PASSWORD="postgres"

# Default server host/port.
export MPCTL_DEFAULT_PGRES_SERVER_HOST="localhost"
export MPCTL_DEFAULT_PGRES_SERVER_PORT=5432

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
