# Derived from: https://github.com/rust-lang/docker-rust

FROM rust:buster

RUN apt-get update && \
    apt-get install -y \
        autoconf \
        automake \
        autotools-dev \
        bc \
        bison \
        build-essential \
        curl \
        flex \
        gawk \
        gperf \
        libexpat-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libtool \
        ninja-build \
        patchutils \
        python3 \
        texinfo \
        zlib1g-dev && \
    apt-get clean && \
    git clone https://github.com/riscv-collab/riscv-gnu-toolchain && \
    cd riscv-gnu-toolchain && \
    ./configure --prefix=/usr/local --enable-multilib && \
    make -j$(nproc) && \
    cd .. && \
    rm -rf riscv-gnu-toolchain && \
    git clone https://github.com/qemu/qemu && \
    cd qemu && \
    git checkout v6.2.0 && \
    ./configure --target-list=riscv64-softmmu && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf qemu && \
    apt-get remove -y \
        autotools-dev \
        libexpat-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean
