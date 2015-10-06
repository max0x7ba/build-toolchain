# Usage:
#
# $ make download
# $ make -j8
#
# Note: the ftp doesn't allow parallel downloads.
# Note: it make not build with the default make-3.82. Build your own from latest sources.
#
#

SHELL := /bin/bash

GCC_VERSION := 5.2.0
PREFIX := $(shell cat ../PREFIX)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})

gcc_version := ${GCC_VERSION}

gmp_version.4.8.3      := 4.3.2
mpfr_version.4.8.3     := 2.4.2
mpc_version.4.8.3      := 0.8.1
isl_version.4.8.3      := 0.11.1
cloog_version.4.8.3    := 0.18.0
binutils_version.4.8.3 := 2.24

gmp_version.4.9.2      := 4.3.2
mpfr_version.4.9.2     := 2.4.2
mpc_version.4.9.2      := 0.8.1
isl_version.4.9.2      := 0.12.2
cloog_version.4.9.2    := 0.18.1
binutils_version.4.9.2 := 2.25

gmp_version.5.1.0      := 4.3.2
mpfr_version.5.1.0     := 2.4.2
mpc_version.5.1.0      := 0.8.1
isl_version.5.1.0      := 0.14
binutils_version.5.1.0 := 2.25

# TODO: switch URLs for the latest versions
# gmp_version.5.2.0      := 6.0.0a
# mpfr_version.5.2.0     := 3.1.3
# mpc_version.5.2.0      := 1.0.3
# isl_version.5.2.0      := 0.15
gmp_version.5.2.0      := 4.3.2
mpfr_version.5.2.0     := 2.4.2
mpc_version.5.2.0      := 0.8.1
isl_version.5.2.0      := 0.14
binutils_version.5.2.0 := 2.25

gmp_version   := ${gmp_version.${gcc_version}}
mpfr_version  := ${mpfr_version.${gcc_version}}
mpc_version   := ${mpc_version.${gcc_version}}
isl_version   := ${isl_version.${gcc_version}}
cloog_version := ${cloog_version.${gcc_version}}
binutils_version := ${binutils_version.${gcc_version}}

make_version  := 4.1

libs.5.1.0 := gmp mpfr mpc isl binutils
libs.5.2.0 := ${libs.5.1.0}
libs := $(or ${libs.${gcc_version}},gmp mpfr mpc cloog isl binutils)

extension.mpc := gz
extension.cloog := gz
extension = $(or ${extension.${1}},bz2)

downloads := $(foreach app,gcc make,${DOWNLOAD_DIR}/${app}-${${app}_version}.tar.bz2) \
  $(foreach lib,${libs},${DOWNLOAD_DIR}/${lib}-${${lib}_version}.tar.$(call extension,${lib}))

# TODO: 32/64 bit mode switch

build_target.gcc.5.1.0 := profiledbootstrap
build_target.gcc.5.2.0 := profiledbootstrap
build_target.gcc := ${build_target.gcc.${gcc_version}}

# CentOS release 5.11 (Final)
# Red Hat Enterprise Linux Server release 5.6 (Tikanga)
# Red Hat Enterprise Linux Server release 6.2 (Santiago)
redhat_version := $(or $(shell sed -e 's/.* release \([0-9]\.[0-9]\+\) .*/\1/' /etc/redhat-release 2>/dev/null),6.6)
redhat_major := $(word 1,$(subst ., ,${redhat_version}))
# $(info ${redhat_version})
# $(info ${redhat_major})

conf.gcc.4.8.3 := --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit --enable-checking=release --disable-multilib $(patsubst %,--with-%-include=${PREFIX}/include,${libs}) $(patsubst %,--with-%-lib=${PREFIX}/lib64,${libs}) --enable-languages=c,c++,fortran,lto --enable-plugin --enable-initfini-array --enable-gold=default --enable-libstdcxx-time --enable-linker-build-id --with-linker-hash-style=gnu --disable-libgcj
conf.gcc.4.9.2 := --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit --enable-checking=release --disable-multiarch --disable-multilib $(patsubst %,--with-%-include=${PREFIX}/include,${libs}) $(patsubst %,--with-%-lib=${PREFIX}/lib64,${libs}) --enable-languages=c,c++,fortran,lto --enable-plugin --enable-initfini-array --enable-gold=default --enable-libstdcxx-time --enable-linker-build-id --with-linker-hash-style=gnu --disable-libgcj

conf.gcc.5.1.0.redhat.5 := --disable-gnu-unique-object
conf.gcc.5.1.0.redhat := $(or ${conf.gcc.5.1.0.redhat.${redhat_major}},--enable-linker-build-id --enable-gnu-unique-object --with-build-config=bootstrap-lto)
conf.gcc.5.1.0 := --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit --enable-shared --enable-threads=posix --enable-checking=release --disable-multiarch --disable-multilib $(patsubst %,--with-%-include=${PREFIX}/include,${libs}) $(patsubst %,--with-%-lib=${PREFIX}/lib64,${libs}) --enable-languages=c,c++,fortran,lto --enable-plugin --enable-initfini-array --enable-gold=default --enable-libstdcxx-time --with-linker-hash-style=gnu --disable-libgcj --with-default-libstdcxx-abi=OPTION=gcc4-compatible ${conf.gcc.5.1.0.redhat}

conf.gcc.5.2.0 := ${conf.gcc.5.1.0}

