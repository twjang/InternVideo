export MASTER_PORT=$((12000 + $RANDOM % 20000))
export OMP_NUM_THREADS=1

JOB_NAME='6B_lp_k400_f16'
OUTPUT_DIR="$(dirname $0)/$JOB_NAME"
LOG_DIR="./logs/${JOB_NAME}"
PREFIX='your_data_path/k400'
DATA_PATH='your_data_path/k400'
MODEL_PATH='your_model_path/6B_pt.pth'

PARTITION='video'
GPUS=16
GPUS_PER_NODE=8
CPUS_PER_TASK=16

srun -p $PARTITION \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    python run_linear_probing.py \
    --model vit_6B_patch14_224 \
    --data_path ${DATA_PATH} \
    --prefix ${PREFIX} \
    --data_set 'Kinetics_sparse' \
    --split ',' \
    --nb_classes 400 \
    --finetune ${MODEL_PATH} \
    --log_dir ${OUTPUT_DIR} \
    --output_dir ${OUTPUT_DIR} \
    --steps_per_print 10 \
    --batch_size 64 \
    --num_sample 1 \
    --input_size 224 \
    --short_side_size 224 \
    --save_ckpt_freq 100 \
    --num_frames 16 \
    --num_workers 12 \
    --warmup_epochs 2 \
    --tubelet_size 1 \
    --epochs 9 \
    --lr 5e-4 \
    --min_lr 0 \
    --drop_path 0.0 \
    --layer_decay 1.0 \
    --layer_scale_init_value 1e-5 \
    --aa rand-m5-n2-mstd0.25-inc1 \
    --opt adamw \
    --opt_betas 0.9 0.999 \
    --weight_decay 0 \
    --test_num_segment 1 \
    --test_num_crop 3 \
    --dist_eval \
    --enable_deepspeed \
    --bf16 \
    --zero_stage 1 \
    --log_dir ${OUTPUT_DIR} \
    --output_dir ${OUTPUT_DIR} \
    --test_best
    