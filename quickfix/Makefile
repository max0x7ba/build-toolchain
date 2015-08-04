SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

# TODO: make it global toolchain configuration.
quickfix_version := 1.14.4
boost_version := 1.58.0
tbb_version := 43_20150611oss

prefix := $(shell cat ../PREFIX)
PREFIX := ${prefix}/quickfix-${quickfix_version}

export PATH := ${prefix}/bin:${PATH}

CPPFLAGS := -fmessage-length=0 -Wno-deprecated-declarations -pthread
CXXFLAGS := -std=gnu++14
lib_dirs := $(patsubst %,${prefix}/%/lib64,boost-${boost_version} tbb${tbb_version})
LDFLAGS := $(foreach lib_dir,${lib_dirs},-L${lib_dir} -Wl,-rpath,${lib_dir}) -pthread

all : install.quickfix.${quickfix_version}

info :
	@echo "CPPFLAGS=${CPPFLAGS}"
	@echo "CXXFLAGS=${CXXFLAGS}"
	@echo "LDFLAGS=${LDFLAGS}"

configure.quickfix.${quickfix_version} : | quickfix-${quickfix_version}-src
	( cd quickfix-${quickfix_version}-src && ./bootstrap && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-mysql-config=true --without-mysql --with-boost=${prefix}/boost-${boost_version}/include --with-tbb=${prefix}/tbb${tbb_version}/include CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.quickfix.${quickfix_version} : configure.quickfix.${quickfix_version}
	( cd quickfix-${quickfix_version}-src && ${MAKE} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.quickfix.${quickfix_version} : build.quickfix.${quickfix_version}
	( cd quickfix-${quickfix_version}-src && ${MAKE} install ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

quickfix-${quickfix_version}-src : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz
	tar xf $<
	sed -i.original -e 's/-std=c++0x/-std=gnu++14/g' quickfix-v.${quickfix_version}/configure.ac
	mv quickfix-v.${quickfix_version} $@

${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/quickfix/quickfix/archive/v.${quickfix_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz

clean :
	rm -rf *.quickfix.${quickfix_version} quickfix-${quickfix_version}-src ${PREFIX}

.PHONY: all clean install download
