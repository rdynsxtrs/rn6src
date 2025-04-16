#!/bin/sh
# This script will create the following tarballs:
# llvm-toolchain-snapshot-3.2_3.2repack.orig-clang.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-clang-extra.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-compiler-rt.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-lld.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-lldb.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-polly.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-openmp.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-libcxx.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig-libcxxabi.tar.bz2
# llvm-toolchain-snapshot-3.2_3.2repack.orig.tar.bz2

set -e

# TODO rest of the options

# To create an rc1 release:
# sh 4.0/debian/orig-tar.sh RELEASE_40 rc1

SVN_BASE_URL=https://llvm.org/svn/llvm-project/
MAJOR_VERSION=7
CURRENT_VERSION=7.0.1 # Should be changed to 3.5.1 later

if test -n "$1"; then
# https://llvm.org/svn/llvm-project/{cfe,llvm,compiler-rt,...}/branches/google/stable/
# For example: sh 4.0/debian/orig-tar.sh release_400
    BRANCH=$1
fi

if test -n "$1" -a -n "$2"; then
# https://llvm.org/svn/llvm-project/{cfe,llvm,compiler-rt,...}/tags/RELEASE_34/rc1/
# For example: sh 4.0/debian/orig-tar.sh RELEASE_401 rc3 4.0.1
    BRANCH=$1
    TAG=$2
    RCRELEASE="true"
    if test -z "$3"; then
        echo "Please provide the exact version. Used for the tarball name  Ex: 4.0.1"
    fi
    EXACT_VERSION=$3
fi

get_svn_url() {
    MODULE=$1
    BRANCH=$2
    TAG=$3
    if test -n "$TAG"; then
            SVN_URL="$SVN_BASE_URL/$MODULE/tags/$BRANCH/$TAG"
    else
        if test -n "$BRANCH"; then
            SVN_URL="$SVN_BASE_URL/$MODULE/branches/$BRANCH"
        else
            SVN_URL="$SVN_BASE_URL/$MODULE/trunk/"
        fi
    fi
    echo $SVN_URL
}

get_higher_revision() {
    PROJECTS="llvm cfe compiler-rt polly lld lldb clang-tools-extra"
    REVISION_MAX=0
    for f in $PROJECTS; do
        REVISION=$(LANG=C svn info $(get_svn_url $f $BRANCH $TAG)|grep "^Last Changed Rev:"|awk '{print $4}')
        if test $REVISION -gt $REVISION_MAX; then
            REVISION_MAX=$REVISION
        fi
    done
    echo $REVISION_MAX
}

SVN_ARCHIVES=svn-archives

checkout_sources() {
    PROJECT=$1
    URL=$2
    TARGET=$3
    BRANCH=$4
    if test -n "$BRANCH"; then
        REVISION=$5
    fi
    echo "$PROJECT / $URL / $BRANCH / $TARGET / $REVISION"

    cd $SVN_ARCHIVES/
    DEST=$PROJECT-$BRANCH
    if test -n "$TAG"; then
	DEST=$DEST-$TAG
    fi
    if test -d $DEST; then
        cd $DEST
        if test -n "$BRANCH"; then
            svn cleanup
            svn up
        else
            svn cleanup
            svn up -r $REVISION
        fi
        cd ..
    else
        if test -n "$BRANCH"; then
            svn co $URL $DEST
        else
            svn co -r $REVISION $URL $DEST
        fi
    fi
    rm -rf ../$TARGET
    rsync -r --exclude=.svn $DEST/ ../$TARGET
    cd ..
}

if test -n "$BRANCH"; then
    REVISION=$(get_higher_revision)
    # Do not use the revision when exporting branch. We consider that all the
    # branch are sync
    SVN_CMD="svn export"
else
    REVISION=$(LANG=C svn info $(get_svn_url llvm)|grep "^Revision:"|awk '{print $2}')
    SVN_CMD="svn export -r $REVISION"
fi

if test -n "$RCRELEASE"; then
    if test "$TAG" = "final"; then
	    VERSION=$EXACT_VERSION
    else
        VERSION=$EXACT_VERSION"~+"$TAG
    fi
    FULL_VERSION="llvm-toolchain-"$MAJOR_VERSION"_"$VERSION
else
    VERSION=$CURRENT_VERSION"~svn"$REVISION
    if echo $BRANCH|grep -q release_; then
	FULL_VERSION="llvm-toolchain-"$MAJOR_VERSION"_"$VERSION
    else
	FULL_VERSION="llvm-toolchain-snapshot_"$VERSION
    fi
fi

mkdir -p $SVN_ARCHIVES

# LLVM
LLVM_TARGET=$FULL_VERSION
checkout_sources llvm $(get_svn_url llvm $BRANCH $TAG) $LLVM_TARGET "$BRANCH" $REVISION
tar jcf $FULL_VERSION.orig.tar.bz2 $LLVM_TARGET
rm -rf $LLVM_TARGET


