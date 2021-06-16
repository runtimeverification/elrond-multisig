#!/usr/bin/env bash

KOMPILE=`which kompile`
BIN=`dirname $KOMPILE`
RELEASE=`dirname $BIN`

mkdir k

cp -r $RELEASE/* k

rm -r k/share/kframework/tutorial
rm -r k/share/kframework/pl-tutorial
