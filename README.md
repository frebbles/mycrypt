# MyCrypt

A small script front end to make crypt file system mounting/unmounting and creation easier.

## Dependencies

Uses/Depends on cryptsetup (this can be installed by **apt install cryptsetup**)

Due to the use of "mount" in this script, you will require sudo/root access to perform the mount.

## Usage

* To setup a crypt/luks volume in a file blob "cryptvolume" of 100 MB size (limited to filesystem size, FAT32 < 4GB, NTFS/HFS/ext3/ext4 > 4GB) and mount as mnt-cryptvolume in the same directory.

`./myc.sh setup cryptvolume 100`

* To mount an existing file "cryptvolume" as mnt-cryptvolume in the current directory.

`./myc.sh mount cryptvolume`

* To unmount the "cryptvolume" mounted as mnt-cryptvolume.

`./myc.sh umount cryptvolume`
