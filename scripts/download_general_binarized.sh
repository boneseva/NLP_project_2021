#!/bin/bash

DIR=data/data-binarized
mkdir -p $DIR
cd $DIR

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1ochxd0Uk52VNWjOpbXMNJtxcG7gi1Dg8' -O general_binarized.zip

unzip general_binarized.zip
rm general_binarized.zip

cd ../..
