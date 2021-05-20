#!/bin/bash

DIR=data/data-original-ted
mkdir -p $DIR
cd $DIR

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1hIODDj_TbyfDa0o5ouMmzh42ZSmYm7PD' -O train_valid.zip

unzip train_valid.zip
rm train_valid.zip

cd ../..
