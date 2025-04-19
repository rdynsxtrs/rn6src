-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 3.0 (quilt)
Source: binutils
Binary: binutils, binutils-dev, binutils-multiarch, binutils-multiarch-dev, binutils-hppa64-linux-gnu, binutils-doc, binutils-source, binutils-s390x-linux-gnu, binutils-powerpc64le-linux-gnu, binutils-powerpc-linux-gnu, binutils-aarch64-linux-gnu, binutils-arm-linux-gnueabihf, binutils-arm-linux-gnueabi, binutils-mips-linux-gnu, binutils-mipsel-linux-gnu, binutils-alpha-linux-gnu, binutils-hppa-linux-gnu, binutils-m68k-linux-gnu, binutils-mips64-linux-gnuabi64, binutils-mips64el-linux-gnuabi64, binutils-powerpc-linux-gnuspe, binutils-powerpc64-linux-gnu, binutils-sh4-linux-gnu, binutils-sparc64-linux-gnu, binutils-mips64-linux-gnuabin32, binutils-mips64el-linux-gnuabin32
Architecture: any all
Version: 2.31.1-16+rnx1
Maintainer: Matthias Klose <doko@debian.org>
Uploaders: James Troup <binutils@elmo.tasta.io>, Daniel Jacobowitz <dan@debian.org>
Homepage: https://www.gnu.org/software/binutils/
Standards-Version: 3.9.8
Vcs-Browser: https://code.launchpad.net/~doko/binutils/pkg-2.28-debian
Vcs-Bzr: http://bazaar.launchpad.net/~doko/binutils/pkg-2.28-debian
Testsuite: autopkgtest
Testsuite-Triggers: autoconf, bison, build-essential, chrpath, dejagnu, dwz, fakeroot, file, flex, gettext, lsb-release, procps, python3, quilt, texinfo, xz-utils, zlib1g-dev
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
 6cf86d71a39633bf4d1ea3ae62dae131440dd0cb 21649228 binutils_2.31.1.orig.tar.xz
 fc0dcf2854fea868cd85fb283cd4433479330c3e 130512 binutils_2.31.1-16+rnx1.debian.tar.xz
Checksums-Sha256:
 e398a2d579faa0f2b5a988add5f7481af8e21a21f63b6ea5702e6f517960c5eb 21649228 binutils_2.31.1.orig.tar.xz
 31be82a12a7280d6d171bd8bf420729dec564a22dd1025e78ec6b68ffc7f8f68 130512 binutils_2.31.1-16+rnx1.debian.tar.xz
Files:
 5f07a94a7eee4c1e3fce85a9225f3bd3 21649228 binutils_2.31.1.orig.tar.xz
 5a93e4c744cb6242c6bce67155e4bf9b 130512 binutils_2.31.1-16+rnx1.debian.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmgDubUACgkQ9hPx6x3pnw997wCguTxYNMqjip+2HMQygU8lGwz0
7g4AmgK7mvdIB02gXj5NvmlqHd9BEIvz
=mwnZ
-----END PGP SIGNATURE-----
