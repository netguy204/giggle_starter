#!/usr/bin/env bash

OUTDIR=$1
if [ "$OUTDIR" == "" ]; then
    echo "usage: $0 output_dir [start server]"
    exit 1
fi

if [ -d $OUTDIR ]; then
    rm -rf $OUTDIR
fi

mkdir $OUTDIR
cp preload.js assets.dat $OUTDIR
cp giggle/engine/main.js $OUTDIR
cp giggle/engine/index.html $OUTDIR

if [ "$2" != "" ]; then
    cd $OUTDIR ; python -m SimpleHTTPServer
fi
