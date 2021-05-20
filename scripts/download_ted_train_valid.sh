#!/bin/bash

DIR=data/data-original-ted
mkdir -p $DIR
cd $DIR

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=14_Q1I5jF3AscHMvkGhAyDeYWTCaY_QXy' -O train_valid.zip

unzip train_valid.zip
rm train_valid.zip

cd ../..
