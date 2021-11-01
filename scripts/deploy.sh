#!/usr/bin/env bash

set -eo pipefail

# import the deployment helpers
. $(dirname $0)/common.sh

# Deploy.
TicTacTokenAddr=$(deploy TicTacToken)
log "TicTacToken deployed at:" $TicTacTokenAddr
