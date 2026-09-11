#!/bin/sh
# Railway's custom start command does not go through a real shell — it just
# splits the string into literal argv tokens, so "&" and ";" in a startCommand
# are inert text, not job control. Running this as a script file (via
# `sh /opt/hermes/docker/start-gateway-and-dashboard.sh`) is what actually
# gets shell semantics: the gateway is launched first and backgrounded, then
# a short delay avoids a startup race in shared state initialization before
# the dashboard starts in the foreground.
set -e
hermes gateway run --force &
sleep 5
exec hermes dashboard --host 0.0.0.0 --port 9119 --no-open
