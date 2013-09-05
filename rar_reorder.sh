#!/bin/bash
for f in `ls -1 *.??`; do
    x=`unrar l $f | egrep -o 'volume [0-9]+' | egrep -o '[0-9]+'`;
    if [ -z $x ]; then
        continue
    fi

    if [ $x == 1 ]; then
        ext='rar'
    else
        x=`expr $x - 2`
        ext=$(printf 'r%02d' $x)
    fi

    outfile=`unrar l $f | grep -A2 "Packed Ratio" | tail -1 | cut -d' ' -f2 | cut -d'.' -f1`

    cmd=$(printf 'ln -s %s %s.%s' $f $outfile $ext)
    echo $cmd
    `$cmd`
done
