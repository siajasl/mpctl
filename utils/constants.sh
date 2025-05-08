#!/usr/bin/env bash

# Default number of parties participating in MPC protocol.
declare MPCTL_COUNT_OF_PARTIES=3

# Name of application monorepo.
declare MPCTL_NAME_OF_MONREPO="iris-mpc"

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
