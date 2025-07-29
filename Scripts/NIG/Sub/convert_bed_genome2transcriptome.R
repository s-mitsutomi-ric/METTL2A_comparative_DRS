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

# convert position in genome to that in transcriptome
genome2transcriptome <- function(
    query, sizes, starts, tr_start, strand) {
  
  exon_num   <- 1
  exon_start <- tr_start
  position_in_tr <- 0
  
  size_list  <- str_split(sizes , ',')
  start_list <- str_split(starts, ',')
  
  while ( as.numeric(size_list[[1]][exon_num]) < (query - exon_start) ) {
    
    position_in_tr <- position_in_tr + as.numeric(size_list[[1]][exon_num])
    exon_num <- exon_num + 1    
    exon_start <- tr_start + as.numeric(start_list[[1]][exon_num])
    
  }
  
  position_in_exon <- query - exon_start
  position_in_tr <- position_in_tr + position_in_exon
  
  tr_length <- sum(as.numeric(unlist(size_list)))
  
  if (strand == "+") {
    return(position_in_tr)
  } else if (strand == "-") {
    return(tr_length - position_in_tr)
  } else {
    stop(paste('Unknown strand'))
  }
  
}

bed12_tr <- read_bed12(opts$input) |> 
  # Replace block...  == NA
  tidyr::replace_na(list(blockCount = 1, blockStarts = '0')) |> 
  dplyr::mutate(blockSizes = ifelse(is.na(blockSizes), 
                             yes = as.character(end - start), 
                             no = blockSizes)) |> 
  dplyr::rowwise() |>
  mutate( # Convert position from genome to transcriptome
    start_tr = genome2transcriptome(
      start, blockSizes, blockStarts, start, '+'),
    end_tr   = genome2transcriptome(
      end  , blockSizes, blockStarts, start, '+'),
    thickStart_tr = ifelse(
      is.na(thickStart), thickStart, 
      genome2transcriptome(
        thickStart, blockSizes, blockStarts, start, strand)
    ),
    thickEnd_tr   = ifelse(
      is.na(thickEnd), thickEnd,
      genome2transcriptome(
        thickEnd  , blockSizes, blockStarts, start, strand)
    )
  ) |> 
  dplyr::mutate( # Flip thickEnd_tr and thickStart_tr when strand == '-'
    temp          = min(thickStart_tr, thickEnd_tr),
    thickEnd_tr   = max(thickStart_tr, thickEnd_tr),
    thickStart_tr = temp
  ) |>
  dplyr::mutate(
    newname = '.',
    newstrand = '+',
    blockStarts = NA
  ) |>
  dplyr::select( # Format to bed file
    name, start_tr, end_tr, newname, score, newstrand,
    thickStart_tr, thickEnd_tr, itemRgb,
    blockCount, blockSizes, blockStarts
  ) 

bed12_tr |>
  write_tsv(opts$output, col_names = FALSE)
