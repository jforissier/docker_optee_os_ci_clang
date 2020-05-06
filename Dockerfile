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
  curl \
 && apt autoremove

WORKDIR /root
RUN curl -s -L https://fileserver.linaro.org/s/da26ygYptknxwSk/download -o clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04
RUN tar xf clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04

FROM jforissier/optee_os_ci
MAINTAINER Jerome Forissier <jerome@forissier.org>

COPY --from=clang-builder /root/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/ /usr/local/

