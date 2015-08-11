include ../versions.mk

PREFIX := ${prefix}/ta-lib-${ta-lib_version}

CPPFLAGS := -pthread -fmessage-length=0
CFLAGS := -O2
CXXFLAGS := -std=gnu++14 -O2
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.ta-lib.${ta-lib_version}

configure.ta-lib.${ta-lib_version} : | ta-lib-${ta-lib_version}-src
	( cd ta-lib-${ta-lib_version}-src && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-libxml-prefix=${prefix}/libxml2-${libxml2_version} --with-libxml-libs-prefix=${prefix}/libxml2-${libxml2_version}/lib64 --disable-static CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.ta-lib.${ta-lib_version} : configure.ta-lib.${ta-lib_version}
	( ${MAKE} -C ta-lib-${ta-lib_version}-src -k || ${MAKE} -C ta-lib-${ta-lib_version}-src ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.ta-lib.${ta-lib_version} : build.ta-lib.${ta-lib_version}
	${MAKE} -C ta-lib-${ta-lib_version}-src install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

ta-lib-${ta-lib_version}-src : ${DOWNLOAD_DIR}/ta-lib-${ta-lib_version}.tar.gz
	tar xf $<
	mv ta-lib $@
	touch $@

${DOWNLOAD_DIR}/ta-lib-${ta-lib_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ ftp://ftp.mirrorservice.org/sites/downloads.sourceforge.net/t/ta/ta-lib/ta-lib/${ta-lib_version}/ta-lib-${ta-lib_version}-src.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/ta-lib-${ta-lib_version}.tar.gz

clean :
	rm -rf *.ta-lib.${ta-lib_version} ta-lib-${ta-lib_version}-src ${PREFIX}

.PHONY: all clean download
