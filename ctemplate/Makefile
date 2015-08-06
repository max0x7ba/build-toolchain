include ../versions.mk

PREFIX := ${prefix}/ctemplate-${ctemplate_version}

CPPFLAGS := -fmessage-length=0
CFLAGS :=
CXXFLAGS := -std=gnu++14 -Wno-unused-function
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64

all : install.ctemplate.${ctemplate_version}

configure.ctemplate.${ctemplate_version} : | ctemplate-${ctemplate_version}-src
	( cd ctemplate-${ctemplate_version}-src && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.ctemplate.${ctemplate_version} : configure.ctemplate.${ctemplate_version}
	${MAKE} -C ctemplate-${ctemplate_version}-src V=1 | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.ctemplate.${ctemplate_version} : build.ctemplate.${ctemplate_version}
	${MAKE} -C ctemplate-${ctemplate_version}-src V=1 install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

ctemplate-${ctemplate_version}-src : ${DOWNLOAD_DIR}/ctemplate-${ctemplate_version}.tar.gz
	tar xf $<
	mv ctemplate-ctemplate-${ctemplate_version} $@

${DOWNLOAD_DIR}/ctemplate-${ctemplate_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/OlafvdSpek/ctemplate/archive/ctemplate-${ctemplate_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/ctemplate-${ctemplate_version}.tar.gz

clean :
	rm -rf *.ctemplate.${ctemplate_version} ctemplate-${ctemplate_version}-src ${PREFIX}

.PHONY: all clean download
