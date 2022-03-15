#!/usr/bin/env bash
#
# --kore-from-path will take the Haskell Backend
#      from the $PATH (as opposed to taking
#      the Haskell Backend in the K package)
#

KOMPILE=`which kompile`
BIN=`dirname $KOMPILE`
RELEASE=`dirname $BIN`

mkdir k

cp -r $RELEASE/* k

# rm -r k/share/kframework/tutorial
rm -r k/share/kframework/pl-tutorial

if [ "$1" == "--kore-from-path" ]
then
  KORE_BIN=$(dirname $(which kore-repl))
  cp $KORE_BIN/kore-* k/bin
fi
