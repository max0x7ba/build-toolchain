include ../versions.mk

PREFIX := ${prefix}/git-${git_version}

CPPFLAGS := -fmessage-length=0
CFLAGS := -g -O2 -Wall
CXXFLAGS := -std=gnu++14
LDFLAGS := -Wl,-rpath,${PREFIX}/lib64

all : install.git.${git_version}

make_cmd = +${MAKE} -C git-${git_version}-src CXX=g++ CC=gcc prefix=${PREFIX} CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" lib=lib64 PTHREAD_LIBS="-pthread" PTHREAD_CFLAGS="-pthread" NO_R_TO_GCC_LINKER=1 OPENSSLDIR="${prefix}/openssl-${openssl_version}" CURLDIR="${prefix}/curl-${curl_version}" V=1

build.git.${git_version} : | git-${git_version}-src
	${make_cmd} | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

install.git.${git_version} : build.git.${git_version}
	${make_cmd} install | tee $@~; exit $${PIPESTATUS[0]}
	mv $@~ $@

git-${git_version}-src : ${DOWNLOAD_DIR}/git-${git_version}.tar.gz
	tar xf $<
	mv git-${git_version} $@
	touch $@

${DOWNLOAD_DIR}/git-${git_version}.tar.gz : | ${DOWNLOAD_DIR}
	wget -O $@~ http://github.com/git/git/archive/v${git_version}.tar.gz
	mv $@{~,}

download : ${DOWNLOAD_DIR}/git-${git_version}.tar.gz

clean :
	rm -rf *.git.${git_version} git-${git_version}-src ${PREFIX}

.PHONY: all clean download
