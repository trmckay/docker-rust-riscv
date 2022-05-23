- [dockerhub:trmckay/rust-riscv](https://hub.docker.com/repository/docker/trmckay/rust-riscv/)
- [github:trmckay/docker-rust-riscv](https://github.com/trmckay/docker-rust-riscv)

Provides Rustup with no default target, a `riscv64-unknown-elf-` GNU toolchain,
and `qemu-system-riscv{64,32}`.

```bash
$ docker build -t rust-riscv .
$ docker run -it --rm -v "path/to/crate:/src" rust-riscv cargo build
```
