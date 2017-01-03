# docker-rust-wasm

This is a nightly Rust image with support for WebAssembly (and also
asm.js, if you're into that) as a target.

## Usage

```
$ cat > hello.rs
fn main() {
    println!("Hello, world!");
}
```

WebAssembly:

```
$ docker run -it -v `pwd`:/source jasonuhl/rust-wasm rustc --target=wasm32-unknown-emscripten hello.rs
```

or asm.js:

```
$ docker run -it -v `pwd`:/source jasonuhl/rust-wasm rustc --target=asmjs-unknown-emscripten hello.rs
```
