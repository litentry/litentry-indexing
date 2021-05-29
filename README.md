# litentry-indexing
Litentry substrate-based indexing service

## How to use deploy scripts
    cd deploy
    ./deploy.sh

It should automatically:
* build the docker image if not present
* run docker-compose
* start the server
* check API status.

If you see such output in the ned, it means the API server is now (locally) reachable:

    ------------------------------------
    Checking kusama status...:
    {"last-stat-time":1574962074000,"main-scan-height":577}
    ------------------------------------
