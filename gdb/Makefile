include ../versions.mk

PREFIX := ${prefix}/gdb-${gdb_version}

CPPFLAGS := -fmessage-length=0
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64

all : install.gdb.${gdb_version}

# These libraries do not seem to be used at all, yet gdb configure requires them.
libs := mpc mpfr gmp isl

configure.gdb.${gdb_version} : | gdb-${gdb_version}-src gdb-${gdb_version}-obj
	( cd gdb-${gdb_version}-obj && ../gdb-${gdb_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 $(patsubst %,--with-%-include=${PREFIX}/include,${libs}) $(patsubst %,--with-%-lib=${PREFIX}/lib64,${libs}) --disable-isl-version-check CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.gdb.${gdb_version} : configure.gdb.${gdb_version}
	${MAKE} -C gdb-${gdb_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.gdb.${gdb_version} : build.gdb.${gdb_version}
	${MAKE} -C gdb-${gdb_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

gdb-${gdb_version}-obj :
	mkdir $@

gdb-${gdb_version}-src : ${DOWNLOAD_DIR}/gdb-${gdb_version}.tar.gz
	tar xf $<
	mv gdb-${gdb_version} $@
	touch $@

${DOWNLOAD_DIR}/gdb-${gdb_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://ftp.gnu.org/gnu/gdb/gdb-7.9.1.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/gdb-${gdb_version}.tar.gz

clean :
	rm -rf *.gdb.${gdb_version} gdb-${gdb_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
