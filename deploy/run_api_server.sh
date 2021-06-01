#!/bin/sh

[ ! -d dotreasury ] && exit 1

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
# 3. it's inconsistent in dotreasury source codes abouth env settings:
#    sometimes .env is used, sometimes config.js
#    needs to be cleaned up some day
#
##############################################

# start API-server
cd dotreasury/packages/server
cp .env.sample .env  # TODO: the content might need to be adjusted
# echo "NODE_ENV=production" >> .env
cp config/config.example.js config/config.prod.js
sed -i 's/dot-treasury/dotreasury/g;s/localhost/db/' config/config.prod.js
node src/index.js
