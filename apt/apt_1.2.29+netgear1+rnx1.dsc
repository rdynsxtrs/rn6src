-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 3.0 (native)
Source: apt
Binary: apt, libapt-pkg5.0, libapt-inst2.0, apt-doc, libapt-pkg-dev, libapt-pkg-doc, apt-utils, apt-transport-https
Architecture: any all
Version: 1.2.29+netgear1+rnx1
Maintainer: APT Development Team <deity@lists.debian.org>
Uploaders: Michael Vogt <mvo@debian.org>, Julian Andres Klode <jak@debian.org>
Standards-Version: 3.9.7
Vcs-Browser: https://anonscm.debian.org/cgit/apt/apt.git
Vcs-Git: git://anonscm.debian.org/apt/apt.git
Testsuite: autopkgtest
Build-Depends: dpkg-dev (>= 1.17.14), debhelper (>= 9.20141010), libdb-dev, gettext (>= 0.12), libcurl4-gnutls-dev (>= 7.19.4~), zlib1g-dev, libbz2-dev, liblzma-dev, liblz4-dev (>= 0.0~r126), xsltproc, docbook-xsl, docbook-xml, po4a (>= 0.34-2), autotools-dev, autoconf, automake, libgtest-dev <!nocheck>, dh-systemd
Build-Depends-Indep: doxygen, w3m, graphviz
Build-Conflicts: autoconf2.13, automake1.4
Package-List:
 apt deb admin important arch=any
 apt-doc deb doc optional arch=all
 apt-transport-https deb admin optional arch=any
 apt-utils deb admin important arch=any
 libapt-inst2.0 deb libs important arch=any
 libapt-pkg-dev deb libdevel optional arch=any
 libapt-pkg-doc deb doc optional arch=all
 libapt-pkg5.0 deb libs important arch=any
Checksums-Sha1:
 65c2155d6d6fbd3dccb99a6c002a58a4b6d9f1f0 2077912 apt_1.2.29+netgear1+rnx1.tar.xz
Checksums-Sha256:
 b5b7695dc4c804e06b2e0a3701eb6f1709ad3a62f977fbf56b0c70b09618687b 2077912 apt_1.2.29+netgear1+rnx1.tar.xz
Files:
 cd733b02e3e2b32e9a1cba58172da071 2077912 apt_1.2.29+netgear1+rnx1.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmdBxz8ACgkQ9hPx6x3pnw8gDwCgqEiepet2KtELtoKFQwPvG/Sm
MekAn2swNwKSMl8KS04SbiWZIVsFwauj
=Rg42
-----END PGP SIGNATURE-----
