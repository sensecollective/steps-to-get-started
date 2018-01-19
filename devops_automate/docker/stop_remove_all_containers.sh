#!/bin/bash 

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
# docker rm `docker ps -aq --no-trunc --filter "status=exited"`
