#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(optparse)


# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                type = 'character',
                help = 'input gtf file'),
    make_option(c('--output', '-o'),
                type = 'character',
                help = 'output bed file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)


extract_gtf_attribute <- function(.df, .col) {
  
  extract_pattern <- paste0(.col, ' \".+?\";' )
  
  .df |> 
    mutate(
      !!.col := str_extract(attributes, extract_pattern)
    ) 
  
}

read_gtf <- function(path, filter_feature = 'no') {

  data <- readr::read_tsv(
    path, comment = '#',
    col_names = c('seqname', 'source', 'feature', 'start', 'end',
                  'score', 'strand', 'frame', 'attributes'),
    show_col_types = FALSE
  ) |>
    dplyr::mutate(attributes = noquote(attributes))

  if (filter_feature %in% c('gene', 'transcript')) {

    data <- data |>
      dplyr::filter(feature == filter_feature)

  }

  return(data)

}


# Reduce attributes of gtf file

temp <- read_gtf(opts$input) |> 
  filter(feature %in% c('gene', 'transcript', 'exon')) |> 
  extract_gtf_attribute('gene_id') |> 
  extract_gtf_attribute('transcript_id') |> 
  extract_gtf_attribute('exon_id') |> 
  mutate(new_attributes = noquote(case_when(
    feature == 'gene'       ~ gene_id,
    feature == 'transcript' ~ paste(gene_id, transcript_id, sep = ' '),
    feature == 'exon'       ~ paste(gene_id, transcript_id, exon_id, sep = ' '),
    .default = NA
  ))) |>
  mutate(new_attributes = str_replace_all(new_attributes, '""', '"')) |> 
  select(seqname:frame, new_attributes) |>
  write_tsv(opts$output, col_names = FALSE, quote = 'none', escape = 'none')
