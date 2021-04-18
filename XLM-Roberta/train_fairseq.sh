TOTAL_NUM_UPDATES=2036  # 10 epochs through RTE for bsz 16
WARMUP_UPDATES=122      # 6 percent of the number of updates
LR=2e-05                # Peak LR for polynomial LR scheduler.
MAX_SENTENCES=16        # Batch size.
ROBERTA_PATH=xlmr.large/model.pt
DATA_DIR=data

CUDA_VISIBLE_DEVICES=0 fairseq-train $DATA_DIR \
    --finetune-from-model $ROBERTA_PATH \
    --batch-size $MAX_SENTENCES \
    --max-tokens 4400 \
    --max-positions 512 \
    --source-lang en --target-lang sl \
    --task translation \
    --required-batch-size-multiple 1 \
    --arch roberta_large \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.1 --optimizer adam --adam-betas "(0.9, 0.98)" --adam-eps 1e-06 \
    --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $LR --total-num-update $TOTAL_NUM_UPDATES --warmup-updates $WARMUP_UPDATES \
    --fp16 --fp16-init-scale 4 --threshold-loss-scale 1 --fp16-scale-window 128 \
    --max-epoch 10 \
    --find-unused-parameters \
    --save-interval 10 \
    --best-checkpoint-metric accuracy --maximize-best-checkpoint-metric;