#!/bin/bash
# Adapted from https://github.com/facebookresearch/MIXER/blob/master/prepareData.sh
# Whole repo: https://github.com/stevezheng23/fairseq_extension

cd ..

# echo 'Cloning Moses github repository (for tokenization scripts)...'
# git clone https://github.com/moses-smt/mosesdecoder.git

# echo 'Cloning Subword NMT repository (for BPE pre-processing)...'
# git clone https://github.com/rsennrich/subword-nmt.git

SCRIPTS=mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
REM_NON_PRINT_CHAR=$SCRIPTS/tokenizer/remove-non-printing-char.perl
BPEROOT=subword-nmt/subword_nmt
BPE_TOKENS=40000


#English - slovenian

CORPORA=(
          "Europarl.en-sl"
          "CCAligned.en-sl"
          "DGT.en-sl"
          "MultiCCAligned.en-sl"
          "OpenSubtitles.en-sl"
          "TildeMODEL.en-sl"
          "WikiMatrix.en-sl"
          "wikimedia.en-sl"
          "XLEnt.en-sl"
)
# move original files from https://drive.google.com/drive/folders/1aBGSStOfSCwsCwbblGIVOGMD1_FDRa1S?usp=sharing in data-original

if [ ! -d "$SCRIPTS" ]; then
    echo "Please set SCRIPTS variable correctly to point to Moses scripts."
    exit
fi

src=en
tgt=sl
lang=en-sl
prep=data/datasets
tmp=$prep/tmp
orig=data/data-original

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

echo "splitting train and valid..."
# every 5000th line
for l in $src $tgt; do
	shuf $tmp/train.tags.$lang.tok.$l > $tmp/tmp.$l
	head -n 5000 $tmp/tmp.$l > $tmp/valid.$l
	tail -n +5000 $tmp/tmp.$l > $tmp/train.$l
	rm $tmp/tmp.$l
done


TRAIN=$tmp/train.en-sl
BPE_CODE=$prep/code
rm -f $TRAIN
for l in $src $tgt; do
    cat $tmp/train.$l >> $TRAIN
done

echo "learn_bpe.py on ${TRAIN}..."
python3 $BPEROOT/learn_bpe.py -s $BPE_TOKENS < $TRAIN > $BPE_CODE

for L in $src $tgt; do
#    for f in train.$L valid.$L test.$L; do
    for f in train.$L valid.$L; do
        echo "apply_bpe.py to ${f}..."
        python3 $BPEROOT/apply_bpe.py -c $BPE_CODE < $tmp/$f > $tmp/bpe.$f
    done
done

# remove empty lines
# removes redundant space characters
# drops lines (and their corresponding lines), that are empty, too short or too long
perl $CLEAN -ratio 5 $tmp/bpe.train $src $tgt $prep/train 1 250
perl $CLEAN -ratio 5 $tmp/bpe.valid $src $tgt $prep/valid 1 250