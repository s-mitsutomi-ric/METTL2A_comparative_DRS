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
                help = 'output gtf file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)


# Read gtf file
read_gtf <- function(path, filter_feature = 'no') {

  data <- readr::read_tsv(
    path, comment = '#',
    col_names = c('seqname', 'source', 'feature', 'start', 'end',
                  'score', 'strand', 'frame', 'attributes'), 
                  show_col_types = FALSE
  ) |>
    dplyr::mutate(attributes = noquote(attributes))

  return(data)

}

extract_gtf_attribute <- function(.df, .col) {
  
  extract_pattern <- paste0(.col, ' \".+?\";' )
  
  .df |> 
    mutate(
      !!.col := str_extract(attributes, extract_pattern)
    ) 
  
}

fill_gene_id <- function(gtf) {
  
  gtf |> 
    extract_gtf_attribute('gene_id') |> 
    extract_gtf_attribute('transcript_id') |> 
    mutate(gene_id = ifelse(gene_id == 'gene_id "NA";',
                            str_replace(transcript_id, 'transcript_id', 'gene_id'), 
                            gene_id)) 
  
}

add_gene_record <- function(gtf) {
  
  gtf |> 
    group_by(gene_id) |> 
    reframe(
      seqname = unique(seqname),
      source  = unique(source),
      feature = 'gene',
      start   = min(start),
      end     = max(end),
      score   = '.',
      strand  = unique(strand),
      frame   = '.',
      attributes = noquote(unique(gene_id)),
    ) |> 
    ungroup() |> 
    bind_rows(gtf)
  
}

write_gtf <- function(gtf, path) {
  
  gtf |> 
    write_tsv(path, col_names = FALSE, quote = 'none', escape = 'none')
  
}

read_gtf(opts$input) |> 
  fill_gene_id() |> 
  add_gene_record() |> 
  arrange(seqname, gene_id) |> 
  select(seqname:attributes) |> 
  write_gtf(opts$output)
