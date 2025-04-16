#!/bin/bash
# Stop at the first error
set -e
if ! test -d debian/; then
    echo "$0: Could not find the debian/ directory"
    exit 1
fi
VERSION=$(dpkg-parsechangelog | sed -rne "s,^Version: 1:([0-9]+).*,\1,p")
DETAILED_VERSION=$(dpkg-parsechangelog |  sed -rne "s,^Version: 1:([0-9.]+)(~|-)(.*),\1\2\3,p")
DEB_HOST_ARCH=$(dpkg-architecture -qDEB_HOST_ARCH)

LIST="libomp5-${VERSION}_${DETAILED_VERSION}_amd64.deb libomp-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb lldb-${VERSION}_${DETAILED_VERSION}_amd64.deb python-lldb-${VERSION}_${DETAILED_VERSION}_amd64.deb libllvm7_${DETAILED_VERSION}_amd64.deb llvm-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb liblldb-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb  libclang1-${VERSION}_${DETAILED_VERSION}_amd64.deb  libclang-common-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb  llvm-${VERSION}_${DETAILED_VERSION}_amd64.deb  liblldb-${VERSION}_${DETAILED_VERSION}_amd64.deb  llvm-${VERSION}-runtime_${DETAILED_VERSION}_amd64.deb lld-${VERSION}_${DETAILED_VERSION}_amd64.deb libfuzzer-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libclang-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++abi-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++1-${VERSION}_${DETAILED_VERSION}_amd64.deb libc++abi1-${VERSION}_${DETAILED_VERSION}_amd64.deb clang-${VERSION}_${DETAILED_VERSION}_amd64.deb llvm-${VERSION}-tools_${DETAILED_VERSION}_amd64.deb clang-tools-${VERSION}_${DETAILED_VERSION}_amd64.deb clang-${VERSION}-dbgsym_${DETAILED_VERSION}_amd64.deb libclang1-${VERSION}-dbgsym_${DETAILED_VERSION}_amd64.deb"
echo "To install everything:"
echo "sudo dpkg -i $LIST"
L=""
for f in $LIST; do
    L="$L $(echo $f|cut -d_ -f1)"
done
echo "or"
echo "apt-get install $L"

if test ! -f /usr/bin/llvm-config-$VERSION; then
    echo "Install llvm-$VERSION & llvm-$VERSION-dev"
    exit 1
fi
if test ! -f /usr/lib/llvm-$VERSION/lib/libLLVM-$VERSION.so; then
    echo "Install llvm-$VERSION-dev"
    exit 1
fi
llvm-config-$VERSION --link-shared --libs &> /dev/null

if llvm-config-$VERSION --cxxflags | grep " \-W"; then
    echo "llvm-config should not export -W warnings"
    exit 1
fi

# Test https://bugs.llvm.org/show_bug.cgi?id=40059
nm /usr/lib/llvm-$VERSION/lib/libLLVMBitWriter.a &> foo.log
if grep "File format not recognized" foo.log; then
    echo "nm libLLVMBitWriter.a contains 'File format not recognized'"
    exit 1
fi

echo '#include <stdlib.h>
int main() {
  char *x = (char*)malloc(10 * sizeof(char*));
  free(x);
  return x[5];
}
' > foo.c
clang-$VERSION -o foo -fsanitize=address -O1 -fno-omit-frame-pointer -g  foo.c
if ! ./foo 2>&1 | grep -q heap-use-after-free ; then
    echo "sanitize=address is failing"
    exit 42
fi

if test ! -f /usr/bin/scan-build-$VERSION; then
    echo "Install clang-tools-$VERSION"
    exit 1
fi

echo '
void test() {
  int x;
  x = 1; // warn
}
'> foo.c

scan-build-$VERSION -o scan-build gcc -c foo.c &> /dev/null || true
scan-build-$VERSION -o scan-build clang-$VERSION -c foo.c &> /dev/null
rm -rf scan-build

echo 'int main() {return 0;}' > foo.c
clang-$VERSION foo.c

echo '#include <stddef.h>' > foo.c
clang-$VERSION -c foo.c

