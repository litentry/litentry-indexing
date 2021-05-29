# litentry-indexing
Litentry substrate-based indexing service

## How to use deploy status
cd deploy
./deploy.sh

It should automatically build the docker image if necessary, run docker-compose, start the server and check API status.

If you see such output, it means the API server is now (locally) reachable:

    ------------------------------------
    Checking kusama status...:
    {"last-stat-time":1574962074000,"main-scan-height":577}
    ------------------------------------
