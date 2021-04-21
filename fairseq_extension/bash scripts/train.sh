RESULT=results/en-sl
mkdir results/en-sl
BIN=data-binarized/datasets_en-sl

# CUDA_VISIBLE_DEVICES=0 
# python -m torch.distributed.launch --nproc_per_node=4 \
python fairseq_cli/train.py $BIN \
    --arch transformer \
    --share-all-embeddings \
    --optimizer adam \
    --adam-betas '(0.9, 0.98)' \
    --adam-eps 1e-9 \
    --clip-norm 0.0 \
    --augmentation \
    --augmentation_schema cut_off \
    --augmentation_masking_schema word \
    --augmentation_masking_probability 0.05 \
    --augmentation_replacing_schema mask \
    --criterion label_smoothed_cross_entropy_with_regularization \
    --weight-decay 0.0001 \
    --label-smoothing 0.1 \
    --max-tokens 2048 \
    --dropout 0.3 \
    --attention-dropout 0.1 \
    --activation-dropout 0.1 \
    --lr-scheduler inverse_sqrt \
    --lr 7e-4 \
    --warmup-updates 6000 \
    --max-epoch 100 \
    --update-freq 1 \
 #   --distributed-world-size 4 \
    --ddp-backend=c10d \
    --keep-last-epochs 20 \
    --log-format tqdm \
    --log-interval 100 \
    --save-dir $RESULT \
    --seed 40199672
