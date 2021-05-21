#!/bin/bash

DIR=data/data-binarized-ted
mkdir -p $DIR
cd $DIR

if [ -f data/data-binarized-ted/dict.en.txt ]; then

  wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=13-QtWyDggd5QH7zbE7hBXkKvhMaumXvV' -O ted_binarized.zip

  unzip ted_binarized.zip
  rm ted_binarized.zip
fi

cd ../..
