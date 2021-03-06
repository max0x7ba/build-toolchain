SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)

export PATH := ${prefix}/bin:/usr/local/bin:/usr/bin:/bin
unexport LD_LIBRARY_PATH
unexport LD_RUN_PATH

boost_version := 1.59.0
openssl_version := 1.0.2d
libevent_version := 2.0.22
ctemplate_version := 2.3
rapidxml_version := 1.13
triceps_version := 2.0.1
libxml2_version := 2.9.2
libxslt_version := 1.1.28
ta-lib_version := 0.4.0
luajit_version := 2.0.4
luabind_version := 0.9.1
lua_version := 5.3.1
curl_version := 7.43.0
gdb_version := 7.10
git_version := 2.5.0
python_version := 2.7.10
quickfix_version := e5216dcd1f30a2741de6fe46207af18a091e39a8
tbb_version := 43_20150611oss
emacs_version := 25.2
