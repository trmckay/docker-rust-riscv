FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        curl \
        build-essential \
        binutils-riscv64-linux-gnu \
        gcc-riscv64-linux-gnu \
        binutils-riscv64-unknown-elf \
        gcc-riscv64-unknown-elf \
        qemu-system-misc && \
    apt-get autoremove -y && \
    apt-get clean

RUN adduser rust
RUN mkdir -p /src
RUN chown rust:rust /src

USER rust
WORKDIR /src

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain none
ENV PATH /home/rust/.cargo/bin:$PATH
