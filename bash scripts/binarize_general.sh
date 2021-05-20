#!/bin/bash

DATA= data/datasets
BIN= data/data-binarized

python3 fairseq_extension/fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train --validpref $DATA/valid \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20