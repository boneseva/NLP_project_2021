#!/bin/bash

DIR=data/data-binarized
mkdir -p $DIR
cd $DIR

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1emS5aPX-pkJPm6NsgibfO3QLq8NNJHPr' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1emS5aPX-pkJPm6NsgibfO3QLq8NNJHPr" -O general_binarized.zip && rm -rf /tmp/cookies.txt

unzip general_binarized.zip
rm general_binarized.zip

cd ../..
