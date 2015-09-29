include ../versions.mk

PREFIX := ${prefix}/tbb${tbb_version}

CXXFLAGS := -std=gnu++14 -pthread -fmessage-length=0 -Wno-deprecated-declarations -D_TBB_CPP0X
LDFLAGS := -pthread -Wl,-rpath,${PREFIX}/lib64 -fmessage-length=0

all : install.tbb.${tbb_version}

build.tbb.${tbb_version} : | tbb${tbb_version}-src
	${MAKE} -C tbb${tbb_version}-src -j${JOBS} CXXFLAGS='${CXXFLAGS}' LDFLAGS='${LDFLAGS}'
	touch $@

${PREFIX}/lib64 ${PREFIX}/include : build.tbb.${tbb_version} | ${PREFIX}

${PREFIX}/lib64 :
	mkdir -p $@~
	cp -a tbb${tbb_version}-src/build/*/*.so{,.2} $@~
	mv $@{~,}

${PREFIX}/include :
	mkdir -p $@~
	cp -a tbb${tbb_version}-src/include/* $@~
	mv $@{~,}

install.tbb.${tbb_version} : ${PREFIX}/lib64 ${PREFIX}/include
	touch $@

tbb${tbb_version}-src : ${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz
	tar xzf $<
	mv tbb${tbb_version} $@
	touch $@

${PREFIX} ${DOWNLOAD_DIR} :
	mkdir $@

${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb${tbb_version}_src.tgz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/tbb${tbb_version}_src.tgz

build : build.tbb.${tbb_version}

clean :
	rm -rf ${PREFIX} tbb${tbb_version}-src  build.* install.*

.PHONY : all clean build
.PRECIOUS : %.tgz install.% build.%
