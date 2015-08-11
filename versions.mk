SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

openssl_version := 1.0.2d
libevent_version := 2.0.22
ctemplate_version := 2.3
rapidxml_version := 1.13
triceps_version := 2.0.1
libxml2_version := 2.9.2
libxslt_version := 1.1.28
