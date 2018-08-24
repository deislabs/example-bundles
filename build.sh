#!/bin/sh

for dir in $(ls -1); do
  if [[ -e $dir/cnab/bundle.json ]]; then
    cp $dir/cnab/bundle.json bundles/$dir.json
  fi
done
