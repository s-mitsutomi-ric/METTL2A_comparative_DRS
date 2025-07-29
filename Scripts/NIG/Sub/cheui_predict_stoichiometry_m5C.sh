#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=32G -l mem_req=32G
#$ -N cheui_predict_stoichiometry

sample=$1

# Parameters ----------------------------------------------------------------------------

input_dir='CHEUI/Predict_m5C_model1/'
input=${input_dir}${sample}'_sorted.tsv.gz'

dl_model='/home/mitsutomi/Softwares/CHEUI/CHEUI_trained_models/CHEUI_m5C_model2.h5'

outdir='CHEUI/Predict_m5C_stoichiometry/'
mkdir -p $outdir
output=${outdir}${sample}'.tsv.gz'

cheui_path='/home/mitsutomi/Softwares/CHEUI/scripts/CHEUI_predict_model2_gz.py'

# CHEUI_predict_model2 -------------------------------------------------------------------

conda activate cheui

python ${cheui_path} \
    -i ${input} -m ${dl_model} -o ${output}
    
conda deactivate 
