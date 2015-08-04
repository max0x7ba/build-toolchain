SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

zeromq_version := 4.1.2

prefix := $(shell cat ../PREFIX)
PREFIX := ${prefix}/zeromq-${zeromq_version}

CXXFLAGS := -pthread -std=gnu++14 -fmessage-length=0
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

export PATH := ${prefix}/bin:${PATH}

all : install.zeromq.${zeromq_version}

configure.zeromq.${zeromq_version} : | zeromq-${zeromq_version}-src zeromq-${zeromq_version}-obj
	( cd zeromq-${zeromq_version}-obj && ../zeromq-${zeromq_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --without-libsodium --disable-static CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

zeromq-${zeromq_version}-obj :
	mkdir $@

build.zeromq.${zeromq_version} : configure.zeromq.${zeromq_version}
	( cd zeromq-${zeromq_version}-obj && ${MAKE} V=1 ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.zeromq.${zeromq_version} : build.zeromq.${zeromq_version}
	( cd zeromq-${zeromq_version}-obj && ${MAKE} V=1 install ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

zeromq-${zeromq_version}-src : ${DOWNLOAD_DIR}/zeromq-${zeromq_version}.tar.gz
	tar xf $<
	sed -i.original -e 's/g++ -v /g++ --version /g' zeromq-${zeromq_version}/configure
	mv zeromq-${zeromq_version} $@

${DOWNLOAD_DIR}/zeromq-${zeromq_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://download.zeromq.org/zeromq-${zeromq_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/zeromq-${zeromq_version}.tar.gz

clean :
	rm -rf *.zeromq.${zeromq_version} zeromq-${zeromq_version}-{src,obj} ${PREFIX}

.PHONY: all clean install download
