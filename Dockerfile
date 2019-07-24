FROM ubuntu:18.04

MAINTAINER Carlo Fragni<carlo@cartesi.io>

ENV BASE /opt/cartesi-node
ENV SHARE_DIR /opt/share_dir
ENV GANACHE_DB_DIR /opt/ganache_db

# Install basic development tools
# ----------------------------------------------------
RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        ca-certificates git build-essential make curl software-properties-common

#Install node
SHELL ["/bin/bash", "-c"]
RUN \
    apt-get install -y gnupg-agent && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

# Making a directory to store ganache "db"
RUN \
    mkdir $GANACHE_DB_DIR

# Installing contracts dependencies and building
# ----------------------------------------------------
COPY arbitration-dlib $BASE/arbitration-dlib
WORKDIR $BASE/arbitration-dlib

RUN \
    rm .git && rm .gitignore && rm .gitmodules && \
    rm -rf subleq && \
    npm install && \
    ./node_modules/.bin/truffle compile

# Installing machine-solidiity dependencies and building
# ----------------------------------------------------
COPY machine-solidity-step $BASE/machine-solidity-step
WORKDIR $BASE/machine-solidity-step

RUN \
    rm .git && rm .gitignore && \
    npm install && \
    ./node_modules/.bin/truffle compile

# Deploying the contracts in ganache and saving it's state
# ----------------------------------------------------
COPY install_contracts.sh $BASE
WORKDIR $BASE


RUN \
    bash install_contracts.sh

#WORKDIR $BASE/arbitration-dlib

#Exporting some needed files to interact with the
#deployed contracts and running ganache from saved state
# ----------------------------------------------------
CMD \
    cp deployed_dispute_contracts.yaml /root/host && \
    cp step.add /root/host && \
    cp mm.add /root/host && \
    cp /opt/cartesi-node/arbitration-dlib/build/contracts/ComputeInstantiator.json /root/host && \
    cp /opt/cartesi-node/arbitration-dlib/build/contracts/VGInstantiator.json /root/host && \
    cp /opt/cartesi-node/arbitration-dlib/build/contracts/MMInstantiator.json /root/host && \
    cp /opt/cartesi-node/arbitration-dlib/build/contracts/PartitionInstantiator.json /root/host && \
    machine-solidity-step/node_modules/.bin/ganache-cli --db=$GANACHE_DB_DIR -l 9007199254740991 -e 200000000 -i=7777 -d -h 0.0.0.0 --mnemonic="mixed bless goat recipe urban pair tuna diet drive capable normal action"
#
