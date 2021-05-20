#!/bin/bash
# Adapted from https://github.com/facebookresearch/MIXER/blob/master/prepareData.sh
# Whole repo: https://github.com/stevezheng23/fairseq_extension

cd fairseq_extension

if [ ! -d mosesdecoder ]; then
  echo 'Cloning Moses github repository (for tokenization scripts)...'
  git clone https://github.com/moses-smt/mosesdecoder.git
fi

if [ ! -d subword-nmt ]; then
  echo 'Cloning Subword NMT repository (for BPE pre-processing)...'
  git clone https://github.com/rsennrich/subword-nmt.git
fi

cd ..

SCRIPTS=fairseq_extension/mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
REM_NON_PRINT_CHAR=$SCRIPTS/tokenizer/remove-non-printing-char.perl
BPEROOT=fairseq_extension/subword-nmt/subword_nmt
BPE_TOKENS=40000


#English - slovenian

CORPORA=(
          "asistent_testset"
)

if [ ! -d "$SCRIPTS" ]; then
    echo "Please set SCRIPTS variable correctly to point to Moses scripts."
    exit
fi

src=en
tgt=sl
lang=en-sl
prep=data/datasets-asistent
tmp=$prep/tmp
orig=data/asistent-testset

mkdir -p $tmp $prep

echo "pre-processing train data..."
for l in $src $tgt; do
    rm $tmp/train.tags.$lang.tok.$l
    for f in "${CORPORA[@]}"; do
        cat $orig/$f.$l | \
            perl $NORM_PUNC $l | \
            perl $REM_NON_PRINT_CHAR | \
            perl $TOKENIZER -threads 8 -a -l $l >> $tmp/train.tags.$lang.tok.$l
    done
done


TRAIN=$tmp/train.en-sl
BPE_CODE=data/datasets/code
rm -f $TRAIN
for l in $src $tgt; do
    cat $tmp/train.tags.en-sl.tok.$l >> $TRAIN
done

#echo "learn_bpe.py on ${TRAIN}..."
#python3 $BPEROOT/learn_bpe.py -s $BPE_TOKENS < $TRAIN > $BPE_CODE

for L in $src $tgt; do
	echo "apply_bpe.py to train.${L}..."
	python3 $BPEROOT/apply_bpe.py -c $BPE_CODE < $tmp/train.tags.en-sl.tok.$L > $prep/train.$L
done

echo "binarize"
bash "scripts"/binarize_asistent.sh