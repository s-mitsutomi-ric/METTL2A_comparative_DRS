#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -l short
#$ -l mem_req=192G -l s_vmem=192G
#$ -e Log/SparK/20230724_dRNA-seq_tRNAs.err
#$ -o Log/SparK/20230724_dRNA-seq_tRNAs.out
#$ -N plot_SparK

outdir='SparK/dRNA-seq/tRNAs/'
mkdir -p $outdir

count_running_jobs() {
    jobs -r | wc -l
}

conda activate SparK

for record in $(grep 'tRNA' Database/gencode.v43.annotation_plus-tRNA.tsv | \
                awk '$3=="gene" {print $15"_"$1":"$4"-"$5}'); do

    while (( $(count_running_jobs) >= 48 )); do
        sleep 1s
    done

    position=$(cut -d'_' -f3 <<<${record})
    bash Scripts/Sub/plot_SparK_dRNA-seq.sh $position $record $outdir &

done

wait

conda deactivate
