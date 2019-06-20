mkdir -p exported-node-files
docker run -it --name ephemeral-cartesi-blockchain-node -p 127.0.0.1:8545:8545 -v `pwd`/exported-node-files:/root/host --rm cartesi/image-blockchain-node
