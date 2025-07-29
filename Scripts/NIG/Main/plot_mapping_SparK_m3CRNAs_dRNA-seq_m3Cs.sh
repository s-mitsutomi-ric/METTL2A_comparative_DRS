#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -l short
#$ -l mem_req=192G -l s_vmem=192G
#$ -e Log/SparK/20240531_dRNA-seq_m3CRNAs.err
#$ -o Log/SparK/20240531_dRNA-seq_m3CRNAs.out
#$ -N plot_SparK

outdir='SparK/dRNA-seq_m3Csites/m3CRNAs/'
mkdir -p $outdir

count_running_jobs() {
    jobs -r | wc -l
}

conda activate SparK

for record in $(awk '$3=="gene" {print $14"_"$1":"$4"-"$5}' Database/gencode.v43.annotation_m3CRNAs.tsv ); do

    while (( $(count_running_jobs) >= 48 )); do
        sleep 1s
    done

    position=$(cut -d'_' -f2 <<<${record})
    bash Scripts/Sub/plot_SparK_dRNA-seq_withm3Csites.sh $position $record $outdir &

done

wait

conda deactivate
