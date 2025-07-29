#!/usr/local/bin/R

library(dplyr)
library(readr)
library(tidyr)
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

# Functions

read_result  <- function(input) {

    read_tsv(input, col_names = c('name', 'base'))

}

parse_name <- function(df) {
  
  df |> 
    separate(name, into = c('read', 'transcript_id', 'pos'), 
             sep = '[|]|::') |>
    separate(pos, into = c('chr', 'pos'), sep = ':') |> 
    separate(pos, into = c('pos', 'strand', NA), sep = '[(]|[)]') |> 
    mutate(pos = str_remove(pos, '[0-9]+-') |> as.numeric()) 
  
}

filter_unique_overlap_reads <- function(df) {
  
  df |> 
    group_by(read) |> 
    filter(n() == 1) 
  
}

# Main

read_result(opts$input) |> 
  parse_name() |> 
  filter_unique_overlap_reads() |> 
  write_tsv(opts$output)
