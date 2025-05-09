#!/usr/bin/env bash

##############################################################################
# Returns AWS access key ID.
##############################################################################
function get_aws_access_key_id()
{
    if is_env_var_set AWS_ACCESS_KEY_ID; then
        echo "$MPCTL_DEFAULT_AWS_ACCESS_KEY_ID"
    else
        echo "$MPCTL_DEFAULT_AWS_ACCESS_KEY_ID"
    fi
}

##############################################################################
# Returns AWS endpoint URL.
##############################################################################
function get_aws_endpoint_url()
{
    if is_env_var_set AWS_ENDPOINT_URL; then
        echo "$AWS_ENDPOINT_URL"
    else
        echo "${MPCTL_DEFAULT_AWS_ENDPOINT_URL}"
    fi
}

##############################################################################
# Returns AWS region.
##############################################################################
function get_aws_region()
{
    if is_env_var_set AWS_REGION; then
        echo "$AWS_REGION"
    else
        echo "${MPCTL_DEFAULT_AWS_REGION}"
    fi
}

##############################################################################
# Returns AWS secret access key.
##############################################################################
function get_aws_secret_access_key()
{
    if is_env_var_set AWS_SECRET_ACCESS_KEY; then
        echo "$AWS_SECRET_ACCESS_KEY"
    else
        echo "$MPCTL_DEFAULT_AWS_SECRET_ACCESS_KEY"
    fi
}
