#!/bin/sh

[ ! -d dotreasury ] && exit 1

case "$1" in
  kusama|polkadot)
    ;;
  *)
    echo "unsupported chain"
    exit 1
    ;;
esac

##############################################
# Notes:
#
# 1. do not use process manager inside docker, see
#    see https://www.docker.com/blog/keep-nodejs-rockin-in-docker/
#
# 2. by default different services in docker-compose.yml should
#    be in the same (bridged) network, however with differnt hosts
#    the mongodb URL is changed to use hostname:
#    localhost:27017 -> db:27017
#
##############################################

# start scanner
cd dotreasury/packages/scan
echo "" > .env

cat << EOF >> .env
KSM_WS_ENDPOINT=wss://kusama-rpc.polkadot.io
DOT_WS_ENDPOINT=wss://rpc.polkadot.io

MONGO_URL=mongodb://db:27017
MONGO_DB_KSM_NAME=dotreasury-ksm
MONGO_DB_DOT_NAME=dotreasury-dot
MONGO_DB_PRICE_NAME=price

KSM_USE_KNOWN_HEIGHTS=
DOT_USE_KNOWN_HEIGHTS=
CHAIN=$1

EOF
node src/index.js
