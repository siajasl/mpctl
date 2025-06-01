# ---------------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------------

# Default number of parties participating in MPC protocol.
declare MPCTL_COUNT_OF_PARTIES=3

# Docker compose file: Hawk main.
declare MPCTL_DOCKER_COMPOSE_HAWK="docker-compose.test.yaml"

# Docker compose file: Hawk main.
declare MPCTL_DOCKER_COMPOSE_HAWK_GENESIS="docker-compose.test.genesis.yaml"

# Docker compose file: Base services.
declare MPCTL_DOCKER_COMPOSE_SERVICES="docker-compose.dev.yaml"

# Docker container id: PostgreSQL dB.
declare MPCTL_DOCKER_CONTAINER_PGRES_DB="iris-mpc-dev_db-1"

# Docker file: Hawk main.
declare MPCTL_DOCKER_FILE_HAWK="Dockerfile.dev.hawk"

# Docker file: Hawk main.
declare MPCTL_DOCKER_FILE_HAWK_GENESIS="Dockerfile.dev.hawk"

# Docker image id: Hawk main.
declare MPCTL_DOCKER_IMAGE_HAWK="hawk-server-local-build"

# Docker image id: Hawk genesis.
declare MPCTL_DOCKER_IMAGE_HAWK_GENESIS="hawk-server-genesis"

# Name of application monorepo.
declare MPCTL_NAME_OF_MONREPO="iris-mpc"

# Names of node binaries.
declare MPCTL_NODE_BINARY_NAMES=("iris-mpc-hawk" "iris-mpc-hawk-genesis")

# ---------------------------------------------------------------------------------
# Defaults -> Misc
# ---------------------------------------------------------------------------------

# Default: name of application environment.
declare MPCTL_DEFAULT_ENVIRONMENT="dev"

# ---------------------------------------------------------------------------------
# Defaults -> AWS
# ---------------------------------------------------------------------------------

# Default: credentials.
declare MPCTL_DEFAULT_AWS_ACCESS_KEY_ID="test"
declare MPCTL_DEFAULT_AWS_SECRET_ACCESS_KEY="test"

# Default: service gateway url.
declare MPCTL_DEFAULT_AWS_ENDPOINT_URL="http://127.0.0.1:4566"

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
