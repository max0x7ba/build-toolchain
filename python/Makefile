# Clean installation:
#     make clean
#     make download
#     time make -j8
#
# Uninstall and clean a module, pytz for example:
#
#      time make uninstall.pytz clean.pytz
#
# Note: specifying -r make option breaks Python build, don't use it.

include ../versions.mk

all : install

.SECONDEXPANSION:

export PREFIX:=${prefix}/python-${python_version}
CPPFLAGS := -fmessage-length=0 -I${prefix}/openssl-${openssl_version}/include
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64 $(addsuffix ${prefix}/openssl-${openssl_version}/lib64,-L -Wl,-rpath,)

# Adding a new package is a 3-step process:
# 1. Add the package name to ${packages} variable.
# 2. Specify the source file directory in ${package-name.src} variable.
# 3. Specify package dependencies on other packages if any.
# 3.1 Specify where to download packages from.
# 4. Add symlinks if necessary.
# 5. Add extra build flags if necessary.
# 6. Specify where to download the source from.

# Step 1.
packages := python Cython pytz setuptools python-dateutil \
  coverage openpyxl ujson requests nose Pillow
# TODO: matplotlib numpy scipy pandas statsmodels patsy

# Step 2.
python.src     := Python-${python_version}
numpy.src      := numpy-1.9.3
pygresql.src   := PyGreSQL-trunk/module
pytz.src       := pytz-2015.6
scipy.src      := scipy-0.14.0
pandas.src     := pandas-0.15.0
Cython.src     := Cython-0.23.2
pymssql.src    := pymssql-2.0.0b1-dev-20111019
setuptools.src := setuptools-18.3.2
ipython.src    := ipython-2.3.0
fpconst.src    := fpconst-0.7.2
suds.src       := python-suds-0.4
pyzmq.src      := pyzmq-14.4.0
matplotlib.src := matplotlib-1.4.2
sip.src        := sip-4.13.1
pyqt4.src      := PyQt-x11-gpl-4.9
Pygments.src   := Pygments-1.6
pexpect.src    := pexpect-3.3
pymongo.src    := pymongo-2.7.2
coverage.src   := coverage-4.0
ujson.src      := ujson-1.33
requests.src   := requests-2.7.0
nose.src       := nose-1.3.7
Pillow.src     := Pillow-2.9.0
python-dateutil.src := python-dateutil-2.4.2
statsmodels.src := statsmodels-0.5.0
openpyxl.src   := openpyxl-2.3.0-b2
patsy.src      := patsy-0.4.0

# Step 3.
#build.matplotlib : install.pyqt4
build.matplotlib build.scipy : install.numpy
build.pandas build.pymssql : install.Cython
install.python-dateutil build.python-dateutil build.pymssql build.suds build.nose build.coverage build.Pillow : install.setuptools
build.pandas : install.python-dateutil install.numpy install.ujson install.openpyxl
build.pyqt4 : install.sip
build.sip : install.setuptools
build.statsmodels : install.numpy install.Cython install.scipy install.openpyxl install.patsy

# Step 4.
symlinks.bin.python := python2.7->scb-python python2.7->scb-python2 python2.7->scb-python2.7
symlinks.bin.ipython := ipython->scb-ipython
symlinks.bin.Cython := cython->scb-cython cygdb->scb-cygdb

# Step 5.
#build.flags.statsmodels := --with-cython

################################################################################
# Step 6.

downloads :=

patch.Python-2.7.4 := cd Python-2.7.4 && patch -p1 < ../issue17703.patch
patch = ${patch.${1}}

expand.zip = unzip ${1}
expand.tar.bz2 = tar xf ${1}
expand.tar.xz = tar xf ${1}
expand.tar.gz = tar xf ${1}

# ${1} - package, as in ${packages}
# ${2} - archive suffix
# ${3} - url
# ${4} - local filename
define download_and_extract
  ${DOWNLOAD_DIR}/${4} : ; wget ${WGET_OPTIONS} --output-document $$@~ ${3} && mv $$@~ $$@
  downloads += ${DOWNLOAD_DIR}/${4}
  ${${1}.src} : ${DOWNLOAD_DIR}/${4}
	$$(call expand.${2},$$<,$$@)
	$$(call patch,$$@)
	touch $$@
