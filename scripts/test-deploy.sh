#!/usr/bin/env bash

set -eo pipefail

# bring up the network
. $(dirname $0)/run-temp-testnet.sh

# run the deploy script
. $(dirname $0)/deploy.sh

# get the address
addr=$(jq -r '.Fizzbuzz' out/addresses.json)

# call fizzbuzz
response=$(seth call $addr 'fizzbuzz(uint256)(string memory)' '3')
[[ $response = "fizz" ]] || error

response=$(seth call $addr 'fizzbuzz(uint256)(string memory)' '5')
[[ $response = "buzz" ]] || error

response=$(seth call $addr 'fizzbuzz(uint256)(string memory)' '15')
[[ $response = "fizzbuzz" ]] || error

response=$(seth call $addr 'fizzbuzz(uint256)(string memory)' '11')
[[ $response = "11" ]] || error

echo "Success."
