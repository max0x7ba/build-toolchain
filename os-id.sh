#!/bin/bash

if [[ -r /etc/redhat-release ]]; then
    awk -f - /etc/redhat-release <<'EOF'
/CentOS release [0-9]+\.[0-9]+/ { print "centos-" $3 }
/Fedora release [0-9]+/         { print "fedora-" $3 }
/Red Hat Enterprise Linux Server release [0-9]+(\.[0-9]+)?/ { print "redhat-" $3 }
EOF

fi
