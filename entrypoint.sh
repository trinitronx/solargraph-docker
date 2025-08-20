#!/usr/bin/env sh

PID=$$

cleanup() {
  p="$1"
  kill -SIGTERM "$p" &
  k="$!"
  # Wait 4 sec and SIGKILL it if it didn't stop
  sleep 4

  # shellcheck disable=SC2009
  if ps -o pid=,comm= | grep -q " $p "; then
    kill -SIGKILL "$p"
    exit $?
  else
    wait "$k"
    exit $?
  fi
}
trap 'cleanup "$PID"' INT TERM QUIT

git config --global --add safe.directory "$PWD" &
PID=$!
wait "$PID"

if [ -n "$SOLARGRAPH_APK_PKGS" ]; then
  echo "$SOLARGRAPH_APK_PKGS" | xargs apk add &
  PID=$!
  wait "$PID"
fi

if [ -f "$PWD/Gemfile.lock" ]; then
 bundle config set frozen true &
  PID=$!
  wait "$PID"
fi

bundle install &
PID=$!
wait $PID
solargraph gems &
PID=$!
wait $PID

solargraph "$@" & PID=$!
wait "$PID"
