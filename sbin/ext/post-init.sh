#!/sbin/busybox sh
#

# Remount FileSys RW
/sbin/busybox mount -t rootfs -o remount,rw rootfs

## Create the kernel data directory
if [ ! -d /data/.dream ];
then
  mkdir /data/.dream
  chmod 777 /data/.dream
fi

## Enable "post-init" ...
if [ -f /data/.dream/post-init.log ];
then
  # BackUp old post-init log
  mv /data/.dream/post-init.log /data/.dream/post-init.log.BAK
fi

# Start logging
date >/data/.dream/post-init.log
exec >>/data/.dream/post-init.log 2>&1

echo "Running Post-Init Script"

# Remount FileSys RO
/sbin/busybox mount -t rootfs -o remount,ro rootfs

echo "Post-init finished ..."
