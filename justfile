podman := env("podman", "podman")

help:
    @just -l

deps:
    dnf -y install gcc-c++
    dnf -y --enablerepo=crb install nasm
    ./configure --enable-shared

build:
    make

clean:
    d=$PWD && rm -f $d/libx264.tgz
    make clean

package:
    d=$PWD && tar -czf $d/libx264.tgz *.so* libx264.a x264.h x264_config.h

dev:
    d=/workspaces/libx264 && {{ podman }} run --rm -it -w $d -v $PWD:$d quay.io/centos/centos:stream9
