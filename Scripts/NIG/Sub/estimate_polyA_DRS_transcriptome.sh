#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=16G -l mem_req=16G
#$ -N nanopolish_polya

# e.g.) sample='221117_DrTaniue_7_siMETTL2A_I_N1'
sample=$1

# Nanopolish options

export HDF5_PLUGIN_PATH='/usr/local/hdf5/lib/plugin'
nanopolish_image='/usr/local/biotools/n/nanopolish:0.14.0--hd7c1219_0'

# parameter
numthread=128
fastq='Longread_ConcatenatedFastq/'${sample}'.fastq'
sortedbam='Alignment/Minimap2/Espresso_unspliced/'${sample}'.bam'
reffasta='Espresso/Espresso_Q/sample_info_N2_R0_updated.fasta'

# output of nanopolish polya
outdir='Nanopolish/PolyA/'
mkdir -p $outdir
outtsv=${outdir}${sample}'_polyA_results.tsv'

# nanopolish polya
singularity exec $nanopolish_image nanopolish polya \
 --threads ${numthread} \
 --reads ${fastq} --bam ${sortedbam} --genome ${reffasta} \
 > $outtsv
