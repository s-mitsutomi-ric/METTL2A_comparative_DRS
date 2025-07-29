#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=64G -l mem_req=64G
#$ -N cheui_preprocess_m5C

input_nanopolish=$1
outdir=$2

kmer_model='/home/mitsutomi/Softwares/CHEUI/kmer_models/model_kmer.csv'
num_cores=32

cheui_path='/home/mitsutomi/Softwares/CHEUI/scripts/CHEUI_preprocess_m5C_gz.py'

conda activate cheui

python ${cheui_path} \
    -i ${input_nanopolish} -m ${kmer_model} \
    -o ${outdir} -n ${num_cores}
    
conda deactivate 
