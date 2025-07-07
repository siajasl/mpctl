## Build Docket Images

```
# Build MPC node docker images.
mpctl-dkr-build-images

# Spin up services (localstack + postgres).
mpctl-dkr-services-up

# Initialise dB in readiness for genesis.
mpctl-dkr-init-db-for-genesis

# Start MPC nodes.
mpctl-dkr-net-start-genesis

```
