set -e
ORIG_VERSION=7
MAJOR_VERSION=7.0.1
SVN_REV=`ls -1 *-${ORIG_VERSION}*svn*bz2 | tail -1|perl -ne 'print "$1\n" if /svn(\d+)/;' | sort -ru`
#SVN_REV=353565
VERSION=svn$SVN_REV
#VERSION=+rc3
LLVM_ARCHIVE=llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig.tar.bz2
echo "unpack of $LLVM_ARCHIVE"
tar jxf $LLVM_ARCHIVE
cd llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION/ || ( echo "Bad SVN_REV:\"$SVN_REV\"" && exit 1 )
for f in ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-clang.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-clang-tools-extra.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-compiler-rt.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-lldb.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-polly.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-libcxxabi.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-libcxx.tar.bz2 ../llvm-toolchain-${ORIG_VERSION}_$MAJOR_VERSION~$VERSION.orig-openmp.tar.bz2; do
	echo "Unpack of $f"
 	tar jxf $f
 done

ln -s clang_$MAJOR_VERSION~$VERSION clang
ln -s clang-tools-extra_$MAJOR_VERSION~$VERSION clang-tools-extra
ln -s compiler-rt_$MAJOR_VERSION~$VERSION compiler-rt
ln -s polly_$MAJOR_VERSION~$VERSION polly
ln -s lldb_$MAJOR_VERSION~$VERSION lldb
ln -s openmp_$MAJOR_VERSION~$VERSION openmp
ln -s libcxx_$MAJOR_VERSION~$VERSION libcxx
ln -s libcxxabi_$MAJOR_VERSION~$VERSION libcxxabi

cp -R ../$ORIG_VERSION/debian .
QUILT_PATCHES=debian/patches/ quilt push -a --fuzz=0
