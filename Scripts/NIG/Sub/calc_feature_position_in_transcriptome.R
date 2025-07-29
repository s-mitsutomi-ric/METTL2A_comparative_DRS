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
    make_option(c('--feature', '-f'),
                type = 'character', 
                help = 'a feature e.g. CDS or UTR'),
    make_option(c('--attribute', '-a'),
                type = 'character',
                help = 'an attribute e.g. transcript_id'),
    make_option(c('--ref'  , '-r'),
                type = 'character',
                help = 'reference bed file'),
    make_option(c('--output', '-o'),
                type = 'character',
                help = 'output bed file')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)


# Read gtf file
read_gtf <- function(path, filter_feature = 'no') {

  data <- readr::read_tsv(
    path, comment = '#',
    col_names = c('seqname', 'source', 'feature', 'start', 'end',
                  'score', 'strand', 'frame', 'attribute'), 
                  show_col_types = FALSE
  ) |>
    dplyr::mutate(attribute = noquote(attribute))

  return(data)

}

# read bed12 format file
read_bed12 <- function(path) {
  
  bed12_colnames <- c(
    'chrom', 'start', 'end', 'name', 'score', 'strand',
    'thickStart', 'thickEnd', 'itemRgb', 'blockCount', 'blockSizes', 'blockStarts'
  )
  
  read_tsv(path, col_names = bed12_colnames, 
           col_types =  'cddcdccccdcc',
           show_col_types = F) 
  
}

# convert position in genome to that in transcriptome
convert_position_genome2transcriptome <- function(
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

# Extract a attribute from the 9th column of gtf
extract_attribute <- function(.df, .attribute) {
  
  attribute_expr <- paste0(.attribute, ' \".+?\"; ')

  .df |> 
    mutate(attribute = str_extract(attribute, attribute_expr)) |> 
    mutate(attribute = str_remove_all(attribute, paste0(.attribute, ' \"'))) |> 
    mutate(attribute = str_remove_all(attribute, '\"; '))
  
}

# Calculate transcript length
calc_transcript_length <- function(sizes) {
  
  size_list  <- str_split(sizes , ',')
  tr_length <- sum(as.numeric(unlist(size_list)))
  return(tr_length)
  
}

# Read gtf file and filter records of appropriate feature
feature_gtf <- read_gtf(opts$input) |> 
  filter(feature == feature) |> 
  extract_attribute(opts$attribute)

# Calculate range of the feature (grouped by attribute )
feature_range_bed <-
  feature_gtf |> 
  group_by(seqname, feature, strand, attribute) |> 
  reframe(feature_start = min(start) - 1, feature_end = max(end)) |> # bed is zero start
  mutate(score = ".") |> 
  select(seqname, feature_start, feature_end, attribute, score, strand) |> 
  rename(name = attribute)

# Convert the position from genome to transcriptome
result_bed <- 
  feature_range_bed |> 
  left_join(
    read_bed12(opts$ref) |> select(chrom, start, end, name, starts_with('block'))
  ) |> 
  filter(!is.na(start)) |> 
  rowwise() |> 
  mutate(
    start_in_tr = convert_position_genome2transcriptome(
      feature_start, blockSizes, blockStarts, start, strand),
    end_in_tr   = convert_position_genome2transcriptome(
      feature_end  , blockSizes, blockStarts, start, strand)
  ) |> 
  mutate(
    temp        = min(start_in_tr, end_in_tr),
    end_in_tr   = max(start_in_tr, end_in_tr),
    start_in_tr = temp
  ) |>
  mutate(
    transcript_start = 0,
    transcript_end   = calc_transcript_length(blockSizes),
    newname   = '.',
    newstrand = '+',
    itemRgb   = '255,0,0') |> 
  select(name, transcript_start, transcript_end, newname, score, newstrand,
         start_in_tr, end_in_tr, itemRgb, 
         blockCount, blockSizes, blockStarts) |>
  write_tsv(opts$output, col_names = FALSE)
