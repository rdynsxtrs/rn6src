#!/bin/sh
ORIG_VERSION=6.0
TARGET_VERSION=7.0
ORIG_VERSION_2=6_0
TARGET_VERSION_2=7_0
ORIG_VERSION_3=60
TARGET_VERSION_3=70

LIST=`ls debian/control debian/orig-tar.sh debian/rules debian/patches/clang-analyzer-force-version.diff debian/patches/clang-format-version.diff debian/patches/python-clangpath.diff debian/patches/scan-build-clang-path.diff debian/patches/lldb-libname.diff debian/patches/fix-scan-view-path.diff debian/patches/lldb-addversion-suffix-to-llvm-server-exec.patch debian/patches/clang-tidy-run-bin.diff debian/patches/clang-apply-replacements.diff debian/patches/fix-scan-view-path.diff debian/qualify-clang.sh debian/README debian/tests/control`
for F in $LIST; do
    sed -i -e "s|$ORIG_VERSION_3|$TARGET_VERSION_3|g" $F
    sed -i -e "s|$ORIG_VERSION_2|$TARGET_VERSION_2|g" $F
    sed -i -e "s|$ORIG_VERSION|$TARGET_VERSION|g" $F
done

echo "once you copy the old version into a new branch"
echo "edit debian/control, update the VCS links"
echo "edit debian/control, update the source pkg name"
echo "edit debian/changelog, update the source pkg name"
