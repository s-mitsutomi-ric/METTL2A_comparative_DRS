#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -l short
#$ -l mem_req=192G -l s_vmem=192G
#$ -e Log/SparK/20230724_dRNA-seq_FTs.err
#$ -o Log/SparK/20230724_dRNA-seq_FTs.out
#$ -N plot_SparK

outdir='SparK/dRNA-seq/FTs/'
mkdir -p $outdir

count_running_jobs() {
    jobs -r | wc -l
}

conda activate SparK

for record in $(awk '$3=="gene" {print $14"_"$1":"$4"-"$5}' Database/gencode.v43.annotation.tsv | \
                grep '^FT'); do

    while (( $(count_running_jobs) >= 48 )); do
        sleep 1s
    done

    position=$(cut -d'_' -f2 <<<${record})
    bash Scripts/Sub/plot_SparK_dRNA-seq.sh $position $record $outdir &

done

wait

conda deactivate
