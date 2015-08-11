include ../versions.mk

PREFIX := ${prefix}/lua-${lua_version}

CPPFLAGS :=
CFLAGS := -fmessage-length=0
CXXFLAGS := -std=gnu++14
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64

all : install.lua.${lua_version}

build.lua.${lua_version} : | lua-${lua_version}-src
	${MAKE} -C lua-${lua_version}-src MYCFLAGS="${CFLAGS}" MYLDFLAGS="${LDFLAGS}" INSTALL_TOP=${PREFIX} INSTALL_LIB=${PREFIX}/lib64 linux | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.lua.${lua_version} : build.lua.${lua_version}
	${MAKE} -C lua-${lua_version}-src MYCFLAGS="${CFLAGS}" MYLDFLAGS="${LDFLAGS}" INSTALL_TOP=${PREFIX} INSTALL_LIB=${PREFIX}/lib64 linux install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

lua-${lua_version}-src : ${DOWNLOAD_DIR}/lua-${lua_version}.tar.gz
	tar xf $<
	mv lua-${lua_version} $@
	touch $@

${DOWNLOAD_DIR}/lua-${lua_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://www.lua.org/ftp/lua-5.3.1.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/lua-${lua_version}.tar.gz

clean :
	rm -rf *.lua.${lua_version} lua-${lua_version}-src ${PREFIX}

.PHONY: all clean download
