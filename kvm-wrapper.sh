#!/bin/bash 
set -e
#set -x

# Simple script to create a KVM VM for a user session not root.
# VARS KVM_VOLS Set this to your volume path.
# Mine is set in my shell profile.
# name
usage()
{  echo -e "Command Usage:\n"
   echo "$0 ARGS Values ($0 -n name)"
   echo -e "-h \t Print usage" 
   echo -e "-n \t VM-Name"
   echo -e "-m \t Memory"
   echo -e "-c \t cdrom"
   echo -e "-o \t OS-type"
   echo -e "-d \t Disk Name"
   echo -e "-s \t Size"
}

while getopts ":h:n:m:c:o:d:s" arg; do
  case $arg in
    h) usage;;
    n) NAME=$OPTARG;;
    m) MEMORY=$OPTARG;;
    c) CDROM=$OPTARG;;
    o) OSTYPE=$OPTARG;;
    d) DISK_NAME=$OPTARG;;
    #s) DISK_SIZE=$(($OPTARG+0));;
    *) ;;
  esac
done


if [[ -r "$CDROM" ]]; then
echo -e "Running Virt-install"
virt-install --connect qemu:///session \
	--name "$NAME" \
	--memory "$MEMORY" \
        --os-variant "$OSTYPE" \
	--vcpus 1 \
	--cpu host \
	--cdrom="$CDROM" \
	--os-type linux \
	--disk $KVM_VOLS/$DISK_NAME,size=40,bus=virtio,format=qcow2 \
	--network bridge=virbr0,model=virtio \
	--graphics spice \
	-v
else
        echo -e "Parameters missing\n"
        usage
        exit
fi
exit