endef

# ${1} - package, as in ${packages}
# ${2} - archive suffix
download_pypi = $(call download_and_extract,${1},${2},http://pypi.python.org/packages/source/$(shell printf %c ${1})/${1}/${${1}.src}.${2},${${1}.src}.${2})

# ${1} - package, as in ${packages}
# ${2} - archive suffix
# ${3} - url
download_url = $(call download_and_extract,${1},${2},${3},$(shell basename "${3}"))

.SECONDARY: %.tar.xz %.tar.gz %.tar.bz2 %.zip

# Step 3.1.
$(eval $(call download_url,python,tar.xz,http://www.python.org/ftp/python/${python_version}/${python.src}.tar.xz))
#$(eval $(call download_pypi,ipython,tar.gz))
$(eval $(call download_pypi,pytz,tar.bz2))
#$(eval $(call download_pypi,pandas,tar.gz))
#$(eval $(call download_pypi,numpy,tar.gz))
#$(eval $(call download_pypi,scipy,tar.gz))
$(eval $(call download_pypi,Pillow,zip))
$(eval $(call download_pypi,setuptools,tar.gz))
$(eval $(call download_pypi,python-dateutil,tar.gz))
$(eval $(call download_pypi,pyzmq,tar.gz))
#$(eval $(call download_url,matplotlib,tar.gz,http://ftp.mirrorservice.org/sites/downloads.sourceforge.net/m/ma/matplotlib/matplotlib/${matplotlib.src}/${matplotlib.src}.tar.gz))
#$(eval $(call download_pypi,statsmodels,tar.gz))
#$(eval $(call download_pypi,Pygments,tar.gz))
#$(eval $(call download_pypi,pymongo,tar.gz))
$(eval $(call download_pypi,coverage,tar.gz))
$(eval $(call download_pypi,ujson,zip))
$(eval $(call download_pypi,requests,tar.gz))
$(eval $(call download_pypi,nose,tar.gz))
#$(eval $(call download_pypi,fpconst,tar.gz))
#$(eval $(call download_pypi,pexpect,tar.gz))
$(eval $(call download_pypi,Cython,tar.gz))
$(eval $(call download_pypi,openpyxl,tar.gz))
$(eval $(call download_pypi,patsy,zip))

download : ${downloads}

################################################################################

dbg :
	@echo "MAKEFLAGS=${MAKEFLAGS}"
	@echo "PREFIX=${PREFIX}"
	@echo "PATH=$$PATH"
	@echo "install_dir=${install_dir}"
	@echo "downloads=${downloads}"

# Using distribution-specific versions of these native libraries to avoid compiling all
# dependencies.
# RHEL zeromq-devel: http://mirror.bytemark.co.uk/fedora/epel/6/i386/repoview/epel-release.html
# RHEL pyqt47-devel: http://atrpms.net/documentation/install/
install-prerequisites :
	sudo yum install openblas-devel atlas-devel postgresql-devel sqlite-devel zeromq-devel qt47-devel qt47webkit-devel phonon-devel openssl-devel readline-devel bzip2-devel zlib-devel libpng-devel

################################################################################
# Generic rules for Distutils/setup.py based packages.

cppflags := ${CPPFLAGS}

install_lockfile := /tmp/$(shell date +make-python-%s-%N.lock)

before_install = lockfile -1 ${install_lockfile}; find ${PREFIX} -type f > install.${1}.before
after_install = find ${PREFIX} -type f > install.${1}.after; rm -f ${install_lockfile}; sort install.${1}.before install.${1}.after | uniq -u > install.${1}

echo_action = @echo -e "\n\n*** $(subst ., ,$@) ***\n"

# TODO: might need to change it to hard links.
symlink.bin = cd ${PREFIX}/bin $(foreach symlink,${symlinks.bin.${1}},&& ln -fs $(subst ->, ,${symlink}))
symlink = $(call symlink.bin,${1})

build.% : install.python install.setuptools | $${$$*.src}
	${echo_action}
	(cd ${$*.src} && CPPFLAGS="${cppflags}" LDFLAGS="${LDFLAGS}" ${PREFIX}/bin/python setup.py ${build.flags.$*} build) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

clean.% :
	${echo_action}
	rm -rf ${$*.src} build.$*

install.% : build.%
	${echo_action}
	$(call before_install,$*)
	cd ${$*.src} && CPPFLAGS="${cppflags}" LDFLAGS="${LDFLAGS}" ${PREFIX}/bin/python setup.py install
	$(call symlink,$*)
	$(call after_install,$*)

uninstall.% :
	${echo_action}
	-xargs --arg-file=install.$* rm -f
	rm -f install.$* install.$*.before install.$*.after

################################################################################
# Python

build.python : | ${python.src}
	${echo_action}
	cd ${python.src} && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --enable-unicode=ucs4 CPPFLAGS="${cppflags}" LDFLAGS="${LDFLAGS}"
	sed -i -e 's/\(#define _POSIX_C_SOURCE [0-9]\+L\)/#ifndef _POSIX_C_SOURCE\n\1\n#endif/' -e 's/\(#define _XOPEN_SOURCE [0-9]\+\)/#ifndef _XOPEN_SOURCE\n\1\n#endif/' ${python.src}/pyconfig.h
	${MAKE} -C ${python.src}
	touch $@

clean.python :
	${echo_action}
	${MAKE} -C ${python.src} distclean
	rm -rf build.python

# Python build system ignores libdir.  Work-around that by making lib/python2.7 a symlink to
# lib64/python2.7, so that all python modules go into one directory. Doing so prevents from
# having both 64 and 32-bit versions at the same time. Stick with 64-bit version for now and see
# if a 32-bit version is ever needed.
install.python : build.python
	${echo_action}
	mkdir -p ${PREFIX}/lib64/python2.7 ${PREFIX}/lib && cd ${PREFIX}/lib && ln -fs ../lib64/python2.7
	$(call before_install,python)
	${MAKE} -C ${python.src} install
	$(call symlink,python)
	$(call after_install,python)

################################################################################
# sip (required by PyQt)

build.sip : install.python
	${echo_action}
	cd ${sip.src} && ${PREFIX}/bin/python configure.py
	${MAKE} -rC ${sip.src}
	touch $@

install.sip : build.sip
	${echo_action}
	$(call before_install,sip)
	${MAKE} -rC ${sip.src} install
	$(call symlink,sip)
	$(call after_install,sip)

clean.sip :
	${echo_action}
	${MAKE} -C ${sip.src} clean
	rm -f ${sip.src}/Makefile build.sip

################################################################################
# PyQt4

# PyQt requires at least qt-devel version 4.7.
#
# Fedora 14 comes with qt-devel-4.7.4.
#
# CentOS/RHEL 6.x comes with qt-devel-4.6. To get qt-devel-4.7 do as root:
#
# # rpm -Uvh http://dl.atrpms.net/el6-x86_64/atrpms/stable/atrpms-repo-6-5.el6.x86_64.rpm
# # yum remove "qt-*" "qt4-*"
# # yum --enablerepo=atrpms-testing install qt47-devel
#
# See http://packages.atrpms.net/dist/el6/atrpms-repo/
# TODO: update this in the future when it gets released from atrpms-testing repo.

build.pyqt4 : install.python
	${echo_action}
	cd ${pyqt4.src} && PATH=$$PATH:/usr/lib64/qt47/bin:/usr/lib64/qt4/bin ${PREFIX}/bin/scb-python2 configure.py --verbose --assume-shared --confirm-license
	${MAKE} -rC ${pyqt4.src}
	touch $@

install.pyqt4 : build.pyqt4
	${echo_action}
	$(call before_install,pyqt4)
	${MAKE} -rC ${pyqt4.src} install
	$(call symlink,pyqt4)
	$(call after_install,pyqt4)

clean.pyqt4 :
	${echo_action}
	${MAKE} -rC ${pyqt4.src} clean
	rm -f ${pyqt4.src}/Makefile build.pyqt4

################################################################################

build : $(packages:%=build.%)
#clean : $(packages:%=clean.%)
uninstall : $(packages:%=uninstall.%)
install : $(packages:%=install.%)

clean :
	rm -rf $(foreach p,${packages},${${p}.src}) install.* build.*

.PHONY : download help dbg all clean build install uninstall uninstall.% clean.% install-prerequisites
.SECONDARY :
