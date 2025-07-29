#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(tidyr)
library(optparse)

# Functions -----------------------------

read_bed12 <- function(path, ...) {
  
  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )
  
  readr::read_tsv(
    path, col_names = bed12_colnames,
    col_types =  'cddcdcddcdcc', show_col_types = F, ...)
  
}

read_mapping_info <- function(bed) {
  read_bed12(bed,
             col_select = c(name)) |> 
    separate(name, sep = '[|]', into = c('read_id', 'transcript_id'))
  
}

transcript2gene <- function(df) {

  df |> 
    left_join(
      read_tsv('Database/gencode.v43.annotation_plus-tRNA.tsv') |>         
      filter(primary_tag == 'transcript') |> 
      select('transcript_id', 'gene_id')
  )
  
} 

keep_unique_overlapping_reads <- function(df) {
  
  df |> 
    group_by(read_id) |> 
    filter(n() == 1) |>  # remove multi-overlapping or multi-mapping reads
    ungroup()

}

read_readlength_info <- function(tsv) {
  
  read_tsv(tsv,
           show_col_types = FALSE,
           col_names = c('name', 'seq', 'length'), col_select = c(name, length)
  ) |> 
    separate(name, into = c('read_id', NA), sep = ' ')

}

# Parse arguments ------------------------

optslist <- list(

    make_option(c('--bed', '-b'),
                type = 'character',
                help = 'input bed file (*_uniq_geneinfoplus.bed)'),
        make_option(c('--output', '-o'),
                type = 'character',
                help = 'output tsv file'),
        make_option(c('--readlength', '-r'),
                type = 'character',
                help = 'tsv file having information about readlength (seqkit fx2tsv -l -Q output)')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

# Main --------------------------------------------------

read_mapping_info(opts$bed) |> 
  transcript2gene() |>
  select(read_id, gene_id) |> 
  distinct() |> 
  keep_unique_overlapping_reads() |> 
  left_join(read_readlength_info(opts$readlength), 
            by = join_by(read_id)) |> 
  group_by(gene_id, length) |> 
  reframe(n = n()) |> 
  write_tsv(opts$output)
