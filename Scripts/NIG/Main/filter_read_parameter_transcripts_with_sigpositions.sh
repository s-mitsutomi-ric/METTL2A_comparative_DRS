#!/bin/bash
set -e
set -u
set -o pipefail

for sample in $(cat Lists/longread_samples.list ) ; do 

    echo $sample
    prefix=$sample'_'

    input='Nanocompore/Espresso/Eventalign_collapse/'$sample'/out_eventalign_collapse.tsv'
    bash Scripts/Sub/filter_read_parameter_each_transcripts.sh $input $prefix
    sleep 5s

done
