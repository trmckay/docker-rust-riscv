FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

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

RUN mkdir -p /opt/rust

ENV RUSTUP_HOME /opt/rust/rustup
ENV CARGO_HOME /opt/rust/cargo
ENV PATH /opt/rust/cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain none

RUN mkdir -p /src
RUN chown nobody:nogroup /src

WORKDIR /src
