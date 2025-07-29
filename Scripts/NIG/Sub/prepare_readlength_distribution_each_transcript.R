#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(tidyr)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                type = 'character',
                help = 'input (*_uniq_geneinfoplus.bed)'),
        make_option(c('--output', '-o'),
                type = 'character',
                help = 'output tsv file'),
        make_option(c('--ref', '-r'),
                type = 'character',
                help = 'tsv file having information about transcript id, name and type')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

blockSizes2length <- function(blockSizes) {
  
  str_split(blockSizes, ',', simplify = TRUE)[1,] |>
    as.numeric() |>
    sum(na.rm = TRUE)
  
}

# Read readlength data of reads overlapping with one feature (not multiple features)
read_uniqannotation_readlength <- function(path) {
  
  read_bed12(path, col_select = c(name, blockSizes)) |> 
    separate(name, into = c('read_id', 'transcript_id'), sep = '[|]') |> 
    group_by(read_id) |> 
    filter(n() == 1) |> 
    filter(transcript_id != '.') |> 
  ungroup() 
  
}

count_numread_perlength <- function(df) {
  
  df |> 
    group_by(transcript_id, blockSizes) |> 
    reframe(n = n()) |>  
    rowwise() |> 
    mutate(readlength = blockSizes2length(blockSizes)) |> 
    select(transcript_id, readlength, n)
  
}

read_bed12 <- function(path, ...) {
  
  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )
  
  readr::read_tsv(
    path, col_names = bed12_colnames,
    col_types =  'cddcdcddcdcc', show_col_types = F, ...)
  
}

annotation <- read_tsv(opts$ref) |> 
  filter(primary_tag == 'transcript') |> 
  select(transcript_id, transcript_name, transcript_type)

read_uniqannotation_readlength(opts$input) |> 
  count_numread_perlength() |> 
  left_join(annotation, by = join_by(transcript_id)) |> 
  select(starts_with('transcript_'), readlength, n) |> 
  write_tsv(opts$output)
