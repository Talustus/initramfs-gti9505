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

## Testing: Check for ExFat SD Card
#
SDTYPE=`blkid /dev/block/mmcblk1p1  | awk '{ print $3 }' | sed -e 's|TYPE=||g' -e 's|\"||g'`

if [ ${SDTYPE} == "exfat" ];
then
  echo "ExFat-Debug: SD-Card is type ExFAT"
  echo "ExFat-Debug: trying to mount via fuse"
  mount.exfat-fuse /dev/block/mmcblk1p1 /storage/extSdCard
else
  echo "ExFat-Debug: SD-Card is type: ${SDTYPE}"
fi

# Remount FileSys RO
/sbin/busybox mount -t rootfs -o remount,ro rootfs

echo "Post-init finished ..."
