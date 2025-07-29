#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N download_ena_fastq

err=$1
dstdir=$2

mkdir -p $dstdir

ftpbase='http://ftp.sra.ebi.ac.uk/vol1/fastq/'
ftp_address=${ftpbase}${err:0:6}'/00'${err: -1:1}'/'$err'/'$err'.fastq.gz'
wget -P $dstdir $ftp_address
