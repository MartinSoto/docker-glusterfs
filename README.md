# GlusterFS in Docker with Ubuntu

## Creating a Volume

    gluster volume create vol1 replica 2 server1:/var/lib/gluster/bricks/brick1/data server2:/var/lib/gluster/bricks/brick2/data
    gluster volume start vol1

    mount -t glusterfs server1:vol1 /mnt
