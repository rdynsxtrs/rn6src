-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 1.0
Source: gcc-6
Binary: gcc-6-base, libgcc1, libgcc1-dbg, libgcc2, libgcc2-dbg, libgcc-6-dev, libgcc4, libgcc4-dbg, lib64gcc1, lib64gcc1-dbg, lib64gcc-6-dev, lib32gcc1, lib32gcc1-dbg, lib32gcc-6-dev, libn32gcc1, libn32gcc1-dbg, libn32gcc-6-dev, libx32gcc1, libx32gcc1-dbg, libx32gcc-6-dev, gcc-6, gcc-6-multilib, gcc-6-test-results, gcc-6-plugin-dev, gcc-6-hppa64-linux-gnu, cpp-6, gcc-6-locales, g++-6, g++-6-multilib, libgomp1, libgomp1-dbg, lib32gomp1, lib32gomp1-dbg, lib64gomp1, lib64gomp1-dbg, libn32gomp1, libn32gomp1-dbg, libx32gomp1, libx32gomp1-dbg, libatomic1, libatomic1-dbg, lib32atomic1, lib32atomic1-dbg, lib64atomic1, lib64atomic1-dbg, libn32atomic1, libn32atomic1-dbg, libx32atomic1, libx32atomic1-dbg, libasan3, libasan3-dbg, lib32asan3, lib32asan3-dbg, lib64asan3, lib64asan3-dbg, libx32asan3, libx32asan3-dbg, libubsan0, libubsan0-dbg, lib32ubsan0, lib32ubsan0-dbg, lib64ubsan0, lib64ubsan0-dbg, libx32ubsan0, libx32ubsan0-dbg, libcc1-0, libgccjit0, libgccjit0-dbg, libgccjit-6-doc,
 libgccjit-6-dev, gobjc++-6, gobjc++-6-multilib, gobjc-6, gobjc-6-multilib, libobjc-6-dev, lib64objc-6-dev, lib32objc-6-dev, libn32objc-6-dev, libx32objc-6-dev, libobjc4, libobjc4-dbg, lib64objc4, lib64objc4-dbg, lib32objc4, lib32objc4-dbg, libn32objc4, libn32objc4-dbg, libx32objc4, libx32objc4-dbg, gfortran-6, gfortran-6-multilib, libgfortran-6-dev, lib64gfortran-6-dev, lib32gfortran-6-dev, libn32gfortran-6-dev, libx32gfortran-6-dev, libgfortran3, libgfortran3-dbg, lib64gfortran3, lib64gfortran3-dbg, lib32gfortran3, lib32gfortran3-dbg, libn32gfortran3, libn32gfortran3-dbg, libx32gfortran3, libx32gfortran3-dbg, gccgo-6, gccgo-6-multilib, libgo9, libgo9-dbg, lib64go9, lib64go9-dbg, lib32go9, lib32go9-dbg, libn32go9, libn32go9-dbg, libx32go9, libx32go9-dbg, gcj-6, gcj-6-jdk, gcj-6-jre-headless, gcj-6-jre, libgcj17, gcj-6-jre-lib, libgcj17-awt, libgcj17-dev, libgcj17-dbg, gcj-6-source, libgcj-doc, libstdc++6, lib32stdc++6, lib64stdc++6, libn32stdc++6, libx32stdc++6,
 libstdc++-6-dev, libstdc++-6-pic, libstdc++6-6-dbg, lib32stdc++-6-dev, lib32stdc++6-6-dbg, lib64stdc++-6-dev, lib64stdc++6-6-dbg, libn32stdc++-6-dev, libn32stdc++6-6-dbg, libx32stdc++-6-dev, libx32stdc++6-6-dbg, libstdc++-6-doc, gnat-6, gnat-6-sjlj, libgnat-6, libgnat-6-dbg, libgnatvsn6-dev, libgnatvsn6, libgnatvsn6-dbg, libgnatprj6-dev, libgnatprj6, libgnatprj6-dbg, gdc-6, gdc-6-multilib, libgphobos-6-dev, libgphobos68, libgphobos68-dbg, lib64gphobos-6-dev, lib64gphobos68, lib64gphobos68-dbg, lib32gphobos-6-dev, lib32gphobos68, lib32gphobos68-dbg, libx32gphobos-6-dev, libx32gphobos68, libx32gphobos68-dbg, fixincludes,
 gcc-6-source
