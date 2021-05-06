#!/bin/bash
cd ..

DATA=data/datasets-asistent
BIN=data/data-binarized-asistent/datasets_asistent

python3 fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20