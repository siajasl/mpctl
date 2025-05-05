#!/usr/bin/env bash

# ---------------------------------------------------------------------------------
# Defaults -> Misc
# ---------------------------------------------------------------------------------

# Default: name of application environment.
declare MPCTL_DEFAULT_APP_ENVIRONMENT_NAME="dev"

# ---------------------------------------------------------------------------------
# Defaults -> AWS
# ---------------------------------------------------------------------------------

# Default: credentials.
declare MPCTL_DEFAULT_AWS_ACCESS_KEY_ID=test
declare MPCTL_DEFAULT_AWS_SECRET_ACCESS_KEY=test

# Default: service gateway host.
declare MPCTL_DEFAULT_AWS_ENDPOINT_HOST="http://127.0.0.1"

# Default: service gateway port.
declare MPCTL_DEFAULT_AWS_ENDPOINT_PORT=4566

# Default: service region.
declare MPCTL_DEFAULT_AWS_REGION="us-east-1"

# ---------------------------------------------------------------------------------
# Defaults -> PostgreSQL
# ---------------------------------------------------------------------------------

# Default: credentials.
declare MPCTL_DEFAULT_PGRES_APP_USER_NAME="postgres"
declare MPCTL_DEFAULT_PGRES_APP_USER_PASSWORD="postgres"
declare MPCTL_DEFAULT_PGRES_SUPER_USER_NAME="postgres"
declare MPCTL_DEFAULT_PGRES_SUPER_USER_PASSWORD="postgres"

# Default: server host.
declare MPCTL_DEFAULT_PGRES_SERVER_HOST="localhost"

# Default: server port.
declare MPCTL_DEFAULT_PGRES_SERVER_PORT=5432
