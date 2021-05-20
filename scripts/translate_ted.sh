#!/bin/bash

CHECKPOINTS=results/general
BIN=data/data-binarized-ted
RESULTS=data/translated-ted
mkdir -p $RESULTS

for i in {1..8};
	do echo "Evaluating checkpoint $i for general model"
	fairseq-generate $BIN \
		--path $CHECKPOINTS/checkpoint$i.pt \
		--batch-size 128 --beam 5 \
		--gen-subset valid --remove-bpe \
		--results-path $RESULTS/results$i
done

CHECKPOINTS=results/ted

for i in {1..3}; 
	do echo "Evaluating checkpoint conf $i for domain model"; \
	fairseq-generate $BIN \
    --path $CHECKPOINTS/checkpoint_best_conf$i.pt \
    --batch-size 128 --beam 5 \
    --gen-subset train --remove-bpe \
    --results-path $RESULTS/results_ted_conf$i; \
done