#!/bin/bash
#
# Download and extract Clang from the GitHub release page.
# We want a x86_64 cross-compiler capable of generating aarch64 and armv7a code
# *and* we want the compiler-rt libraries for these architectures
# (libclang_rt.*.a).
# Clang is configured to be able to cross-compile to all the supported
# architectures by default (see <clang path>/bin/llc --version) which is great,
# but compiler-rt is included only for the host architecture. Therefore we need
# to combine several packages into one, which is the purpose of this script.
#
# Usage: get_clang.sh [path]

DEST=${1:-./clang}

VER=10.0.0
X86_64=clang+llvm-${VER}-x86_64-linux-gnu-ubuntu-18.04
AARCH64=clang+llvm-${VER}-aarch64-linux-gnu
ARMV7A=clang+llvm-${VER}-armv7a-linux-gnueabihf

(wget -nv https://github.com/llvm/llvm-project/releases/download/llvmorg-${VER}/${X86_64}.tar.xz && tar xf ${X86_64}.tar.xz) &
pids=$!
(wget -nv https://github.com/llvm/llvm-project/releases/download/llvmorg-${VER}/${AARCH64}.tar.xz && tar xf ${AARCH64}.tar.xz) &
pids="$pids $!"
(wget -nv https://github.com/llvm/llvm-project/releases/download/llvmorg-${VER}/${ARMV7A}.tar.xz && tar xf ${ARMV7A}.tar.xz) &
pids="$pids $!"
wait $pids || exit 1

mv ${X86_64} ${DEST} || exit 1
cp ${AARCH64}/lib/clang/${VER}/lib/linux/* ${DEST}/lib/clang/${VER}/lib/linux || exit 1
cp ${ARMV7A}/lib/clang/${VER}/lib/linux/* ${DEST}/lib/clang/${VER}/lib/linux || exit 1