#export CPPFLAGS := -march=native -fmessage-length=0
export CPPFLAGS := -fmessage-length=0
export LDFLAGS := -L${PREFIX}/lib64
export LD_RUN_PATH := ${PREFIX}/lib64

export PATH := /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

stock_gcc_version := $(shell PATH=${PATH} gcc -dumpversion)
#configure.binutils.gcc-4.8.3 := CXXFLAGS='-Wno-error=narrowing'

all : install

install : install.gcc.spec install.make

dbg :
	@echo "PATH=$$PATH"
	@echo "PREFIX=${PREFIX}"
	@echo "libs=${libs}"

# build new make with the new gcc
configure.make build.make install.make : PATH := ${PREFIX}/bin:${PATH}

configure.make : install.gcc.spec | make-${make_version}-src make-${make_version}-obj
	( cd make-${make_version}-obj && ../make-${make_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.gmp : | gmp-${gmp_version}-src gmp-${gmp_version}-obj
	( cd gmp-${gmp_version}-obj && ../gmp-${gmp_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --build=core2-unknown-linux-gnu --enable-cxx ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.mpfr : install.gmp | mpfr-${mpfr_version}-src mpfr-${mpfr_version}-obj
	( cd mpfr-${mpfr_version}-obj && ../mpfr-${mpfr_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-gmp=${PREFIX} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.mpc : install.gmp install.mpfr | mpc-${mpc_version}-src mpc-${mpc_version}-obj
	( cd mpc-${mpc_version}-obj && ../mpc-${mpc_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-gmp=${PREFIX} --with-mpfr=${PREFIX} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.isl : install.gmp | isl-${isl_version}-src isl-${isl_version}-obj
	( cd isl-${isl_version}-obj && ../isl-${isl_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-gmp-prefix=${PREFIX} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.cloog : install.gmp install.isl | cloog-${cloog_version}-src cloog-${cloog_version}-obj
	( cd cloog-${cloog_version}-obj && ../cloog-${cloog_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --with-gmp-prefix=${PREFIX} --with-isl-prefix=${PREFIX} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.binutils : install.isl install.gmp install.mpfr install.mpc | binutils-${binutils_version}-src binutils-${binutils_version}-obj
	( cd binutils-${binutils_version}-obj && ../binutils-${binutils_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --enable-lto --enable-plugins --enable-gold=default --enable-threads ${configure.binutils.gcc-${stock_gcc_version}} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

configure.gcc build.gcc install.gcc : PATH := ${PREFIX}/bin:${PATH}
configure.gcc : ${libs:%=install.%} | gcc-${gcc_version}-obj gcc-${gcc_version}-src
	( cd gcc-${gcc_version}-obj && ../gcc-${gcc_version}-src/configure --prefix=${PREFIX} ${conf.gcc.${gcc_version}} ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

# This target makes gcc embed RUNPATH into the executables and shared libraries built with this
# toolchain. So that tweaking LD_LIBRARY_PATH is unnecessary.
install.gcc.spec : PATH := ${PREFIX}/bin:${PATH}
install.gcc.spec : install.gcc
	g++ -dumpspecs | awk '/^\*link:/ { print; getline; print "-rpath=${PREFIX}/lib64", $$0; next } { print }' > $$(dirname $$(g++ -print-libgcc-file-name))/specs
	touch $@

${DOWNLOAD_DIR} :
	mkdir $@

${DOWNLOAD_DIR}/gcc-${gcc_version}.tar.bz2 : | ${DOWNLOAD_DIR}
	curl --output $@ ftp://gcc.gnu.org/pub/gcc/releases/gcc-${gcc_version}/${@F}

# binutils different url
${DOWNLOAD_DIR}/binutils-${binutils_version}.tar.bz2 : | ${DOWNLOAD_DIR}
	curl --output $@ http://ftp.gnu.org/gnu/binutils/${@F}

# binutils patch to make `gold` honour LD_RUN_PATH as ld.bfd does
binutils-${binutils_version}-src : ${DOWNLOAD_DIR}/binutils-${binutils_version}.tar.bz2
	tar xjf $<
	cd binutils-${binutils_version} && patch --backup -p1 < ../gold-ld_run_path.patch
	mv binutils-${binutils_version} $@
	touch $@

${DOWNLOAD_DIR}/make-%.tar.bz2 : | ${DOWNLOAD_DIR}
	curl --output $@ http://ftp.gnu.org/gnu/make/${@F}

${DOWNLOAD_DIR}/% : | ${DOWNLOAD_DIR}
	curl --output $@ ftp://gcc.gnu.org/pub/gcc/infrastructure/${@F}

build.% : configure.%
	${MAKE} -C $*-${$*_version}-obj ${build_target.$*} | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.make : install.% : build.%
	${MAKE} -C $*-${$*_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
#	cd $(dir ${PREFIX}) && ln -fs $(notdir ${PREFIX})/bin/make
	mv $@~ $@

install.% : build.%
	${MAKE} -C $*-${$*_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

%-src : ${DOWNLOAD_DIR}/%.tar.bz2
	tar xjf $<
	mv $* $@
	touch $@

%-src : ${DOWNLOAD_DIR}/%.tar.gz
	tar xzf $<
	mv $* $@
	touch $@

%-obj :
	mkdir $@


clean :
	rm -rf build.* configure.* install.* *-obj

# -j8: 5:41
install_libs : $(addprefix install.,${libs})

download : ${downloads}

.PHONY : all clean install_libs download install
.PRECIOUS : %.bz2 %.gz %-src %-obj install.% build.%
