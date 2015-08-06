include ../versions.mk

PREFIX := ${prefix}/libevent-${libevent_version}

CPPFLAGS := -fmessage-length=0 -I${prefix}/openssl-${openssl_version}/include
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64 $(addsuffix ${prefix}/openssl-${openssl_version}/lib64,-L -Wl,-rpath,)

all : install.libevent.${libevent_version}

configure.libevent.${libevent_version} : | libevent-${libevent_version}-src libevent-${libevent_version}-obj
	( cd libevent-${libevent_version}-obj && ../libevent-${libevent_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.libevent.${libevent_version} : configure.libevent.${libevent_version}
	${MAKE} -C libevent-${libevent_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.libevent.${libevent_version} : build.libevent.${libevent_version}
	${MAKE} -C libevent-${libevent_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

libevent-${libevent_version}-obj :
	mkdir $@

libevent-${libevent_version}-src : ${DOWNLOAD_DIR}/libevent-${libevent_version}.tar.gz
	tar xf $<
	mv libevent-${libevent_version}-stable $@

${DOWNLOAD_DIR}/libevent-${libevent_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/libevent/libevent/releases/download/release-${libevent_version}-stable/libevent-${libevent_version}-stable.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/libevent-${libevent_version}.tar.gz

clean :
	rm -rf *.libevent.${libevent_version} libevent-${libevent_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
