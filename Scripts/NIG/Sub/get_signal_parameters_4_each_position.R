#!/usr/local/bin/R

library(multidplyr)
library(dtplyr, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(furrr)
library(purrr)
library(readr)
library(stringr)
library(optparse)

list_files  <- function(path = ".", pattern = ".",
                       all.files = FALSE,
                       full.names = TRUE, recursive = TRUE) {

  list.files(
    path = stringr::str_remove(path, '/$'),
    pattern = pattern,
    all.files = all.files,
    full.names = full.names, recursive = recursive)

}

read_rownum_index <- function(path) {
  
  read_tsv(
    path, 
    col_names = c('rownum_read', 'transcript_id'), col_types = 'cc'
  ) 
  
}

format_rownum_index <- function(rownum_index_preformat, num_row = 10000000000) {
  
  temp <- rownum_index_preformat |> 
    separate(rownum_read, into = c('start', 'read_id'), sep = ':') |> 
    mutate(start = as.numeric(start)) |> 
    select(read_id, transcript_id, start)
  
  temp$end <- c(temp$start[2:nrow(temp)], num_row) - 1
  return(temp)
  
}

read_out_eventalign_collapse <- function(
    path, start, end, read_id, 
    transcript_id
    ) {
  
  print(read_id)
  read_tsv(path, skip = start, n_max = end - start - 1,
           col_types = 'dcdddddcdd') |> 
    mutate(read_id = read_id) |> 
    mutate(transcript_id = transcript_id) |> 
    mutate(path = path) |> 
    select(ref_pos, dwell_time, status, median, mad, read_id, transcript_id, path)
  
}

prepare_read_index_table_of_a_transcript_4_read_out_eventalign_collapse <- 
  function(out_eventalign_collapse_path, tr_id) {
    
  index_path <- str_replace(out_eventalign_collapse_path, 
                            pattern = '.tsv',
                            replacement = '_rownum_idx.tsv')
  
  read_rownum_index(index_path) |> 
    format_rownum_index() |> 
    filter(transcript_id == tr_id) |> 
    mutate(path = out_eventalign_collapse_path) 
  
}

prepare_index_all_samples <- function(transcript_id) {
  
  list_files('Nanocompore/Espresso/Eventalign_collapse/', 
             pattern = 'out_eventalign_collapse.tsv$') |>
    future_map(
        prepare_read_index_table_of_a_transcript_4_read_out_eventalign_collapse, 
        tr_id = transcript_id) |> 
        list_rbind()
  
}


# Parse arguments

optslist <- list(

    make_option(c('--transcript', '-t'),
                type = 'character',
                help = 'transcript_id'),
    make_option(c('--outdir', '-o'),
                type = 'character',
                help = 'output directory')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

dir.create(opts$outdir, showWarnings = FALSE, recursive = TRUE)

# Main

plan(multisession)

prepare_index_all_samples(opts$transcript) |> 
  future_pmap(read_out_eventalign_collapse) |> 
  list_rbind() |> 
  mutate(path = str_remove(path, 
           'Nanocompore/Espresso/Eventalign_collapse/[0-9]+_DrTaniue_|_N[0-9]/out_eventalign_collapse.tsv') 
        ) |> 
  separate(path, c('sample_id', 'type'), sep = '_', extra = 'merge') |> 
  write_tsv(paste0(opts$outdir, opts$transcript, '.tsv.gz'))
  