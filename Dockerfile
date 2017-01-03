FROM ubuntu:16.04
MAINTAINER Jason Uhlenkott "jpu1077@uhlenkott.net"

RUN apt-get update && apt-get install -y curl build-essential python2.7 python git curl cmake
RUN cd /usr/local && curl -sL https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar xz
RUN bash -c ". /usr/local/emsdk_portable/emsdk_env.sh && emsdk update && emsdk install --shallow -j1 latest && emsdk activate latest"

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH /root/.cargo/bin:/usr/local/emsdk_portable:/usr/local/emsdk_portable/clang/fastcomp/build_master_64/bin:/usr/local/emsdk_portable/node/4.1.1_64bit/bin:/usr/local/emsdk_portable/emscripten/master:${PATH}
ENV EM_CONFIG /root/.emscripten
ENV EMSCRIPTEN /usr/local/emsdk_portable/emscripten/master

RUN rustup toolchain add nightly
RUN rustup target add asmjs-unknown-emscripten --toolchain nightly
RUN rustup target add wasm32-unknown-emscripten --toolchain nightly

RUN apt-get autoclean && apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/emsdk_portable/zips /usr/local/emsdk_portable/clang/fastcomp/src

VOLUME ["/source"]
WORKDIR /source
CMD ["bash"]
