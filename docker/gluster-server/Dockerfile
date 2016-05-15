FROM ubuntu:16.04

MAINTAINER Martin Soto <donsoto@gmail.com>

RUN apt-get update \
    && apt-get install -y glusterfs-server \
    && apt-get clean

# Path were the Gluster bricks are stored.
ENV GLUSTER_BRICK_PATH /var/lib/gluster/bricks/
RUN ["mkdir", "-p", "$GLUSTER_BRICK_PATH"]

# List of servers to probe. This list should include all servers in
# the cluster, and should be non-empty for only one server
# container. This container will probe and connect all other servers
# if they aren't connected.
ENV GLUSTER_PROBE_SERVERS ""

# Set this variable to enable debugging for the initialization
# scripts.
#ENV GLUSTER_DEBUG true

# Gluster daemon working directory.
VOLUME ["/var/lib/glusterd"]

ADD start-gluster.sh probe-peers.sh /usr/local/bin/

CMD ["start-gluster.sh"]
