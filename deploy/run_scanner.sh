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
cp .env.example .env
sed -i 's/HEIGHTS=1/HEIGHTS=/g;s/localhost/db/' .env
cat << EOF >> .env
CHAIN=$1
EOF
node src/index.js
