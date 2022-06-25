#!/bin/bash

KEY="mykey"
CHAINID="howell_12345678-1"
MONIKER="howell_testnet"
KEYRING="file"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
# TRACE=""

# Set moniker and chain-id for Howell (Moniker can be anything, chain-id must be an integer)
#howelld init $MONIKER --chain-id $CHAINID

# Allocate genesis accounts (cosmos formatted addresses)
#howelld add-genesis-account $KEY 100000000000000000000000000asheer --keyring-backend $KEYRING

# Sign genesis transaction
#howelld gentx $KEY 1000000000000000000000asheer --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
#howelld collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
#howelld validate-genesis
#evmosd start  --json-rpc.address"0.0.0.0:8545" --json-rpc.ws-address="0.0.0.0:8546" --evm.rpc.api="eth,web3,net,txpool,debug" --json-rpc.enable

howelld start --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable
