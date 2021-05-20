#!/bin/bash

DATA=data/datasets-ted
BIN=data/data-binarized-ted/datasets_en-sl
TDICT=data/data-binarized/dict.sl.txt
SDICT=data/data-binarized/dict.en.txt

python3 fairseq_extension/fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train --validpref $DATA/valid \
  --tgtdict $TDICT --srcdict $SDICT \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20