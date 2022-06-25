FROM golang:stretch as build-env

# Install minimum necessary dependencies
ENV PACKAGES curl make git libc-dev bash gcc
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y $PACKAGES

# Set working directory for the build
WORKDIR /go/src/github.com/tharsis/ethermint

# Add source files
COPY . .

# build Howell
RUN make build-linux

# Final image
FROM golang:1.17 as final

WORKDIR /

RUN apt-get update

# Copy over binaries from the build-env
COPY --from=build-env /go/src/github.com/tharsis/ethermint/build/howelld /
COPY --from=build-env /go/src/github.com/tharsis/ethermint/scripts/start-docker.sh /

EXPOSE 26656 26657 1317 8545 8546

# Run howelld by default, omit entrypoint to ease using container with howelld
ENTRYPOINT ["/bin/bash", "-c"]