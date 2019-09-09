FROM ubuntu as clang-builder
MAINTAINER Jerome Forissier <jerome@forissier.org>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \
 && apt install -y \
  cmake \
  gcc \
  g++ \
  git \
  make \
  ninja-build \
  python3 \
  vim \
 && apt autoremove

WORKDIR /root
RUN git clone --depth=1 https://github.com/llvm/llvm-project.git
RUN mkdir build \
 && cd build \
 && cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="clang;lld" \
  -DLLVM_TARGETS_TO_BUILD="AArch64;ARM" \
  /root/llvm-project/llvm \
 && ninja \
 && DESTDIR=/tmp/clang-install ninja install

FROM jforissier/optee_os_ci
MAINTAINER Jerome Forissier <jerome@forissier.org>

COPY --from=clang-builder /tmp/clang-install/usr/local/ /usr/local/

