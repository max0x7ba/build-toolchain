SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

prefix := $(shell cat ../PREFIX)

tbb_version := 43_20150611oss
PREFIX := ${prefix}/tbb${tbb_version}

export PATH := ${prefix}/bin:${PATH}
export CXX := ${prefix}/bin/g++
export CC := ${prefix}/bin/gcc

all : install.tbb.${tbb_version}

build.tbb.${tbb_version} : | tbb${tbb_version}-src
	${MAKE} -C tbb${tbb_version}-src -j${JOBS} CPPFLAGS='-std=gnu++14 -pthread' CFLAGS='-pthread' LDFLAGS='-pthread'
	touch $@

${PREFIX}/lib64 ${PREFIX}/include : build.tbb.${tbb_version} | ${PREFIX}

${PREFIX}/lib64 :
	mkdir -p $@~
	cp -a tbb${tbb_version}-src/build/*/*.so{,.2} $@~
	mv $@{~,}

${PREFIX}/include :
	mkdir -p $@~
	cp -a tbb${tbb_version}-src/include/* $@~
	mv $@{~,}

install.tbb.${tbb_version} : ${PREFIX}/lib64 ${PREFIX}/include
	touch $@

tbb${tbb_version}-src : ${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz
	tar xzf $<
	mv tbb${tbb_version} $@
	touch $@

${PREFIX} ${DOWNLOAD_DIR} :
	mkdir $@

${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb${tbb_version}_src.tgz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz

build : build.tbb.${tbb_version}

clean :
	rm -rf ${PREFIX} tbb${tbb_version}-src  build.* install.*

.PHONY : all clean build
.PRECIOUS : %.tgz install.% build.%
