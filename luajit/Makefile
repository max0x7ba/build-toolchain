include ../versions.mk

PREFIX := ${prefix}/luajit-${luajit_version}

CPPFLAGS :=
CFLAGS := -fmessage-length=0
CXXFLAGS := -std=gnu++14
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64

all : install.luajit.${luajit_version}

build.luajit.${luajit_version} : | luajit-${luajit_version}-src
	${MAKE} -C luajit-${luajit_version}-src Q= E=@: PREFIX="${PREFIX}" CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.luajit.${luajit_version} : build.luajit.${luajit_version}
	${MAKE} -C luajit-${luajit_version}-src install Q= E=@: PREFIX="${PREFIX}" CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" MULTILIB=lib64 | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

luajit-${luajit_version}-src : ${DOWNLOAD_DIR}/luajit-${luajit_version}.tar.gz
	tar xf $<
	mv LuaJIT-${luajit_version} $@
	touch $@

${DOWNLOAD_DIR}/luajit-${luajit_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://luajit.org/download/LuaJIT-${luajit_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/luajit-${luajit_version}.tar.gz

clean :
	rm -rf *.luajit.${luajit_version} luajit-${luajit_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