# Clang
CLANG_TARGET=clang_$VERSION
checkout_sources clang $(get_svn_url cfe $BRANCH $TAG) $CLANG_TARGET "$BRANCH" $REVISION
tar jcf $FULL_VERSION.orig-clang.tar.bz2 $CLANG_TARGET
rm -rf $CLANG_TARGET


# Clang extra
CLANG_TARGET=clang-tools-extra_$VERSION
checkout_sources clang-tools-extra $(get_svn_url clang-tools-extra $BRANCH $TAG) $CLANG_TARGET "$BRANCH" $REVISION
tar jcf $FULL_VERSION.orig-clang-tools-extra.tar.bz2 $CLANG_TARGET
rm -rf $CLANG_TARGET

# Compiler-rt
COMPILER_RT_TARGET=compiler-rt_$VERSION
checkout_sources compiler-rt $(get_svn_url compiler-rt $BRANCH $TAG) $COMPILER_RT_TARGET "$BRANCH" $REVISION
#$SVN_CMD $(get_svn_url compiler-rt $BRANCH $TAG) $COMPILER_RT_TARGET
tar jcf $FULL_VERSION.orig-compiler-rt.tar.bz2 $COMPILER_RT_TARGET
rm -rf $COMPILER_RT_TARGET

# Polly
POLLY_TARGET=polly_$VERSION
checkout_sources polly $(get_svn_url polly $BRANCH $TAG) $POLLY_TARGET "$BRANCH" $REVISION
#$SVN_CMD $(get_svn_url polly $BRANCH $TAG) $POLLY_TARGET
rm -rf $POLLY_TARGET/www $POLLY_TARGET/autoconf/config.sub $POLLY_TARGET/autoconf/config.guess
tar jcf $FULL_VERSION.orig-polly.tar.bz2 $POLLY_TARGET
rm -rf $POLLY_TARGET

# LLD
LLD_TARGET=lld_$VERSION
checkout_sources lld $(get_svn_url lld $BRANCH $TAG) $LLD_TARGET "$BRANCH" $REVISION
#$SVN_CMD $(get_svn_url lld $BRANCH $TAG) $LLD_TARGET
rm -rf $LLD_TARGET/www/
tar jcf $FULL_VERSION.orig-lld.tar.bz2 $LLD_TARGET
rm -rf $LLD_TARGET

# LLDB
LLDB_TARGET=lldb_$VERSION
checkout_sources lldb $(get_svn_url lldb $BRANCH $TAG) $LLDB_TARGET "$BRANCH" $REVISION
#$SVN_CMD $(get_svn_url lldb $BRANCH $TAG) $LLDB_TARGET
rm -rf $LLDB_TARGET/www/
tar jcf $FULL_VERSION.orig-lldb.tar.bz2 $LLDB_TARGET
rm -rf $LLDB_TARGET

# OPENMP
OPENMP_TARGET=openmp_$VERSION
checkout_sources openmp $(get_svn_url openmp $BRANCH $TAG) $OPENMP_TARGET "$BRANCH" $REVISION
rm -rf $OPENMP_TARGET/www/
tar jcf $FULL_VERSION.orig-openmp.tar.bz2 $OPENMP_TARGET
rm -rf $OPENMP_TARGET

# LIBCXX
LIBCXX_TARGET=libcxx_$VERSION
checkout_sources libcxx $(get_svn_url libcxx $BRANCH $TAG) $LIBCXX_TARGET "$BRANCH" $REVISION
rm -rf $LIBCXX_TARGET/www/
tar jcf $FULL_VERSION.orig-libcxx.tar.bz2 $LIBCXX_TARGET
rm -rf $LIBCXX_TARGET

# LIBCXXABI
LIBCXXABI_TARGET=libcxxabi_$VERSION
checkout_sources libcxxabi $(get_svn_url libcxxabi $BRANCH $TAG) $LIBCXXABI_TARGET "$BRANCH" $REVISION
rm -rf $LIBCXXABI_TARGET/www/
tar jcf $FULL_VERSION.orig-libcxxabi.tar.bz2 $LIBCXXABI_TARGET
rm -rf $LIBCXXABI_TARGET


PATH_DEBIAN="$(pwd)/$(dirname $0)/../"
echo "going into $PATH_DEBIAN"
export DEBFULLNAME="Sylvestre Ledru"
export DEBEMAIL="sylvestre@debian.org"
cd $PATH_DEBIAN

if test -z "$DISTRIBUTION"; then
    DISTRIBUTION="experimental"
fi

if test -n "$RCRELEASE" -o -n "$BRANCH"; then
    EXTRA_DCH_FLAGS="--force-bad-version --allow-lower-version"
fi

dch $EXTRA_DCH_FLAGS --distribution $DISTRIBUTION --newversion 1:$VERSION-1~exp1 "New snapshot release"

exit 0
