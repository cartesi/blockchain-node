#!/usr/bin/env bash

GANACHE_DB_DIR=/opt/ganache_db

riscv-solidity/node_modules/.bin/ganache-cli --db=$GANACHE_DB_DIR -l 9007199254740991 --allowUnlimitedContractSize -e 200000000 -i=7777 -d --mnemonic="mixed bless goat recipe urban pair tuna diet drive capable normal action" 2>&1 > ganache-output.log &

GANACHE_PID=$!

function get_address() {
    cd $1;
    ./node_modules/.bin/truffle migrate \
        | tee $3 | grep $2 \
        | sed -e 's/^[[:space:]]*//' \
        | cut -d ' ' -f 2
}

MEM_SUFIX="_memory"

export CARTESI_CONFIG_PATH=`mktemp`
export CARTESI_CONFIG_PATH_MEMORY="$CARTESI_CONFIG_PATH$MEM_SUFIX"
echo `get_address /opt/cartesi-node/contracts "ComputeInstantiator:" contracts.out` > compute_instantiator.add
export CARTESI_INTEGRATION_MM_ADDR=`cat $CARTESI_CONFIG_PATH_MEMORY`
echo `get_address /opt/cartesi-node/riscv-solidity "Step:" riscv.out` > step.add

kill $GANACHE_PID
