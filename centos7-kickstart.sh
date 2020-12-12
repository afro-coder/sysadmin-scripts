#!/bin/bash
#centos 7 vm
virt-install --connect qemu:///session \
        --name "centos7-demo" \
        --location="http://192.168.122.213/centos7/" \
        --disk path="centos-demo.qcow2",size=50,bus=virtio,format=qcow2 \
        --memory=2048 \
        --noautoconsole \
        --graphics none \
        --os-variant "centos7.0" \
        --vcpus 2 \
        --cpu host \
        --os-type linux \
        --network bridge=virbr0,model=virtio \
        --console pty,target_type=serial \
        --extra-args "ks=http://192.168.122.213/centos7/anaconda-ks.cfg console=ttyS0,115200n8 serial" \
        --wait=-1
