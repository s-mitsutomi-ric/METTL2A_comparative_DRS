#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N tombo_m5C

tombo_image='/home/mitsutomi/DockerImage/tombo.sif'

samplename=$1

fast5_basedir='Rawdata/Nanopore_directRNAseq/'${samplename}'/fast5_pass/'

outdir='Tombo/Modifications/m5C/'${samplename}'/'
mkdir -p ${outdir}

stat_file_basename=${outdir}'stat'
perread_stat_basename=${outdir}'stat'

min_read=1 # default 1
num_most_sig_stored=100000 # default 100000
mp_region_size=10000 # default 10000
num_processes=4 # default 1

singularity exec ${tombo_image} tombo \
    detect_modifications alternative_model \
    --fast5-basedirs ${fast5_basedir} \
    --statistics-file-basename ${stat_file_basename} \
    --alternate-bases 5mC --rna \
    --per-read-statistics-basename ${perread_stat_basename} \
    --minimum-test-reads ${min_read} \
    --num-most-significant-stored ${num_most_sig_stored} \
    --multiprocess-region-size ${mp_region_size} \
    --processes ${num_processes}
