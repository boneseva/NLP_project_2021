#!/bin/bash
cd ..

#DATA=data/datasets
#BIN=data/data-binarized/datasets_en-sl

DATA=data/datasets-ted
BIN=data/data-binarized-ted/datasets_en-sl

python3 fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train --validpref $DATA/valid \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20 --joined-dictionary