FROM ubuntu:xenial
MAINTAINER Reto Achermann <reto.achermann@inf.ethz.ch>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
             build-essential \
             bison \
             flex \
             cmake \
             qemu-system-x86 \
             qemu-system-arm \
             ghc \
             libghc-src-exts-dev \
             libghc-ghc-paths-dev \
             libghc-parsec3-dev \
             libghc-random-dev \
             libghc-ghc-mtl-dev \
             libghc-src-exts-dev \
             libghc-async-dev \
             gcc-arm-linux-gnueabi \
             g++-arm-linux-gnueabi \
             libgmp3-dev \
             cabal-install \
             curl \
             freebsd-glue \
             libelf-freebsd-dev \
             libusb-1.0-0-dev \
             qemu-utils \
             gcc-aarch64-linux-gnu \
             g++-aarch64-linux-gnu \
             git \
             && apt-get clean && rm -rf /var/lib/apt/lists/* \
             && cabal update && cabal install bytestring-trie 

