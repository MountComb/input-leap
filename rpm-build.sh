# docker run -it --rm -v ./:/workspace opensuse/tumbleweed

zypper install -y rpm-build

sed -n '/^%if 0%{?suse_version}$/,/^%endif$/{s/^BuildRequires: //p}' dist/rpm/input-leap.spec.in | xargs zypper install -y

cmake -B build -D INPUTLEAP_BUILD_LIBEI=TRUE
make -C build package_source
mkdir rpm
rpmbuild -D "_sourcedir $PWD/build" -D "_rpmdir $PWD/rpm" -bb build/rpm/input-leap.spec
