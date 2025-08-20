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

UID=${UID:-1000}
GID=${GID:-1000}

if [ -n "$SOLARGRAPH_APK_PKGS" ]; then
  echo "$SOLARGRAPH_APK_PKGS" | xargs apk add &
  PID=$!
  wait "$PID"
fi

# Create user with UID:GID

# Group should automatically get created by adduser
#/usr/sbin/addgroup -g "$GID" 'solargraph'
# Close STDIN to use blank password (even if container's tty STDIN is open)
( exec 0<&-; /usr/sbin/adduser -u "$UID" 'solargraph' 'solargraph' )
USER=$(getent passwd "$UID" | cut -f1 -d:)

git config --global --add safe.directory "$PWD" &
PID=$!
wait "$PID"
sudo -u "$USER" git config --global --add safe.directory "$PWD" &
PID=$!
wait "$PID"

if [ -f "$PWD/Gemfile.lock" ]; then
  bundle config set frozen true &
  PID=$!
  wait "$PID"
  sudo -u "$USER" bundle config set frozen true &
  PID=$!
  wait "$PID"
fi

# Install gems into system location as root
bundle install &
PID=$!
wait "$PID"

# Fix permissions for volume mounted cache & config dirs
chown solargraph:solargraph /home/solargraph/.cache/solargraph
chown solargraph:solargraph /home/solargraph/.config/solargraph

sudo --preserve-env=GEM_HOME,BUNDLE_APP_CONFIG -u "$USER" solargraph gems &
PID=$!
wait "$PID"

sudo --preserve-env=GEM_HOME,BUNDLE_APP_CONFIG -u "$USER" solargraph "$@" & PID=$!
wait "$PID"
