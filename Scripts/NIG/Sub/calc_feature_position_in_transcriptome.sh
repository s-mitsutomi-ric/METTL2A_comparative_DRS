#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N feature_pos_genome2transcriptome

R_image='/usr/local/biotools/r/r-base:4.2.1'
script='Scripts/Sub/calc_feature_position_in_transcriptome.R'

gtf='Database/gencode.v43.annotation_plus-tRNA_CDS.gtf'
ref='Database/gencode.v43.annotation_plus-tRNA.bed'
out='Database/gencode.v43.annotation_plus-tRNA_CDS_transcriptome.bed'

singularity exec $R_image Rscript $script \
    -i $gtf -f 'CDS' -a 'transcript_id' -r $ref -o $out
