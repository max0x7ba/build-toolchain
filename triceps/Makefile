include ../versions.mk

PREFIX := ${prefix}/triceps-${triceps_version}

CPPFLAGS := -fmessage-length=0 -std=gnu++14
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64

all : install.triceps.${triceps_version}

build.triceps.${triceps_version} : triceps-${triceps_version}-src
	${MAKE} -C triceps-${triceps_version}-src CPPFLAGS_EXTRA="${CPPFLAGS}" CFLAGS_EXTRA="${CFLAGS}" CXXFLAGS_EXTRA="${CXXFLAGS}" LDFLAGS_EXTRA="${LDFLAGS}" | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.triceps.${triceps_version} : build.triceps.${triceps_version}
	mkdir -p ${PREFIX}
	rm -rf ${PREFIX}/include ${PREFIX}/lib64
	cp -r triceps-${triceps_version}-src/cpp ${PREFIX}/include
	mv ${PREFIX}/include/build ${PREFIX}/lib64
	${MAKE} -C triceps-${triceps_version}-src CPPFLAGS_EXTRA="${CPPFLAGS}" CFLAGS_EXTRA="${CFLAGS}" CXXFLAGS_EXTRA="${CXXFLAGS}" LDFLAGS_EXTRA="${LDFLAGS}" DESTDIR=${PREFIX} install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

triceps-${triceps_version}-src : ${DOWNLOAD_DIR}/triceps-${triceps_version}.tgz
	tar xf $<
	cd triceps-${triceps_version} && patch -p1 < ../triceps-c++11.patch
	mv triceps-${triceps_version} $@

${DOWNLOAD_DIR}/triceps-${triceps_version}.tgz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://garr.dl.sourceforge.net/project/triceps/triceps-${triceps_version}/triceps-${triceps_version}.tgz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/triceps-${triceps_version}.tgz

clean :
	rm -rf *.triceps.${triceps_version} triceps-${triceps_version}-src ${PREFIX}

.PHONY: all clean download
