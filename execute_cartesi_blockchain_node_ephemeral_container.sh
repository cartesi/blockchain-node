mkdir contracts_addresses
docker run -it --name ephemeral-cartesi-blockchain-node -p 127.0.0.1:8545:8545 -v `pwd`/contracts_addresses:/root/host --rm cartesi/image-blockchain-node
