# gerbv.spec

Summary:	Gerber file viewer.
Name: 		gerbv
Version:	0.0.6
Release: 	1
Source:		%{name}-%{version}.tar.gz
Url:		http://www.geda.seul.org
Packager:	W. Kazubski <wk@ire.pw.edu.pl>
Copyright:	GPL 
Group: 		Applications/Engineering
BuildRoot:    	/var/tmp/

%description
Gerbv is a viewer for Gerber files. Gerber files are generated from PCB CAD 
system and sent to PCB manufacturers as basis for the manufacturing process.



%prep
%setup -n %{name}-%{version}

%build
./configure --prefix=/usr --mandir=/usr/share/man
make all

# install will be a bit complicated because we are not assured
# that the builder has root privileges
%install
make install DESTDIR=$RPM_BUILD_ROOT
strip $RPM_BUILD_ROOT/usr/bin/%{name}
# uncomment this to add examples
#cp -r example $RPM_BUILD_ROOT/usr/share/gerbv/


%clean
rm -Rf $RPM_BUILD_ROOT/%{name}-%{version}


%files
%defattr(-,root,root)
%dir /usr/share/gerbv
%dir /usr/share/gerbv/scheme
%doc AUTHORS ChangeLog CONTRIBUTORS COPYING NEWS README TODO
/usr/bin/gerbv
/usr/share/man/man1/gerbv.*
/usr/share/gerbv/*

%changelog

* Mon Dec 17 2001 W. Kazubski <wk@ire.pw.edu.pl>

- changed to gerbv-0.0.6, option to include examples added

* Thu Nov 22 2001 W. Kazubski <wk@ire.pw.edu.pl>

- changed to build without root (DESTDIR=... added)

* Wed Nov 21 2001 W. Kazubski <wk@ire.pw.edu.pl>

- initialization of spec file.

# end of file
