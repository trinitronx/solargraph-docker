#!/usr/bin/env sh

solargraph download-core
bundle install
solargraph bundle

solargraph "$@" & PID=`jobs -p`

trap "kill -SIGQUIT $PID" INT
wait
