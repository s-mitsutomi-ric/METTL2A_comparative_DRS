#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--ref', '-r'),
                type = 'character',
                help = 'reference gtf file'),
    make_option(c('--add', '-a'),
                type = 'character',
                help = 'added gtf file'),
    make_option(c('--output', '-o'),
                type = 'character',
                help = 'output gtf file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

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

summarise_duplicated_records <- function(gtf) {
  
  gtf |> 
    fill_gene_id() |> 
    group_by(seqname, feature, start, end, strand, 
             gene_id, transcript_id) |> 
    reframe(
      seqname = unique(seqname),
      source  = unique(source),
      feature = unique(feature),
      start   = unique(start),
      end     = unique(end),
      score   = unique(score),
      strand  = unique(strand),
      frame   = unique(frame),
      gene_id = unique(gene_id), 
      transcript_id = unique(transcript_id)
    ) |> 
    mutate(new_attributes = noquote(case_when(
      feature == 'gene'       ~ gene_id,
      feature == 'transcript' ~ paste(gene_id, transcript_id, sep = ' '),
      .default = paste(gene_id, transcript_id, sep = ' ')
    )))
  
}

read_gtf(opts$ref) |> 
  bind_rows(read_gtf(opts$add)) |>
  summarise_duplicated_records() |> 
  arrange(seqname, gene_id) |> 
  select(seqname, source, feature, start, end, 
         score, strand, frame, new_attributes) |>
  write_tsv(opts$output, col_names = FALSE, quote = 'none', escape = 'none')
