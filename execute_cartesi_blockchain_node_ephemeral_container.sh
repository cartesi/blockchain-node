mkdir -p exported-node-files
docker run -it --name ephemeral-cartesi-blockchain-node -p 0.0.0.0:8545:8545 -v `pwd`/exported-node-files:/root/host --rm cartesi/image-blockchain-node
