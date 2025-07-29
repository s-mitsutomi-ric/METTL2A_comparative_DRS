#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(optparse)



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

extract_gtf_attribute <- function(.df, .col) {
  
  extract_pattern <- paste0(.col, ' \".+?\";' )
  
  .df |> 
    mutate(
      !!.col := str_extract(attributes, extract_pattern) 
    ) 

}

filter_genes_wo_exon <- function(.gtf) {
  
  .gtf |> 
    group_by(gene_id) |> 
    reframe(new_feature = unique(feature) |> paste(collapse = ',')) |> 
    filter(!grepl('exon', new_feature)) |> 
    select(gene_id)
  
}

fill_exon_record_from_transcript_record <- function(.gtf) {
  
  no_exon_records <- .gtf |> 
    filter_genes_wo_exon() |> 
    left_join(gtf, by = join_by(gene_id))
  
  new_exon_records <-
    no_exon_records |> 
    group_by(gene_id) |> 
    filter(max(start) == min(start) | max(end) == min(end)) |>
    filter(feature == 'transcript') |>
    mutate(feature = 'exon') |>
    select(seqname:attributes, gene_id)
  return(new_exon_records)
  
}

write_gtf <- function(gtf, path) {
  
  gtf |> 
    write_tsv(path, col_names = FALSE, quote = 'none', escape = 'none')
  
}

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

# Main
gtf <- read_gtf(opts$input) |> 
  extract_gtf_attribute('gene_id') 

gtf |> 
  bind_rows(fill_exon_record_from_transcript_record(gtf)) |> 
  arrange(seqname, gene_id, start, end) |> 
  select(seqname:attributes) |>
  write_gtf(opts$output)
  
