#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                type = 'character',
                help = 'input bed file'),
    make_option(c('--output', '-o'),
                type = 'character',
                help = 'output bed file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

# read bed12 format file
read_bed12 <- function(path) {
  
  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )
  
  read_tsv(path, col_names = bed12_colnames, 
           col_types = 'cddcdcddcdcc',
           show_col_types = F) 
  
}


bed6_cleavage_sites <- 
  read_bed12(opts$input) |> 
  dplyr::select(chrom:strand) |> 
  #
  # https://onlinelibrary.wiley.com/doi/full/10.1002/anie.201810946
  # the beginning of Read1 corresponds to the N+1 nucleotide 
  # deprotected by decomposition of abasic site
  # 
  # + strand -> 
  #     start -> start - 1
  #     end   -> start
  # - strand ->
  #     start -> end
  #     end   -> end + 1
  #
  mutate(
    newstart = case_when(
      strand == '+' ~ start - 1,
      strand == '-' ~ end,
      .default = NA
    ),
    newend   = case_when(
      strand == '+' ~ start,
      strand == '-' ~ end + 1,
      .default = NA
    )
  ) |> 
  select(chrom, newstart, newend, name, score, strand)

bed6_cleavage_sites |>
  write_tsv(opts$output, col_names = FALSE)
