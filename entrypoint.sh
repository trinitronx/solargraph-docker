#!/usr/bin/env sh

git config --global --add safe.directory "$PWD"

[ -f "$PWD/Gemfile.lock" ] && bundle config set frozen true
bundle install
solargraph gems

solargraph "$@" & PID=$(jobs -p)

trap 'kill -SIGQUIT "$PID"' INT TERM QUIT
wait
