#!/usr/local/bin/R

library(dplyr)
library(readr)
library(stringr)
library(tidyr)
library(purrr)
library(ggplot2)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--trid', '-t'),
                type = 'character',
                help = 'transcript id'),
        make_option(c('--figdir', '-f'),
                type = 'character',
                help = 'figure directory'),
        make_option(c('--ref', '-r'),
                type = 'character',
                help = 'tsv file having information about relationship between transcript id and name')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

read_signal_parameter_files <- function(
    .glob, 
    .dir = 'Tables/Nanocompore/Signal_parameters/') {
  
  fs::dir_ls(.dir, glob = .glob) |> 
    read_tsv(
      col_names = c('ref_pos', 'ref_kmer', 'dwell_time', 'intensity'), col_types = 'dcdd', 
      id = 'filename'
    ) |> 
    separate(filename, sep = '_',
             into = c(NA, NA, NA, 'sample_num', 'type', 'si', NA, 'transcript_id')) |> 
    mutate(transcript_id = str_remove(transcript_id, '.tsv'))
  
}

plot_intensity_distribution_at_each_position <- function(
    pos, 
    df, figdir = '', tr_name = '') {
  
  df_filtered <- df |> 
    filter(ref_pos == pos)

  kmer <- unique(df_filtered$ref_kmer)
  id   <- unique(df_filtered$transcript_id)

  plot_title <- paste0(tr_name, '|', as.character(pos), ' kmer: ', kmer)

  # Plot distribution 

  figdir_dist <- paste0(figdir, 'Intensity_distribution/', id, '_', tr_name, '/')
  dir.create(figdir_dist, showWarnings = FALSE, recursive = TRUE)
  plot_path <- paste0(figdir_dist, id, '_', tr_name, '_', as.character(pos), '.pdf')
  
  plot_distribution <- df_filtered |> 
    ggplot(aes(x = forcats::fct_rev(paste(type, si)), 
               y = intensity, 
               fill = type)) +
    geom_violin() +
    geom_boxplot(width = .3, coef = Inf, fill = 'white', lwd = 0.1) +
    labs(x = '', title = plot_title) +
    coord_flip() +
    theme_classic(base_size = 8) +
    theme(legend.position = 'bottom', legend.title = element_blank())  
  
  ggsave(filename = plot_path, 
         plot = plot_distribution, width = 9, height = 8, units = 'cm')

  # Plot cumulative fraction

  figdir_ecdf <- paste0(figdir, 'Ecdf/', id, '_', tr_name, '/')
  dir.create(figdir_ecdf, showWarnings = FALSE, recursive = TRUE)
  plot_path <- paste0(figdir_ecdf, id, '_', tr_name, '_', as.character(pos), '.pdf')
  
  plot_ecdf <- df_filtered |> 
    ggplot(aes(x = intensity, colour = forcats::fct_rev(paste(type, si)))) +
    stat_ecdf(alpha = 1/2) +
    labs(x = 'intensity', title = plot_title) +
    theme_classic(base_size = 8) +
    theme(legend.position = 'bottom', legend.title = element_blank())  
  
  ggsave(filename = plot_path, 
         plot = plot_ecdf, width = 9, height = 8, units = 'cm')
  
}

transcript_id2name <-
  read_tsv(opts$ref, col_names = c('transcript_id', 'transcript_name'), col_types = 'cc')  |> 
  filter(transcript_id == opts$trid)
trname <- unique(transcript_id2name$transcript_name)

parameters <- 
  paste0('*', opts$trid, '.tsv') |> 
  read_signal_parameter_files() |> 
  group_by(ref_pos) |> 
  filter(n() >= 10) |> # to avoid error in violin plot
  ungroup()

unique(parameters$ref_pos) |> 
  walk(plot_intensity_distribution_at_each_position, 
       df = parameters, figdir = opts$figdir, tr_name = trname)
  