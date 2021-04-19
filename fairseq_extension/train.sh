RESULT=results/europarl_sl-en
mkdir results/europarl_sl-en
BIN=data-binarized/europarl_sl

CUDA_VISIBLE_DEVICES=0 python3 -m torch.distributed.launch --nproc_per_node=4 \
    fairseq_cli/train.py $BIN \
    --arch transformer_iwslt_de_en \
    --augmentation \
    --augmentation_schema cut_off \
    --augmentation_masking_schema word \
    --augmentation_masking_probability 0.05 \
    --augmentation_replacing_schema mask \
    --share-all-embeddings \
    --optimizer adam \
    --adam-betas '(0.9, 0.98)' \
    --adam-eps 1e-9 \
    --clip-norm 0.0 \
    --criterion label_smoothed_cross_entropy \
    --weight-decay 0.0001 \
    --regularization_weight 5.0 \
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
    --distributed-world-size 4 \
    --ddp-backend=c10d \
    --keep-last-epochs 20 \
    --log-format tqdm \
    --log-interval 100 \
    --save-dir $RESULT \
    --seed 40199672