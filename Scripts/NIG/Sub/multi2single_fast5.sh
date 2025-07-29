#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=32G -l mem_req=32G
#$ -N multi2single

sample=$1
input_dir='Rawdata/Nanopore_directRNAseq/'${sample}'/fast5_pass'
save_path='Single_fast5/'${sample}
num_threads=24

conda activate ont-fast5-api

multi_to_single_fast5 -i ${input_dir} -s ${save_path} -t $num_threads

conda deactivate 