# https://bugs.launchpad.net/bugs/1810860
clang-$VERSION -dumpversion &> foo.log
if grep 4.2.1 foo.log; then
    echo "dumpversion still returns 4.2.1"
#    exit 1
fi

# bug 903709
echo '#include <stdatomic.h>
void increment(atomic_size_t *arg) {
    atomic_fetch_add(arg, 1);
} ' > foo.c

clang-$VERSION -v -c foo.c

echo "#include <fenv.h>" > foo.cc
NBLINES=$(clang++-$VERSION -P -E foo.cc|wc -l)
if test $NBLINES -lt 100; then
    echo "Error: more than 100 lines should be returned"
    exit 42
fi

echo '#include <emmintrin.h>' > foo.cc
clang++-$VERSION -c foo.cc

# Bug 913213
echo '#include <limits.h>' | clang-$VERSION -E - > /dev/null

# Bug launchpad #1488254
echo '
#include <string>
std::string hello = "Hello, world!\n";
' > foo.cc

echo '
#include <string>
#include <iostream>
extern std::string hello;
int main() {
    std::cout << hello;
    return 0;
} ' > bar.cc

g++ -c foo.cc && g++ foo.o bar.cc && ./a.out  > /dev/null || true
clang++-$VERSION -c foo.cc && clang++-$VERSION foo.o bar.cc && ./a.out  > /dev/null
g++ -c foo.cc && clang++-$VERSION foo.o bar.cc && ./a.out  > /dev/null || true
clang++-$VERSION -c foo.cc -fPIC && g++ foo.o bar.cc && ./a.out > /dev/null || true

# bug 827866
echo 'bool testAndSet(void *atomic) {
    return __atomic_test_and_set(atomic, __ATOMIC_SEQ_CST);
}'> foo.cpp
clang++-$VERSION -c -target aarch64-linux-gnu foo.cpp
if ! file foo.o 2>&1 | grep -i -q "aarch64"; then
    echo "Could not find the string 'aarch64' in the output of file. Output:"
    file foo.o
    exit 42
fi
echo '
#include <string.h>
int
main ()
{
  (void) strcat;
  return 0;
}' > foo.c
clang-$VERSION -c foo.c

echo '#include <errno.h>
int main() {} ' > foo.c
clang-$VERSION foo.c

echo '#include <chrono>
int main() { }' > foo.cpp
clang++-$VERSION -std=c++11 foo.cpp

echo '#include <stdio.h>
int main() {
if (1==1) {
	printf("true");
}else{
	printf("false");
	return 42;
}
return 0;}' > foo.c
clang-$VERSION --coverage foo.c -o foo
./foo > /dev/null
if test ! -f foo.gcno; then
    echo "Coverage failed";
fi

echo "#include <iterator>" > foo.cpp
clang++-$VERSION -c foo.cpp


echo '#include <stdio.h>
int main() {
if (1==1) {
  printf("true");
}else{
  printf("false");
  return 42;
}
return 0;}' > foo.c
rm foo bar.cc

if test ! -f /usr/lib/llvm-$VERSION/bin/../lib/LLVMgold.so; then
    echo "Install llvm-$VERSION-dev"
    exit 1
fi

clang-$VERSION -flto foo.c -o foo
./foo > /dev/null

clang-$VERSION -fuse-ld=gold foo.c -o foo
./foo > /dev/null

# test thinlto
echo "int foo(void) {	return 0; }"> foo.c
echo "int foo(void); int main() {foo();	return 0;}">main.c
clang-$VERSION -flto=thin -O2 foo.c main.c -o foo
./foo > /dev/null
clang-$VERSION -flto=thin -O2 foo.c main.c -c

if test ! -f /usr/bin/lld-$VERSION; then
    echo "Install lld-$VERSION"
    exit 1
fi
clang-$VERSION -fuse-ld=lld -O2 foo.c main.c -o foo
./foo > /dev/null

clang-$VERSION -fuse-ld=lld -flto -O2 foo.c main.c -o foo
./foo > /dev/null

clang-$VERSION -fuse-ld=lld-$VERSION -O2 foo.c main.c -o foo
./foo > /dev/null

