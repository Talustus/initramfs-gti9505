#!/bin/bash

for i in `cat symlinks`
do
  ln -s busybox $i
done
