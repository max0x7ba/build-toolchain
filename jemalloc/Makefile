SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

jemalloc_version := 3.6.0
PREFIX := ${prefix}/jemalloc-${jemalloc_version}

CPPFLAGS := -fmessage-length=0 -pthread
CFLAGS := -Wno-unused-but-set-variable -Wno-unused-function
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.jemalloc.${jemalloc_version}

configure.jemalloc.${jemalloc_version} : | jemalloc-${jemalloc_version}-src jemalloc-${jemalloc_version}-obj
	( cd jemalloc-${jemalloc_version}-obj && ../jemalloc-${jemalloc_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --enable-mremap CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.jemalloc.${jemalloc_version} : configure.jemalloc.${jemalloc_version}
	${MAKE} -C jemalloc-${jemalloc_version}-obj build_lib_shared | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.jemalloc.${jemalloc_version} : build.jemalloc.${jemalloc_version}
	${MAKE} -C jemalloc-${jemalloc_version}-obj install_lib_shared | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

jemalloc-${jemalloc_version}-obj :
	mkdir $@

jemalloc-${jemalloc_version}-src : ${DOWNLOAD_DIR}/jemalloc-${jemalloc_version}.tar.gz
	tar xf $<
	mv jemalloc-${jemalloc_version} $@

${DOWNLOAD_DIR}/jemalloc-${jemalloc_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/jemalloc/jemalloc/releases/download/${jemalloc_version}/jemalloc-${jemalloc_version}.tar.bz2
	mv $@{~,}

download : ${DOWNLOAD_DIR}/jemalloc-${jemalloc_version}.tar.gz

clean :
	rm -rf *.jemalloc.${jemalloc_version} jemalloc-${jemalloc_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
