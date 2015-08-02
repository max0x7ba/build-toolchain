SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

PREFIX := $(shell cat ../PREFIX)

quickfix_version := 1.14.4
boost_version := 1.58.0
tbb_version := 43_20150611oss

#export PATH := ${PREFIX}/bin:${PATH}

CPPFLAGS := -fmessage-length=0 -Wno-deprecated-declarations
CXXFLAGS := -std=gnu++14
#LDFLAGS := -Wl,-rpath,${PREFIX}/lib64 -L${PREFIX}/boost-${boost_version}/lib64 -Wl,-rpath,${PREFIX}/boost-${boost_version}/lib64 -L${PREFIX}/tbb${tbb_version}/lib64 -Wl,-rpath,${PREFIX}/tbb${tbb_version}/lib64
#LDFLAGS := -L${PREFIX}/boost-${boost_version}/lib64 -L${PREFIX}/tbb${tbb_version}/lib64

configure.quickfix.${quickfix_version} : | quickfix-${quickfix_version}-src
#	( cd quickfix-${quickfix_version}-src && ../quickfix-${quickfix_version}-src/bootstrap && ../quickfix-${quickfix_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-boost=${PREFIX}/boost-${boost_version}/include --with-tbb=${PREFIX}/tbb${tbb_version}/include CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}"  ) | tee $@~; exit $${PIPESTATUS[0]}
	( cd quickfix-${quickfix_version}-src && ../quickfix-${quickfix_version}-src/bootstrap && ../quickfix-${quickfix_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.quickfix.${quickfix_version} : configure.quickfix.${quickfix_version}
#	( cd quickfix-${quickfix_version}-src && ${MAKE} CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	( cd quickfix-${quickfix_version}-src && ${MAKE} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

# quickfix-${quickfix_version}-obj :
# 	mkdir $@

quickfix-${quickfix_version}-src : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz
	tar xf $<
	sed -i.original -e 's/-std=c++0x/-std=gnu++14/g' quickfix-v.${quickfix_version}/configure.ac
	mv quickfix-v.${quickfix_version} $@

${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/quickfix/quickfix/archive/v.${quickfix_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz

clean :
	rm -rf *.quickfix.${quickfix_version} quickfix-${quickfix_version}-src
