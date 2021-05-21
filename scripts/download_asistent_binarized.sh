#!/bin/bash

DIR=data/data-binarized-asistent
mkdir -p $DIR
cd $DIR

if [ -f data/data-binarized-asistent/dict.en.txt ]; then

  wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1XlN7mabhTT5W--bVhE7Up14gwQVkRV87' -O asistent_binarized.zip

  unzip asistent_binarized.zip
  rm asistent_binarized.zip

fi

cd ../..
