%global min_xulrunner_version 38.8.0.15

Name:       qtmozembed-qt5
Summary:    Qt embeddings for Gecko
Version:    1.13.23
Release:    1
Group:      Applications/Internet
License:    MPLv2
URL:        https://github.com/tmeshkova/qtmozembed.git
Source0:    %{name}-%{version}.tar.bz2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(Qt5Network)
BuildRequires:  pkgconfig(Qt5OpenGL)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5QuickTest)
BuildRequires:  pkgconfig(nspr)
BuildRequires:  pkgconfig(pixman-1)
BuildRequires:  xulrunner-qt5-devel >= %{min_xulrunner_version}
BuildRequires:  qt5-default
BuildRequires:  qt5-qttools
Requires:       xulrunner-qt5 >= %{min_xulrunner_version}

%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}

%description
Qt embeddings for Gecko browser engine

%package devel
Requires:   %{name} = %{version}-%{release}
Summary:    Headers for qtmozembed

%description devel
Development files for qtmozembed.

%package tests
Summary:    Unit tests for QtMozEmbed tests
Requires:   %{name} = %{version}-%{release}
Requires:   embedlite-components-qt5 >= 1.0.0
Requires:   qt5-qtdeclarative-import-qttest
Requires:   nemo-test-tools

%description tests
This package contains QML unit tests for QtMozEmbed library

%prep
%setup -q -n %{name}-%{version}

%build
%qtc_qmake5 -r VERSION=%{version}
%qtc_make %{?_smp_mflags}

%install
%qmake5_install
%post -p /sbin/ldconfig
%postun -p /sbin/ldconfig

%files
%defattr(-,root,root,-)
%{_libdir}/*.so.*
%{_libdir}/qt5/qml/Qt5Mozilla/*

%files devel
%defattr(-,root,root,-)
%{_libdir}/*.so
%{_libdir}/pkgconfig
%{_includedir}/*

%files tests
%defattr(-,root,root,-)
# >> files tests
/opt/tests/qtmozembed/*
%{_libdir}/qt5/bin/*
# << files tests
