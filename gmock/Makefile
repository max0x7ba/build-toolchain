SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

gmock_version := 1.7.0
PREFIX := ${prefix}/gmock-${gmock_version}

CPPFLAGS := -fmessage-length=0
CXXFLAGS := -std=gnu++14 -pthread
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.gmock.${gmock_version}

configure.gmock.${gmock_version} : | gmock-${gmock_version}-src
	( cd gmock-${gmock_version}-src && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --disable-static --disable-external-gtest CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.gmock.${gmock_version} : configure.gmock.${gmock_version}
	${MAKE} -C gmock-${gmock_version}-src | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.gmock.${gmock_version} : build.gmock.${gmock_version}
	${MAKE} -C gmock-${gmock_version}-src install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

gmock-${gmock_version}-src : ${DOWNLOAD_DIR}/gmock-${gmock_version}.zip
	unzip -q $<
	cd gmock-${gmock_version} && patch -p1 < ../install.patch
	mv gmock-${gmock_version} $@

${DOWNLOAD_DIR}/gmock-${gmock_version}.zip : | ${DOWNLOAD_DIR}
	wget -O $@~ http://googlemock.googlecode.com/files/gmock-${gmock_version}.zip
	mv $@{~,}

download : ${DOWNLOAD_DIR}/gmock-${gmock_version}.zip

clean :
	rm -rf *.gmock.${gmock_version} gmock-${gmock_version}-src ${PREFIX}

.PHONY: all clean download