# Bug 916975
file foo &> foo.log
if ! grep -q "BuildID" foo.log; then
    echo "BuildID isn't part of the generated binary (lld generation)"
    exit 1
fi
# Bug 916975
clang-$VERSION -O2 foo.c main.c -o foo2
file foo2 &> foo2.log
if ! grep "BuildID" foo2.log; then
    echo "BuildID isn't part of the generated binary (ld generation)"
    exit 1
fi

strip foo2
file foo2 &> foo2.log
if ! grep "BuildID" foo2.log; then
    echo "BuildID isn't part of the generated binary (stripped)"
    exit 1
fi
rm foo2 foo2.log

cat << EOF > test_fuzzer.cc
#include <stdint.h>
#include <stddef.h>
extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  if (size > 0 && data[0] == 'H')
    if (size > 1 && data[1] == 'I')
       if (size > 2 && data[2] == '!')
       __builtin_trap();
  return 0;
}
EOF

echo 'int main(int argc, char **argv) {
  int *array = new int[100];
  delete [] array;
  return array[argc];  // BOOM
}' > foo.cpp
clang++-$VERSION -O1 -g -fsanitize=address -fno-omit-frame-pointer foo.cpp
ASAN_OPTIONS=verbosity=1 ./a.out &> foo.log || true
if ! grep "Init done" foo.log; then
    echo "asan verbose mode failed"
    cat foo.log
    exit 42
fi

if test ! -f /usr/lib/llvm-$VERSION/bin/llvm-symbolizer; then
    echo "Install llvm-$VERSION"
    exit 1
fi

# See also https://bugs.llvm.org/show_bug.cgi?id=39514 why
# /usr/bin/llvm-symbolizer-7 doesn't work
ASAN_OPTIONS=verbosity=2:external_symbolizer_path=/usr/lib/llvm-$VERSION/bin/llvm-symbolizer ./a.out &> foo.log || true
if ! grep "Using llvm-symbolizer" foo.log; then
    echo "could not find llvm-symbolizer path"
    cat foo.log
    exit 42
fi
if ! grep "new\[\](unsigned" foo.log; then
    echo "could not symbolize correctly"
    cat foo.log
    exit 42
fi

if ! grep "foo.cpp:3:3" foo.log; then
    echo "could not symbolize correctly"
    cat foo.log
    exit 42
fi
./a.out &> foo.log || true
if ! grep "new\[\](unsigned" foo.log; then
    echo "could not symbolize correctly"
    cat foo.log
    exit 42
fi

if ! grep "foo.cpp:3:3" foo.log; then
    echo "could not symbolize correctly"
    cat foo.log
    exit 42
fi

if test ! -f /usr/lib/llvm-$VERSION/lib/libFuzzer.a; then
    echo "Install libfuzzer-$VERSION-dev";
    exit -1;
fi

clang++-$VERSION -fsanitize=address -fsanitize-coverage=edge,trace-pc test_fuzzer.cc /usr/lib/llvm-$VERSION/lib/libFuzzer.a
if ! ./a.out 2>&1 | grep -q -E "(Test unit written|PreferSmall)"; then
    echo "fuzzer"
    exit 42
fi

# Bug #876973
echo '
#include <stdio.h>
int main(int argc, char **argv)
{
   printf("Hello world!\n");
   return 0;
}' > foo.c

# segfaults on 32bit with "-lc" library (also 6.0 does segfault)
clang-$VERSION -fsanitize=address foo.c -o foo -lc
./foo &> /dev/null || true

# fails on 32 bit, seems a real BUG in the package, using 64bit static libs?
LANG=C clang-$VERSION -fsanitize=fuzzer test_fuzzer.cc &> foo.log || true
if ! grep "No such file or directory" foo.log; then
    # This isn't failing on 64, so, look at the results
    if ! ./a.out 2>&1 | grep -q -E "(Test unit written|PreferSmall)"; then
        echo "fuzzer"
        exit 42
    fi
fi

echo 'int main() {
	int a=0;
	return a;
}
' > foo.c
clang-$VERSION -g -o bar foo.c

