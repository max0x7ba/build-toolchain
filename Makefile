unexport LD_LIBRARY_PATH
unexport LD_RUN_PATH
PREFIX := $(shell cat PREFIX)

projects := gcc boost tbb poco quickfix zeromq gmock jemalloc websocketpp libevent openssl ctemplate rapidxml triceps libxml2 libxslt ta-lib luajit luabind curl gdb git python

all : build
build : $(addprefix build.,${projects})
clean : $(addprefix clean.,${projects})
download : $(addprefix download.,${projects})

# Every build depends on build.gcc.
$(addprefix build.,$(filter-out gcc,${projects})) : build.gcc

build.python : build.openssl
build.boost : build.python
build.quickfix : build.tbb build.boost
build.libevent : build.openssl
build.libxslt : build.libxml2
build.luabind : build.boost build.luajit
build.curl : build.openssl
build.git : build.openssl build.curl
build.gdb : build.python

${PREFIX} :
	mkdir -p $@

build.% : | ${PREFIX}
	${MAKE} -C $*

clean :
	rm -rf ${PREFIX}/*

clean.% :
	${MAKE} -C $* clean

download.% :
	${MAKE} -C $* download

prerequisite :
	yum install bison flex texinfo {elfutils,libunwind,gettext,curl,sqlite,openssl,readline,bzip2,zlib,libpng,expat,openblas,atlas}-devel

.PHONY: all build clean build.% clean.% download download.% prerequisite
