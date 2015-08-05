SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

websocketpp_version := 0.6.0
PREFIX := ${prefix}/websocketpp-${websocketpp_version}

CPPFLAGS := -fmessage-length=0 -pthread
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.websocketpp.${websocketpp_version}

install.websocketpp.${websocketpp_version} : websocketpp-${websocketpp_version}-src
	mkdir -p ${PREFIX}/include
	cp -r websocketpp-${websocketpp_version}-src/websocketpp ${PREFIX}/include/
	touch $@

websocketpp-${websocketpp_version}-src : ${DOWNLOAD_DIR}/websocketpp-${websocketpp_version}.tar.gz
	tar xf $<
	mv websocketpp-${websocketpp_version} $@

${DOWNLOAD_DIR}/websocketpp-${websocketpp_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/zaphoyd/websocketpp/archive/${websocketpp_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/websocketpp-${websocketpp_version}.tar.gz

clean :
	rm -rf *.websocketpp.${websocketpp_version} websocketpp-${websocketpp_version}-src ${PREFIX}

.PHONY: all clean download
