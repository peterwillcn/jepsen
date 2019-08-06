#!/bin/sh

cat <<EOF
Welcome to Jepsen on k8s
===========================
EOF

# hack for keep this container running
tail -f /dev/null
