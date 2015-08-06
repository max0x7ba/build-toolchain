SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

openssl_version := 1.0.2d
PREFIX := ${prefix}/openssl-${openssl_version}

CPPFLAGS := -fmessage-length=0 -pthread
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.openssl.${openssl_version}

configure.openssl.${openssl_version} : | openssl-${openssl_version}-src
	( cd openssl-${openssl_version}-src && ./config --prefix=${PREFIX} --libdir=lib64 threads zlib shared ) | tee $@~; exit $${PIPESTATUS[0]}
	sed -i.original -e 's:^EX_LIBS=:EX_LIBS=${LDFLAGS} :' openssl-${openssl_version}-src/Makefile
	mv $@~ $@

build.openssl.${openssl_version} : configure.openssl.${openssl_version}
	${MAKE} -C openssl-${openssl_version}-src | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.openssl.${openssl_version} : build.openssl.${openssl_version}
	${MAKE} -C openssl-${openssl_version}-src install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

openssl-${openssl_version}-src : ${DOWNLOAD_DIR}/openssl-${openssl_version}.tar.gz
	tar xf $<
	mv openssl-${openssl_version} $@

${DOWNLOAD_DIR}/openssl-${openssl_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://www.openssl.org/source/openssl-1.0.2d.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/openssl-${openssl_version}.tar.gz

clean :
	rm -rf *.openssl.${openssl_version} openssl-${openssl_version}-src ${PREFIX}

.PHONY: all clean download
