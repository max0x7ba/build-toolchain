PREFIX := $(shell cat PREFIX)

projects := gcc boost tbb poco quickfix zeromq gmock jemalloc websocketpp libevent openssl ctemplate rapidxml triceps libxml2 libxslt ta-lib luajit luabind

all : build
build : $(addprefix build.,${projects})
clean : $(addprefix clean.,${projects})
download : $(addprefix download.,${projects})

# Every build depends on build.gcc.
$(addprefix build.,$(filter-out gcc,${projects})) : build.gcc

build.quickfix : build.tbb build.boost
build.libevent : build.openssl
build.libxslt : build.libxml2
build.luabind : build.boost build.luajit

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
	yum install bison flex texinfo {elfutils,libunwind,gettext,curl,sqlite,openssl,readline,bzip2,zlib,libpng}-devel

.PHONY: all build clean build.% clean.% download download.% prerequisite
