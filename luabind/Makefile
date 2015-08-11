include ../versions.mk

boost_build_path := $(abspath ../boost/boost_$(subst .,_,${boost_version}))
bjam := ${boost_build_path}/bjam

PREFIX := ${prefix}/luabind-${luabind_version}

CPPFLAGS :=
CFLAGS :=
CXXFLAGS := -std=gnu++14 -DBOOST_THREAD_DONT_PROVIDE_INTERRUPTIONS -DBOOST_LOG_NO_THREADS -std=gnu++14 -fmessage-length=0 -Wno-unused-local-typedefs -Wno-deprecated-declarations
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64 $(addsuffix ${prefix}/luajit-${luajit_version}/lib64,-L -Wl,-rpath,)

all : install.luabind.${luabind_version}

bjam_cmd = BOOST_ROOT=${prefix}/boost-${boost_version}/include BOOST_BUILD_PATH=${boost_build_path} LUA_PATH=${prefix}/luajit-${luajit_version} ${bjam} -d+2 -j${JOBS} --build-dir=${CURDIR}/luabind-${luabind_version}-obj --prefix=${PREFIX} --libdir=${PREFIX}/lib64 cxxflags='${CXXFLAGS}' linkflags='${LDFLAGS}' variant=release link=shared threading=multi

build.luabind.${luabind_version} : | luabind-${luabind_version}-src luabind-${luabind_version}-obj
	( cd luabind-${luabind_version}-src && ${bjam_cmd} stage ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.luabind.${luabind_version} : build.luabind.${luabind_version}
	( cd luabind-${luabind_version}-src && ${bjam_cmd} install ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

luabind-${luabind_version}-obj :
	mkdir $@

luabind-${luabind_version}-src : ${DOWNLOAD_DIR}/luabind-${luabind_version}.tar.gz
	tar xf $<
	cd luabind-${luabind_version} && patch -p1 < ../luabind-lib64.patch
	mv luabind-${luabind_version} $@
	touch $@

${DOWNLOAD_DIR}/luabind-${luabind_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://mirrorservice.org/sites/downloads.sourceforge.net/l/lu/luabind/luabind/${luabind_version}/luabind-${luabind_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/luabind-${luabind_version}.tar.gz

clean :
	rm -rf *.luabind.${luabind_version} luabind-${luabind_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
