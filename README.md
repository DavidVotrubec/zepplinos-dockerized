# Dockerized version of Zeppellin OS

## Motivation
ZOS is standard npm package which unfortunatelly relies on node-gyp. That is notoriously problematic to run correctly on Windows. The workaround is to use dockerized version of ZOS and then call it using command-line alias

## Installation
1. Clone the repository and run `docker build -t zos .`
1. Create doskey alias `dzos=docker run -v %cd%/:/usr/src/app zos $*`. The $* at the end passes all arguments to zos running in docker. The %cd% maps current directory, so zos can operate in it.
1. Use `dzos` the same way you would run `zos`
1. Check that it runs correctly by typing `dzos --version`

## Instructions on Windows
- **Note: None of this is needed, if node-gyp works correctly on your system**
- You will need to run at least 2 docker containers. One for ganache, the other for the dockerized ZOS
- **1) create docker network**
- `docker network create ganache-net`
- all other containers will belong to this network, so they can communicate
- **2) Start ganache-cli network in docker**
- `docker run -p 8545:8545 --net ganache-net trufflesuite/ganache-cli:latest` add `-d` if you do not care about knowing the accounts/private keys.
- obtain the IP address of that docker container by command `docker inspect [container-name]`
- you will need this IP address in the trufle_config.js, because localhost will not correctly resolve inside container
- **3) Prepare ZOS**
- navigate to project directory and run `dzos init` or any other zos command
- Make sure that file `truffle_config.js` exists, it should be created for you by the zos init command
- Define connection to dockerized ganache like this: 
```
docker_ganache_cli: {
      host: '172.21.0.2', // This is the containers IP. Can't use localhost
      port: 8545,
      gas: 5000000,
      gasPrice: 5e9,
      network_id: '*'
    }
```
- Create local ZOS session to ganache_cli
`dzos-session=zos session --network docker_ganache_cli --from [10th-ganache-account] --expires 3600 `. This account will be used as deployer/owner of the upgradable smart contracts.
- Now all ZOS commands should work and deploy to the dockerized ganache network.

## More about Doskey
Read how to create permament aliases (with any predefined arguments) using Doskey here: http://blog.davidjs.com/2018/03/custom-command-line-shortcuts-with-doskey/

## Documentation to ZOS
Documentation to zos is here https://github.com/zeppelinos/zos/tree/master/packages/cli#readme
All commands are the same, `dzos` is just a wrapper :)