# ABI issue between gcc & clang
# https://bugs.llvm.org/show_bug.cgi?id=39427
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=913271
echo '
#include <llvm/ADT/ArrayRef.h>
#include <llvm/ADT/Optional.h>
namespace llvm { class Constant{}; class Type; class Value; }
extern llvm::Constant* bar (llvm::Type*, llvm::Constant*, llvm::ArrayRef<llvm::Value*>, bool, llvm::Optional<unsigned> o, llvm::Type*);
#ifdef PART2
llvm::Constant* bar (llvm::Type*, llvm::Constant*, llvm::ArrayRef<llvm::Value*>, bool, llvm::Optional<unsigned> o, llvm::Type*)
{
   return o.hasValue()?static_cast<llvm::Constant*>(nullptr)+1:nullptr;
}
#endif
#ifndef PART2
static llvm::Constant* doConstantRef(llvm::Type* type, llvm::Constant* var, llvm::ArrayRef<llvm::Value*> steps)
{
   llvm::Optional<unsigned> inRangeIndex;
   return bar(type, var, steps, false, inRangeIndex, nullptr);
}
bool foo()
{
   llvm::Constant* var = nullptr;
   llvm::Value* zero = nullptr;
   llvm::Value* indexes[2] = {zero, zero};
   llvm::ArrayRef<llvm::Value*> steps(indexes, 2);
   auto result = doConstantRef(nullptr, var, steps);
   return result;
}
int main()
{
   return foo();
}
#endif
' > foo.cpp
FLAGS="-I/usr/lib/llvm-$VERSION/include -fPIC -fvisibility-inlines-hidden -Werror=date-time -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-long-long -Wdelete-non-virtual-dtor -Wno-comment -ffunction-sections -fdata-sections -fno-common -Woverloaded-virtual -fno-strict-aliasing -fPIC -fvisibility-inlines-hidden -Werror=date-time -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -pedantic -Wno-long-long -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -ffunction-sections -fdata-sections -O2 -DNDEBUG  -fno-exceptions -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS"

clang++-$VERSION -c -o part1.o foo.cpp $FLAGS
if test -f /usr/bin/g++; then
    g++ -c -o part2.o -DPART2 foo.cpp $FLAGS
    clang++-$VERSION -o foo part1.o part2.o $FLAGS
    ./foo
fi
rm part1.o part2.o

if test ! -f /usr/lib/llvm-$VERSION/lib/libomp.so; then
    echo "Install libomp-$VERSION-dev";
    exit -1;
fi

# OpenMP
cat <<EOF > foo.c
//test.c
#include "omp.h"
#include <stdio.h>

int main(void) {
  #pragma omp parallel
  printf("thread %d\n", omp_get_thread_num());
}
EOF
clang-$VERSION foo.c -fopenmp -o o
./o > /dev/null

if test ! -f /usr/lib/llvm-$VERSION/include/c++/v1/vector; then
    echo "Install libc++-$VERSION-dev";
    exit -1;
fi

# libc++
echo '
#include <vector>
#include <string>
#include <iostream>
using namespace std;
int main(void) {
    vector<string> tab;
    tab.push_back("the");
    tab.push_back("world");
    tab.insert(tab.begin(), "Hello");

    for(vector<string>::iterator it=tab.begin(); it!=tab.end(); ++it)
    {
        cout << *it << " ";
    }
    return 0;
}' > foo.cpp
clang++-$VERSION -stdlib=libc++ foo.cpp -o o
if ! ldd o 2>&1|grep -q  libc++.so.1; then
    echo "not linked against libc++.so.1"
    exit -1
fi
if ! ldd o 2>&1|grep -q  libc++abi.so.1; then
    echo "not linked against libc++abi.so.1"
    exit -1
fi

./o > /dev/null
clang++-$VERSION -std=c++11 -stdlib=libc++ foo.cpp -o o
./o > /dev/null
clang++-$VERSION -std=c++14 -stdlib=libc++ foo.cpp -lc++experimental -o o
./o > /dev/null

# Bug 889832
echo '#include <iostream>
int main() {}'  | clang++-$VERSION -std=c++1z  -x c++ -stdlib=libc++ -

