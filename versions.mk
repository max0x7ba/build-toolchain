SHELL := /bin/bash
JOBS := $(shell getconf _NPROCESSORS_ONLN)

DOWNLOAD_DIR := ~/Downloads
DOWNLOAD_DIR := $(shell echo ${DOWNLOAD_DIR})
prefix := $(shell cat ../PREFIX)
export PATH := ${prefix}/bin:${PATH}

openssl_version := 1.0.2d
libevent_version := 2.0.22
