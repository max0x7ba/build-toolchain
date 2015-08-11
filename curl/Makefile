include ../versions.mk

PREFIX := ${prefix}/curl-${curl_version}

CPPFLAGS := -pthread -fmessage-length=0
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread $(addsuffix ${prefix}/openssl-${openssl_version}/lib64,-L -Wl,-rpath,)

all : install.curl.${curl_version}

configure.curl.${curl_version} : | curl-${curl_version}-src curl-${curl_version}-obj
	( cd curl-${curl_version}-obj && ../curl-${curl_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --disable-debug --enable-optimize --enable-symbol-hiding --disable-silent-rules --disable-static --enable-versioned-symbols --disable-ldap --disable-ldaps --with-ssl=${prefix}/openssl-${openssl_version} CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.curl.${curl_version} : configure.curl.${curl_version}
	${MAKE} -C curl-${curl_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.curl.${curl_version} : build.curl.${curl_version}
	${MAKE} -C curl-${curl_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

curl-${curl_version}-obj :
	mkdir $@

curl-${curl_version}-src : ${DOWNLOAD_DIR}/curl-${curl_version}.tar.bz2
	tar xf $<
	mv curl-${curl_version} $@
	touch $@

${DOWNLOAD_DIR}/curl-${curl_version}.tar.bz2 : | ${DOWNLOAD_DIR}
	wget -O $@~ http://github.com/bagder/curl/releases/download/curl-$(subst .,_,${curl_version})/curl-${curl_version}.tar.bz2
	mv $@{~,}

download : ${DOWNLOAD_DIR}/curl-${curl_version}.tar.bz2

clean :
	rm -rf *.curl.${curl_version} curl-${curl_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
