#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=32G -l mem_req=32G
#$ -N cheui_predict_m5C

sample=$1

# Parameters ----------------------------------------------------------------------------

input_dir='CHEUI/Preprocess_m5C/'
input=${input_dir}${sample}'/'${sample}'.ts_signals+IDS.p'

trained_model='/home/mitsutomi/Softwares/CHEUI/CHEUI_trained_models/CHEUI_m5C_model1.h5'
label=${sample}

outdir='CHEUI/Predict_m5C_model1/'
mkdir -p $outdir
output=${outdir}${sample}'.tsv.gz'

cheui_path='/home/mitsutomi/Softwares/CHEUI/scripts/CHEUI_predict_model1_gz.py'

# CHEUI_predict_model1 -------------------------------------------------------------------

conda activate cheui

python ${cheui_path} \
    -i ${input} -m ${trained_model} -l ${label} -o ${output}
    
conda deactivate 
