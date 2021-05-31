#!/bin/sh

# clone source codes
[ -d dotreasury ] || git clone https://github.com/litentry/dotreasury

# check if 27017 is open
if command -v netstat &>/dev/null ; then
  if netstat -nat | grep 27017 | grep -q LISTEN ; then
    echo "port 27017 is open, is mongod running?"
    exit 1
  fi
fi

# build docker images if not present
if [ $(docker images indexing_base:0.1 | wc -l) -gt 1 ]; then
  :
else
  docker build -t indexing_base:0.1 .
fi

# run docker-compose
docker-compose up -d

# check the API
sleep 6
echo "------------------------------------"
echo "Checking kusama status...:"
curl -s http://localhost:3213/kusama/status
echo
echo "------------------------------------"
echo "Checking polkadot status...:"
curl -s http://localhost:3213/polkadot/status
echo
echo "------------------------------------"
