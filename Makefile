PREFIX := $(shell cat PREFIX)

projects := gcc boost tbb poco quickfix zeromq gmock

gcc.dir := gcc
boost.dir := boost
tbb.dir := tbb
poco.dir := poco
quickfix.dir = quickfix
zeromq.dir = zeromq
gmock.dir = gmock

all : build
build : $(addprefix build.,${projects})
clean : $(addprefix clean.,${projects})
download : $(addprefix download.,${projects})

$(addprefix build., boost tbb poco quickfix zeromq gmock) : build.gcc
build.quickfix : build.tbb build.boost

${PREFIX} :
	mkdir -p $@

build.% : | ${PREFIX}
	${MAKE} -C ${$*.dir}

clean :
	rm -rf ${PREFIX}/*

clean.% :
	${MAKE} -C ${$*.dir} clean

download.% :
	${MAKE} -C ${$*.dir} download

prerequisite :
	yum install bison flex texinfo {elfutils,libunwind,gettext,curl,sqlite,openssl,readline,bzip2,zlib,libpng}-devel

.PHONY: all build clean clean.% download download.% prerequisite
