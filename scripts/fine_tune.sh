RESULT= results/ted
mkdir -p results/ted
BIN= data/data-binarized-ted
MODEL= results/general/checkpoint_best.pt

# -m torch.distributed.launch --nproc_per_node=2
CUDA_VISIBLE_DEVICES=0,1 python3 -m torch.distributed.launch --nproc_per_node=1 fairseq_extension/fairseq_cli/train.py $BIN \
    --arch transformer \
    --optimizer adam \
    --finetune-from-model $MODEL \
    --adam-betas '(0.9, 0.98)' \
    --adam-eps 1e-9 \
    --clip-norm 0.0 \
    --augmentation \
    --augmentation_schema cut_off \
    --augmentation_masking_schema word \
    --augmentation_masking_probability 0.05 \
    --augmentation_replacing_schema mask \
    --fp16 \
    --criterion label_smoothed_cross_entropy_with_regularization \
    --weight-decay 0.0001 \
    --label-smoothing 0.1 \
    --max-tokens 8000 \
    --dropout 0.3 \
    --attention-dropout 0.1 \
    --activation-dropout 0.1 \
    --lr-scheduler inverse_sqrt \
    --lr 1e-6 \
    --warmup-updates 6000 \
    --max-epoch 100 \
    --update-freq 1 \
    --ddp-backend=c10d \
    --keep-last-epochs 10 \
    --log-format tqdm \
    --log-interval 10 \
    --save-dir $RESULT