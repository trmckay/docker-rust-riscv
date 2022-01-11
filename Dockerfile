# Derived from: https://github.com/rust-lang/docker-rust

FROM buildpack-deps:bullseye

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.57.0

RUN set -eux && \
    url="https://static.rust-lang.org/rustup/archive/1.24.3/x86_64-unknown-linux-gnu/rustup-init" && \
    wget "$url" && \
    chmod +x rustup-init && \
    ./rustup-init -y --no-modify-path --default-toolchain none && \
    rm rustup-init && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
    rustup default stable  &&\
    rustup target remove x86_64-unknown-linux-gnu  && \
    rustup target add riscv64gc-unknown-none-elf && \
    rustup target add riscv64gc-unknown-linux-gnu && \
    apt update && \
    apt install -y \
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
        patchutils \
        python3 \
        qemu-system-riscv64 \
        texinfo \
        zlib1g-dev && \
    apt clean && \
    git clone https://github.com/riscv-collab/riscv-gnu-toolchain /src/riscv-gnu-toolchain && \
    cd /src/riscv-gnu-toolchain && \
    ./configure --prefix=/usr/local --enable-multilib && \
    make -j $(nproc) && \
    rm -rf /src/riscv-gnu-toolchain && \
    apt remove -y \
        libexpat-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev
