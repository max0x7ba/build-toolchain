#!/bin/bash

set -e

[[ -f /etc/os-release ]] && . /etc/os-release && exec echo $ID-$VERSION_ID

[[ -r /etc/redhat-release ]] && exec awk -f - /etc/redhat-release <<'EOF'
/CentOS release [0-9]+\.[0-9]+/                             { print "centos-" $3 }
/Fedora release [0-9]+/                                     { print "fedora-" $3 }
/Red Hat Enterprise Linux Server release [0-9]+(\.[0-9]+)?/ { print "redhat-" $7 }
EOF
