#!/bin/bash

CHECKPOINTS=results/general
BIN=data/data-binarized-ted
RESULTS=data/translated-ted
mkdir -p $RESULTS

for i in {1..8}; do
	if [ -f $CHECKPOINTS/checkpoint$i.pt ]; then
		echo "Evaluating checkpoint $i for general model"
		fairseq-generate $BIN \
			--path $CHECKPOINTS/checkpoint$i.pt \
			--batch-size 128 --beam 5 \
			--gen-subset valid --remove-bpe \
			--results-path $RESULTS/results$i
	fi
done

CHECKPOINTS=results/ted

for i in {1..3}; do
    if [ -f $CHECKPOINTS/checkpoint_best_conf$i.pt ]; then
		echo "Evaluating checkpoint conf $i for domain model"; \
		fairseq-generate $BIN \
		--path $CHECKPOINTS/checkpoint_best_conf$i.pt \
		--batch-size 128 --beam 5 \
		--gen-subset train --remove-bpe \
		--results-path $RESULTS/results_ted_conf$i; 
	fi
done