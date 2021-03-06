install
text
lang C
keyboard us
timezone --utc @TIMEZONE@
auth --useshadow --enablemd5
selinux --permissive
firewall --disabled
bootloader --location=mbr --driveorder vda,vdb --timeout=1
network --bootproto=dhcp --device=eth0 --onboot=on
network --bootproto=dhcp --device=eth1 --onboot=on
services --enabled=network
rootpw cluster
poweroff

#
# Disk configuration
#

bootloader --location=mbr --append="console=tty0 console=ttyS0,115200"
zerombr
clearpart --all --drives=vda,vdb --initlabel --disklabel=gpt

part biosboot --fstype=biosboot --size=1 --ondisk=vda
part / --fstype ext4 --size=@ROOTSIZE@ --ondisk=vda
part swap --size=@SWAPSIZE@ --fstype swap --ondisk=vda

part /srv/cbox/qdiskd --size=@QDISKDSIZE@   --fstype=ext4 --ondisk=vdb
part /srv/cbox/gfs2   --size=@GFS2SIZE@ --fstype=ext4 --ondisk=vdb
part /srv/cbox/clvmd  --size=@CLVMDSIZE@ --fstype=ext4 --ondisk=vdb

#
# Repositories
#
# This will be parsed for virt-install to download image
#IMAGE_TREE=http://ftp.linux.cz/pub/linux/fedora/linux/releases/21/Server/x86_64/os/
#           http://download.eng.brq.redhat.com/pub/fedora/linux/development/rawhide/x86_64/os/

repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=x86_64
@REPOURL@

#
# Packages
#
%packages
@core

ntp
ntpdate

# This will be modified according to cluster type
# CLUSTER_PACKAGES

%end

%post

%end
