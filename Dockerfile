FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux && \
    apt-get update && \
    apt-get install -y \
        curl \
        build-essential \
        binutils-riscv64-linux-gnu \
        gcc-riscv64-linux-gnu \
        binutils-riscv64-unknown-elf \
        gcc-riscv64-unknown-elf \
        qemu-system-misc && \
    apt-get autoremove -y && \
    apt-get clean && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
    rustup target add riscv64gc-unknown-linux-gnu && \
    rustup target add riscv64gc-unknown-none-elf && \
    rustup target add riscv64imac-unknown-none-elf && \
    rustup target add riscv32i-unknown-none-elf && \
    rustup target add riscv32imac-unknown-none-elf && \
    rustup target add riscv32imc-unknown-none-elf

RUN mkdir -p /src
WORKDIR /src
