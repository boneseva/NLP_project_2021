#!/bin/bash
# Adapted from https://github.com/facebookresearch/MIXER/blob/master/prepareData.sh
# Whole repo: https://github.com/stevezheng23/fairseq_extension

cd fairseq_extension

echo 'Cloning Moses github repository (for tokenization scripts)...'
git clone https://github.com/moses-smt/mosesdecoder.git

echo 'Cloning Subword NMT repository (for BPE pre-processing)...'
git clone https://github.com/rsennrich/subword-nmt.git


SCRIPTS=mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
REM_NON_PRINT_CHAR=$SCRIPTS/tokenizer/remove-non-printing-char.perl
BPEROOT=subword-nmt/subword_nmt
BPE_TOKENS=40000


#English - slovenian

#CORPORA=(
#          "TED2013"
#          "TED2019_1"
#          "TED2019_2"
#          "TED2019_3"
#          "TED2019_4"
#          "TED2019_5"
#          "TED2019_6"
#          "TED2019_7"
#          "TED2019_8"
#          "TED2019_9"
#          "TED2019_10"
#          "TED2018_11"
#          "TED2018_12"
#          "TED2018_13"
#          "TED2018_14"
#          "TED2018_15"
#          "TED2020"
#)
CORPORA=("train")
CORPORAV=("valid")
# move original files from https://drive.google.com/drive/folders/1aBGSStOfSCwsCwbblGIVOGMD1_FDRa1S?usp=sharing in data-original

if [ ! -d "$SCRIPTS" ]; then
    echo "Please set SCRIPTS variable correctly to point to Moses scripts."
    exit
fi

src=en
tgt=sl
lang=en-sl
prep=data/datasets-ted
tmp=$prep/tmp
orig=data/data-original-ted

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

echo "pre-processing valid data..."
for l in $src $tgt; do
    rm $tmp/valid.tags.$lang.tok.$l
    for f in "${CORPORAV[@]}"; do
        cat $orig/$f.$l | \
            perl $NORM_PUNC $l | \
            perl $REM_NON_PRINT_CHAR | \
            perl $TOKENIZER -threads 8 -a -l $l >> $tmp/valid.tags.$lang.tok.$l
    done
done

perl $CLEAN -ratio 5 $tmp/train.tags.$lang.tok $src $tgt $tmp/train-cleaned.tags.$lang.tok 2 250
perl $CLEAN -ratio 5 $tmp/valid.tags.$lang.tok $src $tgt $tmp/valid-cleaned.tags.$lang.tok 2 250

python3 "scripts"/split.py $lang 'ted' 0

TRAIN=$tmp/train.en-sl
VALID=$tmp/valid.en-sl
BPE_CODE=data/datasets/code
rm -f $TRAIN
rm -f $VALID
for l in $src $tgt; do
    cat $tmp/train.$l >> $TRAIN
    cat $tmp/valid.$l >> $VALID
done

#echo "learn_bpe.py on ${TRAIN}..."
#python3 $BPEROOT/learn_bpe.py -s $BPE_TOKENS < $TRAIN > $BPE_CODE

for L in $src $tgt; do
#    for f in train.$L valid.$L test.$L; do
    for f in train.$L valid.$L; do
        echo "apply_bpe.py to ${f}..."
        python3 $BPEROOT/apply_bpe.py -c $BPE_CODE < $tmp/$f > $prep/$f
    done
done

echo "binarize"
bash "scripts"/binarize_ted.sh