if test ! -f /usr/lib/llvm-$VERSION/include/cxxabi.h; then
    echo "Install libc++abi-$VERSION-dev";
    exit -1;
fi

# Force the usage of libc++abi
clang++-$VERSION -stdlib=libc++ -lc++abi foo.cpp -o o
./o > /dev/null
if ! ldd o 2>&1|grep -q  libc++abi.so.1; then
    echo "not linked against libc++abi.so.1"
    exit -1
fi

# Use the libc++abi and uses the libstc++ headers
clang++-$VERSION -lc++abi foo.cpp -o o
./o > /dev/null
if ! ldd o 2>&1|grep -q libstdc++.so.; then
    echo "not linked against libstdc++"
    exit -1
fi

# fs from C++17
echo '
#include <filesystem>
#include <type_traits>
using namespace std::filesystem;
int main() {
  static_assert(std::is_same<
          path,
          std::filesystem::path
      >::value, "");
}' > foo.cpp
clang++-$VERSION -std=c++17 -stdlib=libc++ foo.cpp -lc++experimental -lc++fs -o o
./o > /dev/null

# Bug LP#1586215
echo '
#include <string>
#include <iostream>

int main()
{
    try
    {
        std::string x;
        char z = x.at(2);
        std::cout << z << std::endl;
    }
    catch (...)
    {
    }

    return 0;
}' > foo.cpp
clang++-$VERSION -stdlib=libc++ -Wall -Werror foo.cpp -o foo
./foo

# Bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914201
echo '
#include <math.h>
int main(void)
{
    double f = 2.0;
    if (isnan(f))
      return 1;
    return 0;
}' > foo.c
clang-$VERSION -Wconversion -Werror foo.c || true

if test -f /usr/bin/g++; then
g++ -nostdinc++ -I/usr/lib/llvm-$VERSION/bin/../include/c++/v1/ -L/usr/lib/llvm-$VERSION/lib/ \
    foo.cpp -nodefaultlibs -std=c++17 -lc++ -lc++abi -lm -lc -lgcc_s -lgcc|| true
./o > /dev/null
fi


if test ! -f /usr/lib/llvm-$VERSION/include/polly/LinkAllPasses.h; then
    echo "Install libclang-common-$VERSION-dev for polly";
    exit -1;
fi

# Polly
echo "
#define N 1536
float A[N][N];
float B[N][N];
float C[N][N];

void init_array()
{
    int i, j;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            A[i][j] = (1+(i*j)%1024)/2.0;
            B[i][j] = (1+(i*j)%1024)/2.0;
        }
    }
}

int main()
{
    int i, j, k;
    double t_start, t_end;
    init_array();
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
            for (k = 0; k < N; k++)
                C[i][j] = C[i][j] + A[i][k] * B[k][j];
        }
    }
    return 0;
}
" > foo.c
clang-$VERSION -O3 -mllvm -polly foo.c
clang-$VERSION -O3 -mllvm -polly -mllvm -polly-parallel -lgomp foo.c
clang-$VERSION -O3 -mllvm -polly -mllvm -polly-vectorizer=stripmine foo.c
clang-$VERSION -S -fsave-optimization-record -emit-llvm foo.c -o matmul.s
opt-$VERSION -S -polly-canonicalize matmul.s > matmul.preopt.ll > /dev/null
opt-$VERSION -basicaa -polly-ast -analyze -q matmul.preopt.ll -polly-process-unprofitable > /dev/null
if test ! -f /usr/lib/llvm-$VERSION/share/opt-viewer/opt-viewer.py; then
    echo "Install llvm-$VERSION-tools"
    exit 42
fi
/usr/lib/llvm-$VERSION/share/opt-viewer/opt-viewer.py -source-dir .  matmul.opt.yaml -o ./output > /dev/null

if ! grep "not inlined into" output/foo.c.html 2>&1; then
    echo "Could not find the output from polly"
    exit -1
fi

echo "
int foo(int x, int y) __attribute__((always_inline));
int foo(int x, int y) { return x + y; }
int bar(int j) { return foo(j, j - 2); }" > foo.cc
clang-$VERSION -O2 -Rpass=inline foo.cc -c &> foo.log
if ! grep "with cost=always" foo.log; then
    echo "-Rpass fails"
    cat foo.log
    exit 1
