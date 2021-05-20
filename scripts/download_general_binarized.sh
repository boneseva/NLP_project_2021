#!/bin/bash

DIR=data/data-binarized
mkdir -p $DIR
cd $DIR

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1SvRui0Did2NL_ssSXBVzkhAAq7OokxQj' -O general_binarized.zip

unzip general_binarized.zip
rm general_binarized.zip

cd ../..
