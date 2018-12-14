# Dockerized version of Zeppellin OS

## Motivation
ZOS is standard npm package which unfortunatelly relies on node-gyp. That is notoriously problematic to run correctly on Windows. The workaround is to use dockerized version of ZOS and then call it using command-line alias

## Installation
1. Clone the repository and run `docker build -t zos .`
1. Create doskey alias `dzos=docker run -v %cd%/:/usr/src/app zos $*`. The $* at the end passes all arguments to zos running in docker. The %cd% maps current directory, so zos can operate in it.
1. Use `dzos` the same way you would run `zos`
1. Check that it runs correctly by typing `dzos --version`

## Instructions
- If you need ganache-cli network, then:
- create doskey command `dzos-ganache=docker run --entrypoint ganache-cli zos`
- and then run it `dzos-ganache`

## More about Doskey
Read how to create permament aliases (with any predefined arguments) using Doskey here: http://blog.davidjs.com/2018/03/custom-command-line-shortcuts-with-doskey/

## Documentation to ZOS
Documentation to zos is here https://github.com/zeppelinos/zos/tree/master/packages/cli#readme
All commands are the same, `dzos` is just a wrapper :)