fi
echo "
int X = 0;

int main() {
  int i;
  for (i = 0; i < 100; i++)
    X += i;
  return 0;
}"> foo.cc
clang++-$VERSION -O2 -fprofile-instr-generate foo.cc -o foo
LLVM_PROFILE_FILE="foo-%p.profraw" ./foo
llvm-profdata-$VERSION merge -output=foo.profdata foo-*.profraw
clang++-$VERSION -O2 -fprofile-instr-use=foo.profdata foo.cc -o foo

echo "b main
run
bt
quit" > lldb-cmd.txt

if test ! -f /usr/bin/lldb-$VERSION; then
    echo "Install lldb-$VERSION";
    exit -1;
fi

# bug 913946
lldb-$VERSION -s lldb-cmd.txt bar
if dpkg -l|grep -q clang-$VERSION-dbgsym; then
    # Testing if clang dbg symbol are here
    lldb-$VERSION -s lldb-cmd.txt clang-$VERSION &> foo.log
    if ! grep "main at driver.cpp" foo.log; then
        echo "Could not find the debug info"
        echo "Or the main() of clang isn't in driver.cpp anymore"
        exit -1
    fi
else
    echo "clang-$VERSION-dbgsym isn't installed"
fi

echo '
#include <vector>
int main (void)
{  std::vector<int> a;
  a.push_back (0);
}
' > foo.cpp
clang++-$VERSION -g -o foo foo.cpp
echo 'target create "./foo"
b main
r
n
p a
quit' > lldb-cmd.txt
lldb-$VERSION -s lldb-cmd.txt ./foo

echo "int main() { return 1; }" > foo.c
# fails to run on i386 with the following error:
#clang: error: unsupported option '-fsanitize=efficiency-working-set' for target 'i686-pc-linux-gnu'
clang-$VERSION -fsanitize=efficiency-working-set -o foo foo.c || true
./foo > /dev/null || true


if test ! -f /usr/lib/llvm-$VERSION/lib/libclangToolingInclusions.a; then
    echo "Install libclang-$VERSION-dev";
    exit -1;
fi

rm -rf cmaketest && mkdir cmaketest
cat > cmaketest/CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 2.8.12)
project(SanityCheck)
find_package(LLVM $VERSION REQUIRED CONFIG)
message(STATUS "LLVM_CMAKE_DIR: \${LLVM_CMAKE_DIR}")
if(NOT EXISTS "\${LLVM_TOOLS_BINARY_DIR}/clang")
message(FATAL_ERROR "Invalid LLVM_TOOLS_BINARY_DIR: \${LLVM_TOOLS_BINARY_DIR}")
endif()
# TODO add version to ClangConfig.cmake and use $VERSION below
find_package(Clang REQUIRED CONFIG)
find_file(H clang/AST/ASTConsumer.h PATHS \${CLANG_INCLUDE_DIRS} NO_DEFAULT_PATH)
message(STATUS "CLANG_INCLUDE_DIRS: \${CLANG_INCLUDE_DIRS}")
if(NOT H)
message(FATAL_ERROR "Invalid Clang header path: \${CLANG_INCLUDE_DIRS}")
endif()
EOF
mkdir cmaketest/standard cmaketest/explicit
echo "Test: CMake find LLVM and Clang in default path"
(cd cmaketest/standard && CC=clang-$VERSION CXX=clang++-$VERSION cmake .. > /dev/null)
echo "Test: CMake find LLVM and Clang in explicit prefix path"
(cd cmaketest/explicit && CC=clang-$VERSION CXX=clang++-$VERSION CMAKE_PREFIX_PATH=/usr/lib/llvm-$VERSION cmake .. > /dev/null)
rm -rf cmaketest

# Test case for bug #900440
rm -rf cmaketest && mkdir cmaketest
cat > cmaketest/CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 2.8.12)
project(testllvm)

find_package(LLVM CONFIG REQUIRED)
find_package(Clang CONFIG REQUIRED)

