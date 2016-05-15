#!/bin/bash

set -e
[ -n "$GLUSTER_DEBUG" ] && set -x

probe_server() {
    server="$1"

    if gluster pool list | grep -q $server; then
        echo "Peer '$server' already connected"
        return 0
    fi

    for attempt in {1..5}; do
        echo "Probing peer '$server' (attempt $attempt)..."
        if gluster peer probe $server; then
            echo "Success"
            return 0
        fi

        sleep 2
    done

    echo "Failed to probe peer '$server', giving up." 1>&2
    return 1
}

# Wait for the server to become available.
while ! gluster peer status > /dev/null 2>&1; do
    sleep 2
done

# If any probe servers are specified, make sure they are attached to
# the cluster.
for server in $GLUSTER_PROBE_SERVERS; do
    probe_server $server
done

