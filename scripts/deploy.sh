#!/usr/bin/env bash

set -eo pipefail

# import the deployment helpers
. $(dirname $0)/common.sh

# Deploy.
#TokenAddr=$(deploy Token)
#log "Token deployed at:" $TokenAddr
TokenAddr="0x61487d9F293eeeD1607c8049243d946Ed61621Fb"

NFTAddr=$(deploy NFT)
log "NFT deployed at:" $NFTAddr

TicTacTokenAddr=$(deploy TicTacToken $TokenAddr $NFTAddr)
log "TicTacToken deployed at:" $TicTacTokenAddr

log "Setting TicTacToken address on NFT"
seth send $NFTAddr "setTTT(address)" $TicTacTokenAddr --rpc-url="$ETH_RPC_URL"

log "Transferring NFT owner to TicTacToken"
seth send $NFTAddr "transferOwnership(address)" $TicTacTokenAddr --rpc-url="$ETH_RPC_URL"

log "Transferring Token owner to TicTacToken"
seth send $TokenAddr "transferOwnership(address)" $TicTacTokenAddr --rpc-url="$ETH_RPC_URL"