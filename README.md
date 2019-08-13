# Cartesi Blockchain Node

The Cartesi Blockchain Node is a development/testing Ganache Ethereum node instance that runs inside a docker container and has all Cartesi blockchain contracts deployed. The contracts come from two different repositories that are submodules of this repository:

- Contracts
- RISC-V Solidity



## Getting Started

### Requirements

- Docker
- Git

### Clone the repository

```
$ git clone --recurse-submodules git@github.com:cartesi/cartesi-blockchain-node.git
```
### Build the docker image

```bash
$ ./build_cartesi_blockchain_node_image.sh
```

### Create an ephemeral container and execute the server

```bash
$ ./execute_cartesi_blockchain_node_ephemeral_container.sh
```

Once you do that you'll have a local instance listening on port 8545 ready to interact with any ethereum node client using the JSON-RPC interface. 

## Contributing

Thank you for your interest in Cartesi! Head over to our [Contributing Guidelines](https://github.com/cartesi/blockchain-node/blob/master/CONTRIBUTING.md) for instructions on how to sign our Contributors Agreement and get started with Cartesi!

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Authors

* *Carlo Fragni*

## License

The blockchain-node repository and all contributions are licensed under [APACHE 2.0.](https://www.apache.org/licenses/LICENSE-2.0) Please review our [LICENSE](https://github.com/cartesi/blockchain-node/blob/master/LICENSE) file.

## Acknowledgments

- Original work 
