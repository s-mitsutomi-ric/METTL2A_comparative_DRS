#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Memechip/Get_bg/'$today'/'
mkdir -p $logdir

err=${logdir}'Espresso_AsPC1.transcripts.err'
out=${err/.err/.out}

input='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'
order=2
markovbg=${input/.fasta/_markovbg_order_}${order}'.txt'

qsub -e $err -o $out Scripts/Sub/get_markov_bg4meme.sh \
    $input $markovbg $order
