-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 1.0
Source: binutils
Binary: binutils, binutils-dev, binutils-multiarch, binutils-multiarch-dev, binutils-hppa64-linux-gnu, binutils-doc, binutils-source, binutils-s390x-linux-gnu, binutils-powerpc64le-linux-gnu, binutils-powerpc-linux-gnu, binutils-aarch64-linux-gnu, binutils-arm-linux-gnueabihf, binutils-arm-linux-gnueabi, binutils-mips-linux-gnu, binutils-mipsel-linux-gnu, binutils-alpha-linux-gnu, binutils-hppa-linux-gnu, binutils-m68k-linux-gnu, binutils-mips64-linux-gnuabi64, binutils-mips64el-linux-gnuabi64, binutils-powerpc-linux-gnuspe, binutils-powerpc64-linux-gnu, binutils-sh4-linux-gnu, binutils-sparc64-linux-gnu, binutils-mips64-linux-gnuabin32, binutils-mips64el-linux-gnuabin32
Architecture: any all
Version: 2.28-5+rnx1
Maintainer: Matthias Klose <doko@debian.org>
Uploaders: James Troup <binutils@elmo.tasta.io>, Daniel Jacobowitz <dan@debian.org>
Homepage: https://www.gnu.org/software/binutils/
Standards-Version: 3.9.8
Vcs-Browser: https://code.launchpad.net/~doko/binutils/pkg-2.28-debian
Vcs-Bzr: http://bazaar.launchpad.net/~doko/binutils/pkg-2.28-debian
Testsuite: autopkgtest
Build-Depends: autoconf (>= 2.64), dpkg-dev (>= 1.17.11), bison, flex, gettext, texinfo, dejagnu, quilt, chrpath, python3:any, file, xz-utils, lsb-release, zlib1g-dev
Build-Conflicts: libelf-dev
Package-List:
 binutils deb devel optional arch=any
 binutils-aarch64-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-alpha-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-arm-linux-gnueabi deb devel extra arch=amd64,i386,x32,arm64
 binutils-arm-linux-gnueabihf deb devel extra arch=amd64,i386,x32,arm64
 binutils-dev deb devel extra arch=any
 binutils-doc deb doc optional arch=all
 binutils-hppa-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-hppa64-linux-gnu deb devel optional arch=amd64,i386,x32,hppa
 binutils-m68k-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-mips-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-mips64-linux-gnuabi64 deb devel extra arch=amd64,i386,x32
 binutils-mips64-linux-gnuabin32 deb devel extra arch=amd64,i386,x32
 binutils-mips64el-linux-gnuabi64 deb devel extra arch=amd64,i386,x32
 binutils-mips64el-linux-gnuabin32 deb devel extra arch=amd64,i386,x32
 binutils-mipsel-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-multiarch deb devel extra arch=any
 binutils-multiarch-dev deb devel extra arch=any
 binutils-powerpc-linux-gnu deb devel extra arch=amd64,i386,x32,ppc64el
 binutils-powerpc-linux-gnuspe deb devel extra arch=amd64,i386,x32
 binutils-powerpc64-linux-gnu deb devel extra arch=amd64,i386,x32,ppc64el
 binutils-powerpc64le-linux-gnu deb devel extra arch=amd64,i386,x32,ppc64
 binutils-s390x-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-sh4-linux-gnu deb devel extra arch=amd64,i386,x32
 binutils-source deb devel optional arch=all
 binutils-sparc64-linux-gnu deb devel extra arch=amd64,i386,x32
Checksums-Sha1:
 2a7e5e8b03d15c4a713b234c902afcedc81411b8 37814356 binutils_2.28.orig.tar.gz
 39ad003f30afa6c32cee0a8d6772c4f0548f9312 129643 binutils_2.28-5+rnx1.diff.gz
Checksums-Sha256:
 db29588b0214fa69baa1a9351122cd6d0f081f2e675e6ad2aefc316ddeaf327a 37814356 binutils_2.28.orig.tar.gz
 145bd8d69a0f00b9d404e3f1679cf54a053eadf1091996e14747e02138a27421 129643 binutils_2.28-5+rnx1.diff.gz
Files:
 9ebb08757c6e8a025a331ca4e4764e74 37814356 binutils_2.28.orig.tar.gz
 de73db1fb256919deced2fa9d6d32da4 129643 binutils_2.28-5+rnx1.diff.gz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJh9o2pAAoJEMyaWCvwsWrcpC8QALU3u3aBuReyW3/9uHRqE6Oo
t3TUBD2DqnNz1x4MilZRQtyMNzC74leAGPnCGiLTi39B/OCWY2iK52gS+zvOAMb+
7Y7cUsY9JLCcSUKJ/MxORzxKdJzM/YKz6wbcrpbSNcxkgec4bhYewLqn3hgastMj
4QZk7KI0Nka3Qox62QQi3Pv4WMuyX7BdZYBEt86YbNq6AfIATQYc140uRydWaaYW
MYyYX3L6JIoAqmP+ziRQYmhbyyJMUuUAZTubvbGF1Ig2XtWhyLuwSs/G4iTd5UMO
/s/ropp1Jf4gNEc5iR/YzbLguApEjg5VJKZJ+5mdDy0zUyLFfqpILtF9EWn9hjJU
UKHibjFJ2xxLuQanARXvqVswmZXCr/0zMqyP1iUn/kjQVoxGiysI/oY4C6EHnKYS
Siy7zXwmfHuqKtSa3cswLQZ00+3bV1icglWyBzBSXjFOknysUbIvXxoW8/kdhqK0
OMVDjLU4NSVdJEFZosULaG1vKscw06H1XtmdlM5gxUdjFygo5BTaZx+IyIB7vGxC
MUUotwFdCsNoWproictkB6VctsKZwX4Rem6ZHrJonFTK/M3l+iO46rfdHBWhYOW5
hthWF40u7DS6i38wCmcGLz8W4G+VoxxOLOtw56JsZKlJS9MkCNQXevi7nVtIE4ia
lwhGysIn7kjtW0ODuped
=pu+Q
-----END PGP SIGNATURE-----
