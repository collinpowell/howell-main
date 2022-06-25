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


howelld config keyring-backend $KEYRING
howelld config chain-id $CHAINID

# if $KEY exists it should be deleted
howelld keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Howell (Moniker can be anything, chain-id must be an integer)
howelld init $MONIKER --chain-id $CHAINID

# Allocate genesis accounts (cosmos formatted addresses)
howelld add-genesis-account $KEY 10000000000000000000000000stake,100000000000000000000000000asheer --keyring-backend $KEYRING

# Sign genesis transaction
howelld gentx $KEY 1000000000000000000000stake --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
howelld collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
howelld validate-genesis

howelld start --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable --json-rpc.address="0.0.0.0:8545" --json-rpc.ws-address="0.0.0.0:8546" --api.enabled-unsafe-cors                         


#howelld keys export mykey --unsafe --unarmored-hex

# Change parameter token denominations to asheer
#cat $HOME/.ethermint/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.ethermint/config/tmp_genesis.json && mv $HOME/.ethermint/config/tmp_genesis.json $HOME/.ethermint/config/genesis.json
#cat $HOME/.ethermint/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="asheer"' > $HOME/.ethermint/config/tmp_genesis.json && mv $HOME/.ethermint/config/tmp_genesis.json $HOME/.ethermint/config/genesis.json
#cat $HOME/.ethermint/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="asheer"' > $HOME/.ethermint/config/tmp_genesis.json && mv $HOME/.ethermint/config/tmp_genesis.json $HOME/.ethermint/config/genesis.json
#cat $HOME/.ethermint/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="asheer"' > $HOME/.ethermint/config/tmp_genesis.json && mv $HOME/.ethermint/config/tmp_genesis.json $HOME/.ethermint/config/genesis.json
