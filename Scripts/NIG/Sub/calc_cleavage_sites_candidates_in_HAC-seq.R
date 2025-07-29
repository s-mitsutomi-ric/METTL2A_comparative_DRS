#!/usr/local/bin/R

library(dplyr)
library(readr)
library(tidyr)
library(stringr)
library(optparse)

# convert position in genome to that in transcriptome
convert_position_genome2transcriptome <- function(
    query, sizes, starts, block_counts, tr_start, strand,
    val_upstream = NA, val_downstream = NA, val_intron = NA
    ) {
  
  if (is.na(query)) {
    return(NA)
  } 
  
  exon_num   <- 1
  exon_start <- tr_start
  position_in_tr <- 0
  
  size_list  <- str_split(sizes , ',', simplify = TRUE)[1,] |> as.numeric()
  start_list <- str_split(starts, ',', simplify = TRUE)[1,] |> as.numeric()
  
  if (size_list[block_counts] + start_list[block_counts] < query - tr_start) {
    return(val_downstream)
  } else if (query - tr_start < 0) {
    return(val_upstream)
  }
  
  while ( (size_list[exon_num]) < (query - exon_start) ) {
    
    position_in_tr <- position_in_tr + (size_list[exon_num])
    exon_num <- exon_num + 1
    exon_start <- tr_start + (start_list[exon_num])
    
  }
  
  position_in_exon <- query - exon_start
  
  if (position_in_exon < 0) position_in_exon <- val_intron
  
  position_in_tr <- position_in_tr + position_in_exon
  
  tr_length <- size_list |> sum()
  
  if (strand == "+") {
    return(position_in_tr)
  } else if (strand == "-") {
    return(tr_length - position_in_tr)
  } else {
    stop(paste('Unknown strand'))
  }
  
}

read_bed12 <- function(path) {

  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )

  readr::read_tsv(
    path, col_names = bed12_colnames,
    col_types =  'cddcdcddcdcc', show_col_types = F)

}

blockSizes2length <- function(blockSizes) {
  
  str_split(blockSizes, ',', simplify = TRUE)[1,] |> 
    as.numeric() |> 
    sum()
  
}

# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                type = 'character',
                help = 'input gtf file'),
    make_option(c('--output', '-o'),
                type = 'character',
                help = 'output gtf file'),
    make_option(c('--ref', '-r'),
                type = 'character',
                help = 'reference bed file')       

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

ref <- read_bed12(opts$ref) |> 
  rename_at(vars(-name),  ~ glue::glue('ref_{.}'))

read_bed12(opts$input)  |> 
  rename_at(vars(-name), ~ glue::glue('input_{.}')) |> 
  separate(name, into = c('read_id', 'name'), sep = '[|]') |> 
  filter(name != '.') |> 
  left_join(ref, by = join_by(name))  |> 
  filter(!is.na(ref_start)) |> 
  select(name, input_start, input_end, input_strand, 
         ref_start, ref_end, ref_strand, ref_thickStart, ref_thickEnd,
         ref_blockCount, ref_blockSizes, ref_blockStarts) |> 
  rowwise() |> 
  mutate( 
    start = convert_position_genome2transcriptome(
      input_start, ref_blockSizes, ref_blockStarts, ref_blockCount, ref_start, '+'),
    end   = convert_position_genome2transcriptome(
      input_end  , ref_blockSizes, ref_blockStarts, ref_blockCount, ref_start, '+'),
  ) |> 
  # filter reads completely mapped to transcripts
  filter(!is.na(start) & !is.na(end)) |> 
  mutate(length = blockSizes2length(ref_blockSizes)) |> 
  mutate( # convert thick start and end to transcriptome positions
    CDS_start = convert_position_genome2transcriptome(
      ref_thickStart, ref_blockSizes, ref_blockStarts, ref_blockCount, 
      ref_start, ref_strand),
    CDS_end = convert_position_genome2transcriptome(
      ref_thickEnd, ref_blockSizes, ref_blockStarts, ref_blockCount, 
      ref_start, ref_strand),
  ) |> # swap CDS_end and CDS_start if strand is -
  mutate(
    temp = min(CDS_start, CDS_end),
    CDS_end = max(CDS_start, CDS_end),
    CDS_start = temp
  ) |> 
  select(name, start, length, CDS_start, CDS_end)  |> 
  readr::write_tsv(opts$output) 
