Provides Rustup, `riscv64-unknown-elf-` and `riscv64-linux-gnu-` cross-compilers, and QEMU for rv64.

```bash
$ docker build -t rust-riscv64 .
$ docker run -it --rm -v "path/to/crate:/src" rust-riscv64 cargo build
```
