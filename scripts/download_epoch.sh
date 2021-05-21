#!/bin/bash

DIR=results/general
mkdir -p $DIR
cd $DIR

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=18AyzttDn9_cOnd0uxuyYrMSCVKN9B9rL' -O checkpoint_best.pt

cd ../..