Architecture: any all
Version: 6.3.0-18+deb9u1+rnx1
Maintainer: Debian GCC Maintainers <debian-gcc@lists.debian.org>
Uploaders: Matthias Klose <doko@debian.org>
Homepage: http://gcc.gnu.org/
Standards-Version: 3.9.8
Vcs-Browser: http://svn.debian.org/viewsvn/gcccvs/branches/sid/gcc-6/
Vcs-Svn: svn://anonscm.debian.org/gcccvs/branches/sid/gcc-6
Build-Depends: debhelper (>= 9.20141010), dpkg-dev (>= 1.17.14), g++-multilib [amd64 i386 kfreebsd-amd64 mips mips64 mips64el mipsel mipsn32 mipsn32el powerpc ppc64 s390 s390x sparc sparc64 x32] <!cross>, g++-6 [arm64] <!cross>, libc6.1-dev (>= 2.13-5) [alpha ia64] | libc0.3-dev (>= 2.13-5) [hurd-i386] | libc0.1-dev (>= 2.13-5) [kfreebsd-i386 kfreebsd-amd64] | libc6-dev (>= 2.13-5), libc6-dev (>= 2.13-31) [armel armhf], libc6-dev-amd64 [i386 x32], libc6-dev-sparc64 [sparc], libc6-dev-sparc [sparc64], libc6-dev-s390 [s390x], libc6-dev-s390x [s390], libc6-dev-i386 [amd64 x32], libc6-dev-powerpc [ppc64], libc6-dev-ppc64 [powerpc], libc0.1-dev-i386 [kfreebsd-amd64], lib32gcc1 [amd64 ppc64 kfreebsd-amd64 mipsn32 mipsn32el mips64 mips64el s390x sparc64 x32], libn32gcc1 [mips mipsel mips64 mips64el], lib64gcc1 [i386 mips mipsel mipsn32 mipsn32el powerpc sparc s390 x32], libc6-dev-mips64 [mips mipsel mipsn32 mipsn32el], libc6-dev-mipsn32 [mips mipsel mips64 mips64el], libc6-dev-mips32 [mipsn32 mipsn32el mips64 mips64el], libc6-dev-x32 [amd64 i386], libx32gcc1 [amd64 i386], libc6.1-dbg [alpha ia64] | libc0.3-dbg [hurd-i386] | libc0.1-dbg [kfreebsd-i386 kfreebsd-amd64] | libc6-dbg, kfreebsd-kernel-headers (>= 0.84) [kfreebsd-any], linux-libc-dev [m68k], m4, libtool, autoconf2.64, libunwind7-dev (>= 0.98.5-6) [ia64], libatomic-ops-dev [ia64], autogen, gawk, lzma, xz-utils, patchutils, zlib1g-dev, systemtap-sdt-dev [linux-any kfreebsd-any hurd-any], binutils:native (>= 2.25-7~) | binutils-multiarch:native (>= 2.25-7~), binutils-hppa64:native (>= 2.25-7~) [hppa], gperf (>= 3.0.1), bison (>= 1:2.3), flex, gettext, gdb:native, texinfo (>= 4.3), locales, sharutils, procps, libantlr-java, python:native, libffi-dev, fastjar, libmagic-dev, libecj-java (>= 3.3.0-2), zip, libasound2-dev [!hurd-any !kfreebsd-any], libxtst-dev, libxt-dev, libgtk2.0-dev (>= 2.4.4-2), libart-2.0-dev, libcairo2-dev, gnat-4.9:native [!m32r !sh3 !sh3eb !sh4eb !powerpcspe !m68k !mips64 !x32], g++-4.9:native, netbase, libisl-dev (>= 0.14), libmpc-dev (>= 1.0), libmpfr-dev (>= 3.0.0-9~), libgmp-dev (>= 2:5.0.1~), lib32z1-dev [amd64 kfreebsd-amd64], lib64z1-dev [i386], dejagnu [!m68k], realpath (>= 1.9.12), chrpath, lsb-release, quilt, pkg-config, libgc-dev, g++-6-alpha-linux-gnu [alpha] <cross>, gobjc-6-alpha-linux-gnu [alpha] <cross>, gfortran-6-alpha-linux-gnu [alpha] <cross>, gcj-6-alpha-linux-gnu [alpha] <cross>, gdc-6-alpha-linux-gnu [alpha] <cross>, gccgo-6-alpha-linux-gnu [alpha] <cross>, gnat-6-alpha-linux-gnu [alpha] <cross>, g++-6-x86-64-linux-gnu [amd64] <cross>, gobjc-6-x86-64-linux-gnu [amd64] <cross>, gfortran-6-x86-64-linux-gnu [amd64] <cross>, gcj-6-x86-64-linux-gnu [amd64] <cross>, gdc-6-x86-64-linux-gnu [amd64] <cross>, gccgo-6-x86-64-linux-gnu [amd64] <cross>, gnat-6-x86-64-linux-gnu [amd64] <cross>, g++-6-arm-linux-gnueabi [armel] <cross>, gobjc-6-arm-linux-gnueabi [armel] <cross>, gfortran-6-arm-linux-gnueabi [armel] <cross>, gcj-6-arm-linux-gnueabi [armel] <cross>, gdc-6-arm-linux-gnueabi [armel] <cross>, gccgo-6-arm-linux-gnueabi [armel] <cross>, gnat-6-arm-linux-gnueabi [armel] <cross>, g++-6-arm-linux-gnueabihf [armhf] <cross>, gobjc-6-arm-linux-gnueabihf [armhf] <cross>, gfortran-6-arm-linux-gnueabihf [armhf] <cross>, gcj-6-arm-linux-gnueabihf [armhf] <cross>, gdc-6-arm-linux-gnueabihf [armhf] <cross>, gccgo-6-arm-linux-gnueabihf [armhf] <cross>, gnat-6-arm-linux-gnueabihf [armhf] <cross>, g++-6-aarch64-linux-gnu [arm64] <cross>, gobjc-6-aarch64-linux-gnu [arm64] <cross>, gfortran-6-aarch64-linux-gnu [arm64] <cross>, gcj-6-aarch64-linux-gnu [arm64] <cross>, gdc-6-aarch64-linux-gnu [arm64] <cross>, gccgo-6-aarch64-linux-gnu [arm64] <cross>, gnat-6-aarch64-linux-gnu [arm64] <cross>, g++-6-i686-linux-gnu [i386] <cross>, gobjc-6-i686-linux-gnu [i386] <cross>, gfortran-6-i686-linux-gnu [i386] <cross>, gcj-6-i686-linux-gnu [i386] <cross>, gdc-6-i686-linux-gnu [i386] <cross>, gccgo-6-i686-linux-gnu [i386] <cross>, gnat-6-i686-linux-gnu [i386] <cross>, g++-6-mips-linux-gnu [mips] <cross>, gobjc-6-mips-linux-gnu [mips] <cross>, gfortran-6-mips-linux-gnu [mips] <cross>, gcj-6-mips-linux-gnu [mips] <cross>, gdc-6-mips-linux-gnu [mips] <cross>, gccgo-6-mips-linux-gnu [mips] <cross>, gnat-6-mips-linux-gnu [mips] <cross>, g++-6-mipsel-linux-gnu [mipsel] <cross>, gobjc-6-mipsel-linux-gnu [mipsel] <cross>, gfortran-6-mipsel-linux-gnu [mipsel] <cross>, gcj-6-mipsel-linux-gnu [mipsel] <cross>, gdc-6-mipsel-linux-gnu [mipsel] <cross>, gccgo-6-mipsel-linux-gnu [mipsel] <cross>, gnat-6-mipsel-linux-gnu [mipsel] <cross>, g++-6-mips64-linux-gnuabi64 [mips64] <cross>, gobjc-6-mips64-linux-gnuabi64 [mips64] <cross>, gfortran-6-mips64-linux-gnuabi64 [mips64] <cross>, gcj-6-mips64-linux-gnuabi64 [mips64] <cross>, gdc-6-mips64-linux-gnuabi64 [mips64] <cross>, gccgo-6-mips64-linux-gnuabi64 [mips64] <cross>, g++-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gobjc-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gfortran-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gcj-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gdc-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gccgo-6-mips64el-linux-gnuabi64 [mips64el] <cross>, gnat-6-mips64el-linux-gnuabi64 [mips64el] <cross>, g++-6-powerpc-linux-gnu [powerpc] <cross>, gobjc-6-powerpc-linux-gnu [powerpc] <cross>, gfortran-6-powerpc-linux-gnu [powerpc] <cross>, gcj-6-powerpc-linux-gnu [powerpc] <cross>, gdc-6-powerpc-linux-gnu [powerpc] <cross>, gccgo-6-powerpc-linux-gnu [powerpc] <cross>, gnat-6-powerpc-linux-gnu [powerpc] <cross>, g++-6-powerpc64-linux-gnu [ppc64] <cross>, gobjc-6-powerpc64-linux-gnu [ppc64] <cross>, gfortran-6-powerpc64-linux-gnu [ppc64] <cross>, gcj-6-powerpc64-linux-gnu [ppc64] <cross>, gdc-6-powerpc64-linux-gnu [ppc64] <cross>, gccgo-6-powerpc64-linux-gnu [ppc64] <cross>, gnat-6-powerpc64-linux-gnu [ppc64] <cross>, g++-6-powerpc64le-linux-gnu [ppc64el] <cross>, gobjc-6-powerpc64le-linux-gnu [ppc64el] <cross>, gfortran-6-powerpc64le-linux-gnu [ppc64el] <cross>, gcj-6-powerpc64le-linux-gnu [ppc64el] <cross>, gdc-6-powerpc64le-linux-gnu [ppc64el] <cross>, gccgo-6-powerpc64le-linux-gnu [ppc64el] <cross>, gnat-6-powerpc64le-linux-gnu [ppc64el] <cross>, g++-6-m68k-linux-gnu [m68k] <cross>, gobjc-6-m68k-linux-gnu [m68k] <cross>, gfortran-6-m68k-linux-gnu [m68k] <cross>, gcj-6-m68k-linux-gnu [m68k] <cross>, gdc-6-m68k-linux-gnu [m68k] <cross>, g++-6-sh4-linux-gnu [sh4] <cross>, gobjc-6-sh4-linux-gnu [sh4] <cross>, gfortran-6-sh4-linux-gnu [sh4] <cross>, gcj-6-sh4-linux-gnu [sh4] <cross>, g++-6-sparc64-linux-gnu [sparc64] <cross>, gobjc-6-sparc64-linux-gnu [sparc64] <cross>, gfortran-6-sparc64-linux-gnu [sparc64] <cross>, gcj-6-sparc64-linux-gnu [sparc64] <cross>, gdc-6-sparc64-linux-gnu [sparc64] <cross>, gccgo-6-sparc64-linux-gnu [sparc64] <cross>, g++-6-s390x-linux-gnu [s390x] <cross>, gobjc-6-s390x-linux-gnu [s390x] <cross>, gfortran-6-s390x-linux-gnu [s390x] <cross>, gcj-6-s390x-linux-gnu [s390x] <cross>, gdc-6-s390x-linux-gnu [s390x] <cross>, gccgo-6-s390x-linux-gnu [s390x] <cross>, gnat-6-s390x-linux-gnu [s390x] <cross>, g++-6-x86-64-linux-gnux32 [x32] <cross>, gobjc-6-x86-64-linux-gnux32 [x32] <cross>, gfortran-6-x86-64-linux-gnux32 [x32] <cross>, gcj-6-x86-64-linux-gnux32 [x32] <cross>, gdc-6-x86-64-linux-gnux32 [x32] <cross>, gccgo-6-x86-64-linux-gnux32 [x32] <cross>
Build-Depends-Indep: doxygen (>= 1.7.2), graphviz (>= 2.2), ghostscript, texlive-latex-base, xsltproc, libxml2-utils, docbook-xsl-ns
Package-List:
 cpp-6 deb interpreters optional arch=any
 fixincludes deb devel optional arch=any
 g++-6 deb devel optional arch=any
 g++-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 gcc-6 deb devel optional arch=any
 gcc-6-base deb libs required arch=any
 gcc-6-hppa64-linux-gnu deb devel optional arch=hppa,amd64,i386,x32
 gcc-6-locales deb devel optional arch=all
 gcc-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 gcc-6-plugin-dev deb devel optional arch=any
 gcc-6-source deb devel optional arch=all
 gcc-6-test-results deb devel extra arch=any
 gccgo-6 deb devel optional arch=any
 gccgo-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 gcj-6 deb java optional arch=any
 gcj-6-jdk deb java optional arch=any
 gcj-6-jre deb java optional arch=any
 gcj-6-jre-headless deb java optional arch=any
 gcj-6-jre-lib deb java optional arch=all
 gcj-6-source deb java optional arch=all
 gdc-6 deb devel optional arch=any
 gdc-6-multilib deb devel optional arch=any
 gfortran-6 deb devel optional arch=any
 gfortran-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 gnat-6 deb devel optional arch=any
 gnat-6-sjlj deb devel extra arch=any
 gobjc++-6 deb devel optional arch=any
 gobjc++-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 gobjc-6 deb devel optional arch=any
 gobjc-6-multilib deb devel optional arch=amd64,i386,kfreebsd-amd64,mips,mips64,mips64el,mipsel,mipsn32,mipsn32el,powerpc,ppc64,s390,s390x,sparc,sparc64,x32
 lib32asan3 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32asan3-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32atomic1 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32atomic1-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gcc-6-dev deb libdevel optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gcc1 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gcc1-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gfortran-6-dev deb libdevel optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gfortran3 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gfortran3-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32go9 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32go9-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gomp1 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gomp1-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gphobos-6-dev deb libdevel optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gphobos68 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32gphobos68-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32objc-6-dev deb libdevel optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32objc4 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32objc4-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32stdc++-6-dev deb libdevel optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32stdc++6 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32stdc++6-6-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32ubsan0 deb libs optional arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib32ubsan0-dbg deb debug extra arch=amd64,ppc64,kfreebsd-amd64,s390x,sparc64,x32,mipsn32,mipsn32el,mips64,mips64el
 lib64asan3 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64asan3-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64atomic1 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64atomic1-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gcc-6-dev deb libdevel optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gcc1 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gcc1-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gfortran-6-dev deb libdevel optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gfortran3 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gfortran3-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64go9 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64go9-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gomp1 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gomp1-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gphobos-6-dev deb libdevel optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gphobos68 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64gphobos68-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64objc-6-dev deb libdevel optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64objc4 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64objc4-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64stdc++-6-dev deb libdevel optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64stdc++6 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64stdc++6-6-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64ubsan0 deb libs optional arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 lib64ubsan0-dbg deb debug extra arch=i386,powerpc,sparc,s390,mips,mipsel,mipsn32,mipsn32el,x32
 libasan3 deb libs optional arch=any
 libasan3-dbg deb debug extra arch=any
 libatomic1 deb libs optional arch=any
 libatomic1-dbg deb debug extra arch=any
 libcc1-0 deb libs optional arch=any
 libgcc-6-dev deb libdevel optional arch=any
 libgcc1 deb libs required arch=any
 libgcc1-dbg deb debug extra arch=any
 libgcc2 deb libs required arch=m68k
 libgcc2-dbg deb debug extra arch=m68k
 libgcc4 deb libs required arch=hppa
 libgcc4-dbg deb debug extra arch=hppa
 libgccjit-6-dev deb libdevel optional arch=any
 libgccjit-6-doc deb doc extra arch=all
 libgccjit0 deb libs optional arch=any
 libgccjit0-dbg deb debug extra arch=any
 libgcj-doc deb doc optional arch=all
 libgcj17 deb libs optional arch=any
 libgcj17-awt deb libs optional arch=any
 libgcj17-dbg deb debug extra arch=any
 libgcj17-dev deb libdevel optional arch=any
 libgfortran-6-dev deb libdevel optional arch=any
 libgfortran3 deb libs optional arch=any
 libgfortran3-dbg deb debug extra arch=any
 libgnat-6 deb libs optional arch=any
 libgnat-6-dbg deb debug extra arch=any
 libgnatprj6 deb libs optional arch=any
 libgnatprj6-dbg deb debug extra arch=any
 libgnatprj6-dev deb libdevel extra arch=any
 libgnatvsn6 deb libs optional arch=any
 libgnatvsn6-dbg deb debug extra arch=any
 libgnatvsn6-dev deb libdevel extra arch=any
 libgo9 deb libs optional arch=any
 libgo9-dbg deb debug extra arch=any
 libgomp1 deb libs optional arch=any
 libgomp1-dbg deb debug extra arch=any
 libgphobos-6-dev deb libdevel optional arch=amd64,armel,armhf,i386,x32,kfreebsd-amd64,kfreebsd-i386
 libgphobos68 deb libs optional arch=amd64,armel,armhf,i386,x32,kfreebsd-amd64,kfreebsd-i386
 libgphobos68-dbg deb debug extra arch=amd64,armel,armhf,i386,x32,kfreebsd-amd64,kfreebsd-i386
 libn32atomic1 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32atomic1-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32gcc-6-dev deb libdevel optional arch=mips,mipsel,mips64,mips64el
 libn32gcc1 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32gcc1-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32gfortran-6-dev deb libdevel optional arch=mips,mipsel,mips64,mips64el
 libn32gfortran3 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32gfortran3-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32go9 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32go9-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32gomp1 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32gomp1-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32objc-6-dev deb libdevel optional arch=mips,mipsel,mips64,mips64el
 libn32objc4 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32objc4-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libn32stdc++-6-dev deb libdevel optional arch=mips,mipsel,mips64,mips64el
 libn32stdc++6 deb libs optional arch=mips,mipsel,mips64,mips64el
 libn32stdc++6-6-dbg deb debug extra arch=mips,mipsel,mips64,mips64el
 libobjc-6-dev deb libdevel optional arch=any
 libobjc4 deb libs optional arch=any
 libobjc4-dbg deb debug extra arch=any
 libstdc++-6-dev deb libdevel optional arch=any
 libstdc++-6-doc deb doc optional arch=all
 libstdc++-6-pic deb libdevel extra arch=any
 libstdc++6 deb libs important arch=any
 libstdc++6-6-dbg deb debug extra arch=any
 libubsan0 deb libs optional arch=any
 libubsan0-dbg deb debug extra arch=any
 libx32asan3 deb libs optional arch=amd64,i386
 libx32asan3-dbg deb debug extra arch=amd64,i386
 libx32atomic1 deb libs optional arch=amd64,i386
 libx32atomic1-dbg deb debug extra arch=amd64,i386
 libx32gcc-6-dev deb libdevel optional arch=amd64,i386
 libx32gcc1 deb libs optional arch=amd64,i386
 libx32gcc1-dbg deb debug extra arch=amd64,i386
 libx32gfortran-6-dev deb libdevel optional arch=amd64,i386
 libx32gfortran3 deb libs optional arch=amd64,i386
 libx32gfortran3-dbg deb debug extra arch=amd64,i386
 libx32go9 deb libs optional arch=amd64,i386
 libx32go9-dbg deb debug extra arch=amd64,i386
 libx32gomp1 deb libs optional arch=amd64,i386
 libx32gomp1-dbg deb debug extra arch=amd64,i386
 libx32gphobos-6-dev deb libdevel optional arch=amd64,i386
 libx32gphobos68 deb libs optional arch=amd64,i386
 libx32gphobos68-dbg deb debug extra arch=amd64,i386
 libx32objc-6-dev deb libdevel optional arch=amd64,i386
 libx32objc4 deb libs optional arch=amd64,i386
 libx32objc4-dbg deb debug extra arch=amd64,i386
 libx32stdc++-6-dev deb libdevel optional arch=amd64,i386
 libx32stdc++6 deb libs optional arch=amd64,i386
 libx32stdc++6-6-dbg deb debug extra arch=amd64,i386
 libx32ubsan0 deb libs optional arch=amd64,i386
 libx32ubsan0-dbg deb debug extra arch=amd64,i386
