include ../versions.mk

PREFIX := ${prefix}/libxslt-${libxslt_version}

CPPFLAGS := -pthread -fmessage-length=0 -O2
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64 $(addsuffix ${prefix}/libxml2-${libxml2_version}/lib64,-L -Wl,-rpath,)

all : install.libxslt.${libxslt_version}

configure.libxslt.${libxslt_version} : | libxslt-${libxslt_version}-src libxslt-${libxslt_version}-obj
	( cd libxslt-${libxslt_version}-obj && ../libxslt-${libxslt_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-libxml-prefix=${prefix}/libxml2-${libxml2_version} --with-libxml-libs-prefix=${prefix}/libxml2-${libxml2_version}/lib64 --disable-silent-rules --disable-static --without-python CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.libxslt.${libxslt_version} : configure.libxslt.${libxslt_version}
	${MAKE} -C libxslt-${libxslt_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.libxslt.${libxslt_version} : build.libxslt.${libxslt_version}
	${MAKE} -C libxslt-${libxslt_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

libxslt-${libxslt_version}-obj :
	mkdir $@

libxslt-${libxslt_version}-src : ${DOWNLOAD_DIR}/libxslt-${libxslt_version}.tar.gz
	tar xf $<
	mv libxslt-${libxslt_version} $@
	touch $@

${DOWNLOAD_DIR}/libxslt-${libxslt_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ ftp://xmlsoft.org/libxslt/libxslt-${libxslt_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/libxslt-${libxslt_version}.tar.gz

clean :
	rm -rf *.libxslt.${libxslt_version} libxslt-${libxslt_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
