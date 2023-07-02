#!/bin/sh

set -e

saved_dir=$(pwd)
regression_test_dir="debian/regression-test-output"

cleanup() {
    cd ${saved_dir}
    rm -rf ${regression_test_dir}
    if [ -f regress/cred.c.bak ]; then
        mv -f regress/cred.c.bak regress/cred.c
    fi
}

trap cleanup 0 INT QUIT ABRT PIPE TERM

eval "$(dpkg-buildflags --export=sh)"
export CFLAGS="$CFLAGS $CPPFLAGS"
export CXXFLAGS="$CFLAGS $CXXFLAGS"

# regress/ tests are only included when the build type is set to Debug, so
# we build it again in a separate directory as we don't want a Debug build
# in the shipped packages
rm -rf ${regression_test_dir}
mkdir ${regression_test_dir}
echo "Running regression tests"
cd ${regression_test_dir}
cmake -DCMAKE_BUILD_TYPE=Debug ../../
make
echo "SUCCESS: regression tests passed"

# the way the tests are run, by just calling the built binary in a
# post-build hook, makes them super silent. The fact that a binary is even
# being called after the build is not shown. To be sure we really ran the
# tests, let's do it one more time but with an injected failure
cd ${saved_dir}
echo "Injecting a failure and running regression tests again"
sed -r -i.bak 's,exit\(0\);,assert(1 == 0); exit(0); /* force failure */,' regress/cred.c
# if the next grep fails, then the sed above didn't make any changes, and
# we should bail as the "force failure" case isn't valid anymore
result=0
grep "force failure" -q regress/cred.c || result=$?
if [ "$result" -ne 0 ]; then
    echo "ERROR: failure was not injected correctly into regress/cred.c"
    exit $result
fi
rm -rf ${regression_test_dir}
mkdir ${regression_test_dir}
cd ${regression_test_dir}
cmake -DCMAKE_BUILD_TYPE=Debug ../../
result=0
make || result=$?
if [ "$result" -ne 0 ]; then
    echo "SUCCESS: the expected failure happened"
    result=0
else
    echo "ERROR: Expected regression test failure did not happen"
    result=1
fi
cd ${saved_dir}
rm -rf ${regression_test_dir}
mv -f regress/cred.c.bak regress/cred.c
exit $result