Checksums-Sha1:
 ff4a5181781fc3e0bd845da6382ad7c25a7b8b45 81587460 gcc-6_6.3.0.orig.tar.gz
 0fc06a07da9c60deaa1517c95f4d8eac17ae86b0 2072985 gcc-6_6.3.0-18+deb9u1+rnx1.diff.gz
Checksums-Sha256:
 04552f04baf6974fb7521191859fb54717385ad659afd822b2995b66ee4e4151 81587460 gcc-6_6.3.0.orig.tar.gz
 ba8bc7d2473c72f5bf933989d2e9c5af3ef1b7bf238f7f2e8c428bde17ff8452 2072985 gcc-6_6.3.0-18+deb9u1+rnx1.diff.gz
Files:
 0da6efcc917b782527c7f19e33649f92 81587460 gcc-6_6.3.0.orig.tar.gz
 ebc963a7b3b21a8bca7d1b0bdb9a086b 2072985 gcc-6_6.3.0-18+deb9u1+rnx1.diff.gz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJh/N7qAAoJEMyaWCvwsWrcAOUQAKBm+Qhvyyrz/kFKcY/4KwbG
tEeUHD3oJGxxvpRj8d+wgVpPYufn0dNukfoCf1hcaNOnesEekCf/AU929qpfnc2u
opTgPIzDBCpt5LmPyFvxptOGBIQ2Pqf7CXyp2PQH2Xgt3ihk14gu5TLemiWaXDj8
Wc+yloENjKEACrUNE/fzwvboS+Dkx9Auhn+I5k9M7KgWCbZho1k/bXDXmBePxipw
cDegQ1vVtx6ROFcQNcmOoiGVvR5bllEdeYWQAOoQWGPPqgT0zKd08y2g7t+qwHXf
3FIOZ/+aBKL4T8TTP/8BUasDmOHIZ0QAl16rJ8a1bA4Fb3RPVBJ+8xHkbmO1i0bS
M8N9HbS+joc8oxBgVRLMqM9RWDVIr+L7/EU2KxwhOEYUte582b16yc912KY6EOIp
c6A7WbFaHvWxbz0BdaFmd2U/jj5Y2Cer3wDttvLE7Bl9Vi5ZHLrS7ieuW+3JbefW
QNAeI12GAQephrO2qcL5dOk8SMGtocfGmWkiPsbGp6uuquVU/UZDvhJpWV3Xln3Y
S0J38zZYHkrlnneigF6jPVN6L6sgF2UrmDRWayNr5vSWllgnWIrG5S3bjzrQN6dL
4CoBMFKs1BQ/HJv+A6KVZbD0OKgJ+0NVzRMIKWUBDFFhn+3N1tv8mlHuvN14c1tA
pDY5bbhpuqI9y6r3UX1i
=uw8w
-----END PGP SIGNATURE-----
