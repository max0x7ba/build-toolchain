include ../versions.mk

BOOST_VERSION := $(subst .,_,${boost_version})
PREFIX := ${prefix}/boost-${boost_version}

all : install.boost.${BOOST_VERSION}

patch.boost.1_55_0 = patch -p0 -b < date_time_ticket_9489.patch

configure.boost.${BOOST_VERSION} : | boost_${BOOST_VERSION}
	cd boost_${BOOST_VERSION} && ./bootstrap.sh --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-python=${prefix}/python-${python_version}/bin/python
	touch $@

b2.options := -j${JOBS} --build-dir=${CURDIR}/boost_${BOOST_VERSION}-obj --layout=system --disable-icu variant=release link=shared threading=multi runtime-link=shared cxxflags='-std=gnu++14 -fmessage-length=0 -Wno-unused-local-typedefs -Wno-deprecated-declarations -Wno-unused-variable -Wno-sign-compare' linkflags='-Wl,-rpath,${PREFIX}/lib64' boost.locale.icu=off boost.locale.iconv=on

build.boost.${BOOST_VERSION} : configure.boost.${BOOST_VERSION}
	cd boost_${BOOST_VERSION} && ./b2 -d+2 ${b2.options}
	touch $@

install.boost.${BOOST_VERSION} : build.boost.${BOOST_VERSION}
	cd boost_${BOOST_VERSION} && ./b2 ${b2.options} install
	touch $@

boost_trunk : ~/src/boost-trunk
	ln -s $^ $@
	touch $@

ifneq (${BOOST_VERSION},trunk)

boost_${BOOST_VERSION} : ${DOWNLOAD_DIR}/boost_${BOOST_VERSION}.tar.bz2
	tar xjf $<
	${patch.boost.${BOOST_VERSION}}
#	echo '#define BOOST_THREAD_DONT_PROVIDE_INTERRUPTIONS' >> boost_${BOOST_VERSION}/boost/config/user.hpp
#	echo '#define BOOST_LOG_NO_THREADS' >> boost_${BOOST_VERSION}/boost/config/user.hpp
	touch $@

endif

${DOWNLOAD_DIR} :
	mkdir $@

${DOWNLOAD_DIR}/boost_${BOOST_VERSION}.tar.bz2 : | ${DOWNLOAD_DIR}
	wget --output-document $@ http://ftp.mirrorservice.org/sites/downloads.sourceforge.net/b/bo/boost/boost/$(subst _,.,${BOOST_VERSION})/boost_${BOOST_VERSION}.tar.bz2

download : ${DOWNLOAD_DIR}/boost_${BOOST_VERSION}.tar.bz2

clean :
	rm -rf ${PREFIX} boost_${BOOST_VERSION}-obj configure.boost.${BOOST_VERSION} build.boost.${BOOST_VERSION} install.boost.${BOOST_VERSION}

.PHONY : all clean download
.PRECIOUS : %.bz2 install.% build.%
