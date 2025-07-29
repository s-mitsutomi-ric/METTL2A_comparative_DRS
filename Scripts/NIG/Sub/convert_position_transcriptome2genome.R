#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                help = 'input bed file'),
    make_option(c('--ref'  , '-r'),
                help = 'reference bed file'),
    make_option(c('--output', '-o'),
                help = 'output bed file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

read_bed12 <- function(path) {
  
  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )
  
  read_tsv(path, col_names = bed12_colnames, 
           col_types =  'cddcdccccdcc',
           show_col_types = F) 
  
}

convert_position_transcript2genome <- function(
    query, sizes, starts, tr_start) {
  
  counter <- 1
  total_size <- 0
  
  size_list  <- str_split(sizes , ',')
  start_list <- str_split(starts, ',')
  
  while ( (total_size + as.numeric(size_list[[1]][counter])) < query ) {
    
    total_size <- total_size + as.numeric(size_list[[1]][counter])
    counter <- counter + 1
    
  }
  
  position_in_exon <- query - total_size
  
  position_in_chr <- 
    tr_start + as.numeric(start_list[[1]][counter]) + position_in_exon
  return(position_in_chr)
}

read_position_file <- function(path) {
  
  read_tsv(path, col_names = c('name', 'tr_start', 'tr_end'), col_types = 'cdd')
  
}

# Read bed files

bedfile <- 
  read_bed12(opts$ref) |> 
  select(chrom, start, end, name, score, strand, blockSizes, blockStarts) 

sig_positions <- 
  read_position_file(opts$input)

# Convert

bedfile |> 
  right_join(sig_positions, join_by(name)) |>
  rowwise() |>
  mutate(
    g_start = convert_position_transcript2genome(
      tr_start, blockSizes, blockStarts, start),
    g_end = convert_position_transcript2genome(
      tr_end, blockSizes, blockStarts, start)
  ) |>
  ungroup() |>
  mutate(
    name = paste0(name, '|', tr_end)
  ) |>
  select(chrom, g_start, g_end, name, score, strand) |>
  write_tsv(opts$output, col_names = FALSE)
