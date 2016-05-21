#!/bin/sh

if ! test $msys_arch
then
   echo Error: msys_arch not defined
   exit 1
fi

if [ "$msys_arch" = "32" ]
then
    sed "s/@target@/i686/" Dockerfile.body.template > Dockerfile.body
elif [ "$msys_arch" = "64" ]
then
    sed "s/@target@/x86_64/" Dockerfile.body.template > Dockerfile.body
fi
sed -i "s/@arch@/$msys_arch/" Dockerfile.body
cat Dockerfile.head Dockerfile.body > Dockerfile.$msys_arch
