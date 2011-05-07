#!/bin/sh
set -x
rm -f ~/.emacs
ln  -sf `pwd`/.emacs ~/.emacs
rm -rf ~/etc
ln  -sf `pwd`/etc ~/etc
