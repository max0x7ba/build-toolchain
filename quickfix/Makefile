include ../versions.mk

PREFIX := ${prefix}/quickfix-${quickfix_version}

CPPFLAGS := -fmessage-length=0 -Wno-deprecated-declarations -pthread -I${prefix}/tbb${tbb_version}/include
CXXFLAGS := -std=gnu++14
lib_dirs := $(patsubst %,${prefix}/%/lib64,boost-${boost_version} tbb${tbb_version})
LDFLAGS := $(foreach lib_dir,${lib_dirs},-L${lib_dir} -Wl,-rpath,${lib_dir}) -pthread

all : install.quickfix.${quickfix_version}

info :
	@echo "CPPFLAGS=${CPPFLAGS}"
	@echo "CXXFLAGS=${CXXFLAGS}"
	@echo "LDFLAGS=${LDFLAGS}"

configure.quickfix.${quickfix_version} : | quickfix-${quickfix_version}-src
	( cd quickfix-${quickfix_version}-src && ./bootstrap && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-mysql-config=true --without-mysql --with-boost=${prefix}/boost-${boost_version}/include --with-tbb=${prefix}/tbb${tbb_version}/include --with-allocator=tbb CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	cd quickfix-${quickfix_version}-src && patch -p2 < ../include_config.patch && mv config.h src/C++
	mv $@~ $@

build.quickfix.${quickfix_version} : configure.quickfix.${quickfix_version}
	( cd quickfix-${quickfix_version}-src && ${MAKE} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.quickfix.${quickfix_version} : build.quickfix.${quickfix_version}
	( cd quickfix-${quickfix_version}-src && ${MAKE} install ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

quickfix-${quickfix_version}-src : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz
	tar xf $<
	sed -i.original -e 's/-std=c++0x/-std=gnu++14/g' quickfix-${quickfix_version}/configure.ac
	mv quickfix-${quickfix_version} $@

${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ https://github.com/quickfix/quickfix/archive/${quickfix_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/quickfix-${quickfix_version}.tar.gz

configure.quickfix : configure.quickfix.${quickfix_version}

clean :
	rm -rf *.quickfix.${quickfix_version} quickfix-${quickfix_version}-src ${PREFIX}

.PHONY: all clean install download configure.quickfix
