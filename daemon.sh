#!/usr/bin/env bash

set -e
set -o pipefail
set -o verbose
#set -o xtrace

PWD=$(cd "$(dirname "$0")" && pwd)
export PATH="$PWD:$PATH"

btcwallet --username=root, --password=1314 --simnet --createtemp --datadir=/root/.btcwallet/datadir &

sleep 2
miningaddr=$(btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet getnewaddress)

echo "ming address: ${miningaddr}"

btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet listacounts
sleep 2

btcd --generate --simnet --rpcuser=root --rpcpass=1314 --miningaddr="${miningaddr}" --txindex