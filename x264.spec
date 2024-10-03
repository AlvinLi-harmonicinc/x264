Name:           libx264
Version:        1.0.0
Release:        1%{?dist}
Summary:        libx264 library
BuildArch:      x86_64

License:        GPL
Source0:        %{name}-%{version}.tar.gz

%description
libx264 RPM build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_libdir}
cp -P $RPM_SOURCE_DIR/*.so* $RPM_BUILD_ROOT/%{_libdir}
mkdir -p $RPM_BUILD_ROOT/%{_includedir}
cp $RPM_SOURCE_DIR/x264.h $RPM_BUILD_ROOT/%{_includedir}
cp $RPM_SOURCE_DIR/x264_config.h $RPM_BUILD_ROOT/%{_includedir}
mkdir -p $RPM_BUILD_ROOT/%{_libdir}/pkgconfig
cp $RPM_SOURCE_DIR/x264.pc $RPM_BUILD_ROOT/%{_libdir}/pkgconfig

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_libdir}/*.so*
%{_includedir}/x264.h
%{_includedir}/x264_config.h
%{_libdir}/pkgconfig/x264.pc
