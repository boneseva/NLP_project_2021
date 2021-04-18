DATA=europarl_sl-en
BIN=data-binarized/europarl_sl

#python3 fairseq_cli/preprocess.py \
fairseq-preprocess \
  --source-lang sl --target-lang en \
  --trainpref $DATA/train --validpref $DATA/valid \
  --destdir $BIN --thresholdtgt 0 --thresholdsrc 0 \
  --workers 20
