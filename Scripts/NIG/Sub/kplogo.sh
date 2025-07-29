#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N kpLogo

while getopts iob: option
do
    case $option in
        i)
            input=$OPTARG;;
        o)
            outprefix=$OPTARG;;
        b)
            background=$OPTARG;;
        \?)
            exit 1
    esac
done

kpLogo $input -o $outprefix -colorblind -bgfile $background
