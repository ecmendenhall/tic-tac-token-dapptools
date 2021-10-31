#!/usr/bin/env bash

set -eo pipefail

# import the deployment helpers
. $(dirname $0)/common.sh

# Deploy.
FizzbuzzAddr=$(deploy Fizzbuzz)
log "Fizzbuzz deployed at:" $FizzbuzzAddr
