#!/usr/bin/env bash

GANACHE_DB_DIR=/opt/ganache_db
CARTESI_CONFIG_PATH=/opt/cartesi-node
CONFIG_FILENAME=deployed_dispute_contracts.yaml
MM_ADD_FILE_NAME=mm.add
STEP_ADD_FILE_NAME=step.add
CARTESI_CONFIG_FILE_PATH="$CARTESI_CONFIG_PATH/$CONFIG_FILENAME"
MM_ADD_FILE_PATH="$CARTESI_CONFIG_PATH/$MM_ADD_FILE_NAME"
STEP_ADD_FILE_PATH="$CARTESI_CONFIG_PATH/$STEP_ADD_FILE_NAME"

mkdir -p $CARTESI_CONFIG_PATH
rm -rf $GANACHE_DB_DIR
mkdir -p $GANACHE_DB_DIR

machine-solidity-step/node_modules/.bin/ganache-cli --db=$GANACHE_DB_DIR -l 9007199254740991 -e 200000000 -i=7777 -d --mnemonic="mixed bless goat recipe urban pair tuna diet drive capable normal action" 2>&1 > ganache-output.log &

GANACHE_PID=$!

function migrate() {
    cd $1;
    ./node_modules/.bin/truffle migrate
}

export CARTESI_CONFIG_FILE_PATH="$CARTESI_CONFIG_FILE_PATH"
export MM_ADD_FILE_PATH="$MM_ADD_FILE_PATH"

migrate /opt/cartesi-node/arbitration-dlib

export CARTESI_INTEGRATION_MM_ADDR=`cat $MM_ADD_FILE_PATH`
export STEP_ADD_FILE_PATH="$STEP_ADD_FILE_PATH"

migrate /opt/cartesi-node/machine-solidity-step

kill $GANACHE_PID
