#!/bin/bash
cd ..

DATA=data/datasets-ted
BIN=data/data-binarized-ted/datasets_en-sl
TDICT=data/data-binarized/datasets_en-sl/dict.sl.txt
SDICT=data/data-binarized/datasets_en-sl/dict.en.txt

python3 fairseq_cli/preprocess.py \
  --source-lang en --target-lang sl \
  --trainpref $DATA/train --validpref $DATA/valid \
  --tgtdict $TDICT --srcdict $SDICT \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20