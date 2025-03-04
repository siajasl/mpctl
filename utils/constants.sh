#!/usr/bin/env bash

# ---------------------------------------------------------------------------------
# AWS
# ---------------------------------------------------------------------------------

# Credentials.
declare MPCTL_AWS_ACCESS_KEY_ID=test
declare MPCTL_AWS_SECRET_ACCESS_KEY=test

# Endpoint over which services such as SQS will be accessed.
declare MPCTL_AWS_ENDPOINT_URL=http://127.0.0.1:4566

# Default region within which AWS services will run.
declare MPCTL_AWS_REGION="us-east-1"

# ---------------------------------------------------------------------------------
# Other
# ---------------------------------------------------------------------------------

# Default number of parties participating in MPC protocol.
declare MPCTL_COUNT_OF_PARTIES=3

# Name of application monorepo.
declare MPCTL_NAME_OF_MONREPO="iris-mpc"
