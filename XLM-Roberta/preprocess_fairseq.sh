DATA_DIR=data
ROBERTA_PATH=xlmr.large

CUDA_VISIBLE_DEVICES=0 fairseq-preprocess \
    --tokenizer moses \
    --bpe sentencepiece \
    --source-lang en --target-lang sl \
    --task translation \
    --srcdict $ROBERTA_PATH/dict.txt \
    --trainpref $DATA_DIR/train \
    --destdir $DATA_DIR;