#!/bin/bash

CHECKPOINTS=results/general
BIN=data/data-binarized
RESULTS=data/translated-general
mkdir -p $RESULTS

for i in {1..8}; do
    if [ -f $CHECKPOINTS/checkpoint$i.pt ]; then
		echo "Evaluating checkpoint $i"
		fairseq-generate $BIN \
			--path $CHECKPOINTS/checkpoint$i.pt \
			--batch-size 128 --beam 5 \
			--gen-subset valid --remove-bpe \
			--results-path $RESULTS/results$i
	fi
done