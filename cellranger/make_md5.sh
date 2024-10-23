#!/bin/bash

lib=$1
fls=$(find -L ${lib}/ -type f ! -name *.md5)
for f in $fls; do
    echo $f
    pushd $(dirname $f)
    x=$(basename $f)
    [ ! -s ${x}.md5 ] && md5sum $x > ${x}.md5
    popd
done

