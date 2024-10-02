podman := env("podman", "podman")
specfile := "x264.spec"
x264ver := "164"

help:
    @just -l

deps:
    dnf -y install gcc-c++
    dnf -y --enablerepo=crb install nasm
    ./configure --disable-cli --enable-shared --prefix=$(rpm --eval "%{_prefix}") --libdir=$(rpm --eval "%{_lib}")

build:
    make
    ln -sf libx264.so.{{ x264ver }} libx264.so

clean:
    d=$PWD && rm -f $d/libx264-1.0.0-1.el9.x86_64.rpm
    d=$PWD && rm -f $d/libx264.tgz
    d=$PWD && rm -f $d/libx264.so
    make clean

package:
    d=$PWD && tar -czf $d/libx264.tgz *.so* x264.h x264_config.h x264.pc

rpm:
    dnf -y install rpmdevtools rpmlint
    dnf -y install 'dnf-command(builddep)'
    rpmdev-setuptree
    cp {{ specfile }} ~/rpmbuild/SPECS/
    cp -R . ~/rpmbuild/SOURCES/
    spectool --get-files --directory ~/rpmbuild/SOURCES --all ~/rpmbuild/SPECS/{{ specfile }}
    dnf -y builddep ~/rpmbuild/SPECS/{{ specfile }}
    rpmbuild -bb ~/rpmbuild/SPECS/{{ specfile }}
    cp ~/rpmbuild/RPMS/x86_64/* ./

dev:
    d=/workspaces/libx264 && {{ podman }} run --rm -it -w $d -v $PWD:$d quay.io/centos/centos:stream9
