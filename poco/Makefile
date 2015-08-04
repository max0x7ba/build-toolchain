SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

poco_version := 1.6.0

prefix := $(shell cat ../PREFIX)
PREFIX := ${prefix}/poco-${poco_version}

#CPPFLAGS :=
CXXFLAGS := -pthread -std=gnu++14 -fmessage-length=0 -Wno-deprecated-declarations
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

export PATH := ${prefix}/bin:${PATH}

all : install.poco.${poco_version}

configure.poco.${poco_version} : poco-${poco_version}-src/build/config/Linux2 | poco-${poco_version}-src poco-${poco_version}-obj
	( cd poco-${poco_version}-obj && ../poco-${poco_version}-src/configure --config=Linux2 --prefix=${PREFIX} --no-wstring --omit=Data/MySQL,Data/ODBC ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

poco-${poco_version}-obj :
	mkdir $@

build.poco.${poco_version} : configure.poco.${poco_version}
	( cd poco-${poco_version}-obj && ${MAKE} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.poco.${poco_version} : build.poco.${poco_version}
	( cd poco-${poco_version}-obj && ${MAKE} install ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

poco-${poco_version}-src/build/config/Linux2 : make-config.m4 | poco-${poco_version}-src
	m4 -DM4_CXXFLAGS="${CXXFLAGS}" -DM4_LDFLAGS="${LDFLAGS}" -DM4_DYLIBFLAGS="${DYLIBFLAGS}" -DM4_MAKEFILES_DIR=$(abspath ${@D}) make-config.m4 > $@

poco-${poco_version}-src : ${DOWNLOAD_DIR}/poco-${poco_version}.tar.gz
	tar xf $<
	sed -i.original -e 's%(INSTALLDIR)/lib%(INSTALLDIR)/lib64%g' poco-${poco_version}/Makefile
	mv poco-${poco_version} $@

${DOWNLOAD_DIR}/poco-${poco_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://pocoproject.org/releases/poco-${poco_version}/poco-${poco_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/poco-${poco_version}.tar.gz

clean :
	rm -rf *.poco.${poco_version} poco-${poco_version}-{src,obj} ${PREFIX}

.PHONY: all clean install download
