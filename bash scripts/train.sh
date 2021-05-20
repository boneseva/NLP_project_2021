RESULT=results/general
mkdir -p results/general
BIN=data/data-binarized

# -m torch.distributed.launch --nproc_per_node=2
CUDA_VISIBLE_DEVICES=0,1 python3 -m torch.distributed.launch --nproc_per_node=1 fairseq_extension/fairseq_cli/train.py $BIN \
    --arch transformer \
    --reset-optimizer \
    --optimizer adam \
    --adam-betas '(0.9, 0.98)' \
    --adam-eps 1e-9 \
    --clip-norm 0.0 \
    --fp16 \
    --augmentation \
    --augmentation_schema cut_off \
    --augmentation_masking_schema word \
    --augmentation_masking_probability 0.05 \
    --augmentation_replacing_schema mask \
    --criterion label_smoothed_cross_entropy_with_regularization \
    --weight-decay 0.0001 \
    --label-smoothing 0.1 \
    --max-tokens 8000 \
    --dropout 0.3 \
    --attention-dropout 0.1 \
    --activation-dropout 0.1 \
    --lr-scheduler inverse_sqrt \
    --lr 0.001 \
    --warmup-updates 6000 \
    --max-epoch 10 \
    --update-freq 1 \
    --ddp-backend=c10d \
    --keep-last-epochs 10 \
    --log-format tqdm \
    --log-interval 10 \
    --save-dir $RESULT \
    --distributed-world-size 2