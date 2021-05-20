#!/bin/bash

DATA=data/datasets-asistent
BIN=data/data-binarized-asistent
DICTS=data/data-binarized

python3 fairseq_extension/fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train \
  --tgtdict $DICTS/dict.sl.txt --srcdict $DICTS/dict.en.txt \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20