if(NOT LLVM_VERSION STREQUAL Clang_VERSION)
    #message(FATAL_ERROR "LLVM ${LLVM_VERSION} not matching to Clang ${Clang_VERSION}")
endif()
EOF
mkdir cmaketest/foo/
(cd cmaketest/foo && cmake .. > /dev/null)
rm -rf cmaketest




CLANG=clang-$VERSION
#command -v "$CLANG" 1>/dev/null 2>/dev/null || { printf "Usage:\n%s CLANGEXE [ARGS]\n" "$0" 1>&2; exit 1; }
#shift

TEMPDIR=$(mktemp -d); trap "rm -rf \"$TEMPDIR\"" 0

cat > "$TEMPDIR/test.c" <<EOF
#include <stdlib.h>
#include <stdio.h>
int main ()
{
#if __has_feature(address_sanitizer)
  puts("address_sanitizer");
#endif
#if __has_feature(thread_sanitizer)
  puts("thread_sanitizer");
#endif
#if __has_feature(memory_sanitizer)
  puts("memory_sanitizer");
#endif
#if __has_feature(undefined_sanitizer)
  puts("undefined_sanitizer");
#endif
#if __has_feature(dataflow_sanitizer)
  puts("dataflow_sanitizer");
#endif
#if __has_feature(efficiency_sanitizer)
  puts("efficiency_sanitizer");
#endif
  printf("Ok\n");
  return EXIT_SUCCESS;
}
EOF

# only for AMD64 for now
# many sanitizers only work on AMD64
# x32 programs need to be enabled in the kernel bootparams for debian
# (https://wiki.debian.org/X32Port)
#
# SYSTEM should iterate multiple targets (eg. x86_64-unknown-none-gnu for embedded)
# MARCH should iterate the library architectures via flags
# LIB should iterate the different libraries
echo "if it fails, please run"
echo "apt-get install libc6-dev:i386 libgcc-5-dev:i386 libc6-dev-x32 libx32gcc-5-dev libx32gcc-8-dev"
for SYSTEM in ""; do
    for MARCH in -m64 -m32 -mx32 "-m32 -march=i686"; do
        for LIB in --rtlib=compiler-rt -fsanitize=address -fsanitize=thread -fsanitize=memory -fsanitize=undefined -fsanitize=dataflow; do # -fsanitize=efficiency-working-set; do
            if test "$MARCH" == "-m32" -o "$MARCH" == "-mx32"; then
                if test $LIB == "-fsanitize=thread" -o $LIB == "-fsanitize=memory" -o $LIB == "-fsanitize=dataflow" -o $LIB == "-fsanitize=address" -o $LIB == "-fsanitize=undefined"; then
                    echo "Skip $MARCH / $LIB";
                    continue
                fi
            fi
            if test "$MARCH" == "-m32 -march=i686"; then
                if test $LIB == "-fsanitize=memory" -o $LIB == "-fsanitize=thread" -o $LIB == "-fsanitize=dataflow"; then
                     echo "Skip $MARCH / $LIB";
                     continue
                fi
            fi
            XARGS="$SYSTEM $MARCH $LIB"
            printf "\nTest: clang %s\n" "$XARGS"
            rm -f "$TEMPDIR/test"
            "$CLANG" $XARGS -o "$TEMPDIR/test" "$@" "$TEMPDIR/test.c" || true
            [ ! -e "$TEMPDIR/test" ] || { "$TEMPDIR/test" || printf 'Error\n'; }
        done
    done
done

echo "If the following fails, try setting an environment variable such as:"
echo "OBJC_INCLUDE_PATH=/usr/lib/gcc/x86_64-linux-gnu/7/include"
echo "libobjc-7-dev should be also installed"
echo "#include <objc/objc.h>" > foo.m
#clang-$VERSION -c foo.m

if test ! -f /usr/lib/llvm-$VERSION/lib/libclangBasic.a; then
    echo "Install libclang-$VERSION-dev"
    exit 1
fi

#clean up
rm -f a.out bar crash-* foo foo.* lldb-cmd.txt main.* test_fuzzer.cc foo.* o
rm -rf output matmul.* *profraw

echo "Completed"
