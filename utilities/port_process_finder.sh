#!/bin/sh
sudo netstat -nlp  | grep 80
lsof -i tcp:80
