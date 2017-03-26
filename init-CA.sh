#!/bin/bash
hash cfssl 2>/dev/null || { echo >&2 "Cannot find 'cfssl', install with 'brew install cfssl' or visit https://github.com/cloudflare/cfssl"; exit 1; }

certsDir=./localCA//certs
[ -d $certsDir ] || mkdir -p $certsDir
[ -s ${certsDir}/ca.pem ] && { echo "... saving old cert as old-ca.pem"; rm -f ${certsDir}/old-ca.pem > /dev/null; mv ${certsDir}/ca.pem ${certsDir}/old-ca.pem ; }
[ -s ${certsDir}/ca-key.pem ] && { echo "... saving old key as old-ca-key.pem"; rm -f ${certsDir}/old-ca-key.pem > /dev/null; mv ${certsDir}/ca-key.pem ${certsDir}/old-ca-key.pem ; }

cfssl gencert -initca localCA/ca-csr.json | cfssljson -bare ${certsDir}/ca -
chmod 0400 ${certsDir}/ca-key.pem
rm ${certsDir}/ca.csr

cfssl certinfo -cert ${certsDir}/ca.pem

