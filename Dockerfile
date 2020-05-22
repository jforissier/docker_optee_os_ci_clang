FROM ubuntu as clang-downloader
MAINTAINER Jerome Forissier <jerome@forissier.org>

RUN apt update && \
    apt install -y wget xz-utils

ADD get_clang.sh /root/get_clang.sh
WORKDIR /root
RUN ./get_clang.sh ./clang

FROM jforissier/optee_os_ci
MAINTAINER Jerome Forissier <jerome@forissier.org>
COPY --from=clang-downloader /root/clang/ /usr/local/

