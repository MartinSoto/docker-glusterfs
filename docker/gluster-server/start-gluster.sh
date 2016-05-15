#!/bin/bash

set -e
[ -n "$GLUSTER_DEBUG" ] && set -x

# Create the data directories if not present. This makes it easy to
# create subdirectories in mounted data partitions if necessary; you
# don't want administrative directories such as lost+found standing on
# Gluster's way.
for data_dir in $GLUSTER_BRICKS; do
    mkdir -p $data_dir
done

if [ -n "$GLUSTER_PROBE_SERVERS" ]; then
    probe-peers.sh &
fi

# Run the Gluster server.
exec glusterd --no-daemon --log-file=-
