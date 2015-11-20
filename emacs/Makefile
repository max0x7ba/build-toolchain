include ../versions.mk

PREFIX := ${prefix}/emacs-${emacs_version}

CPPFLAGS := -pthread -fmessage-length=0
CFLAGS :=
CXXFLAGS := -std=gnu++14
LDFLAGS :=

all : install.emacs.${emacs_version}

configure.emacs.${emacs_version} : | emacs-${emacs_version}-src emacs-${emacs_version}-obj
	( cd emacs-${emacs_version}-obj && ../emacs-${emacs_version}-src/configure --prefix=${PREFIX} --libdir=${PREFIX}/lib64 --without-pop --with-sound=no --with-x-toolkit=gtk3 --with-file-notification=inotify --without-makeinfo --with-x CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" ) | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

build.emacs.${emacs_version} : configure.emacs.${emacs_version}
	${MAKE} -C emacs-${emacs_version}-obj | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.emacs.${emacs_version} : build.emacs.${emacs_version}
	${MAKE} -C emacs-${emacs_version}-obj install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

emacs-${emacs_version}-obj :
	mkdir $@

emacs-${emacs_version}-src : ${DOWNLOAD_DIR}/emacs-${emacs_version}.tar.xz
	tar xf $<
	mv emacs-${emacs_version} $@
	touch $@

${DOWNLOAD_DIR}/emacs-${emacs_version}.tar.xz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://ftp.heanet.ie/mirrors/gnu/emacs/emacs-${emacs_version}.tar.xz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/emacs-${emacs_version}.tar.xz

clean :
	rm -rf *.emacs.${emacs_version} emacs-${emacs_version}-{src,obj} ${PREFIX}

.PHONY: all clean download
