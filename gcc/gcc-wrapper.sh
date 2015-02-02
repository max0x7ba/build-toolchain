#!/bin/bash
exec ${0}SUFFIX -Wl,-rpath,PREFIX/lib64 "$@"
