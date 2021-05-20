#!/bin/bash

cd ..

RESULT=results/en-sl
BIN=data/data-binarized/datasets_en-sl

python3 fairseq_cli/generate.py $BIN/valid.en-sl.en.bin \
    --path $RESULT/checkpoint_best.pt \
    --batch-size 128 --beam 5