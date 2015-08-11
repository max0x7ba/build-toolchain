include ../versions.mk

PREFIX := ${prefix}/libxml2-${libxml2_version}

CPPFLAGS := -pthread -fmessage-length=0 -O2
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.libxml2.${libxml2_version}

configure.libxml2.${libxml2_version} : | libxml2-${libxml2_version}-src libxml2-${libxml2_version}-obj
	( cd libxml2-${libxml2_version}-obj && ../libxml2-${libxml2_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --disable-silent-rules --disable-static --with-fexceptions --without-python CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.libxml2.${libxml2_version} : configure.libxml2.${libxml2_version}
	${MAKE} -C libxml2-${libxml2_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.libxml2.${libxml2_version} : build.libxml2.${libxml2_version}
	${MAKE} -C libxml2-${libxml2_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

libxml2-${libxml2_version}-obj :
	mkdir $@

libxml2-${libxml2_version}-src : ${DOWNLOAD_DIR}/libxml2-${libxml2_version}.tar.gz
	tar xf $<
	mv libxml2-${libxml2_version} $@
	touch $@

${DOWNLOAD_DIR}/libxml2-${libxml2_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ ftp://xmlsoft.org/libxml2/libxml2-sources-${libxml2_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/libxml2-${libxml2_version}.tar.gz

clean :
	rm -rf *.libxml2.${libxml2_version} libxml2-${libxml2_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
