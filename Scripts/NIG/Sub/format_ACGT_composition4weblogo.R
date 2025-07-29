#!/usr/local/bin/R

suppressPackageStartupMessages(library(dplyr))
library(readr)
library(optparse)

# Parse arguments

optslist <- list(

    make_option(c('--input', '-i'),
                help = 'input file (output of count_ACGT.sh)'),
    make_option(c('--digit'  , '-d'), type = 'integer', default = 1,
                help = 'digit')

)

parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

# Calculate ACGT percent
percent <-
  read_delim(opts$input, delim = ' ', 
             col_names = c('count', 'base'), 
             show_col_types = F)  |> 
  mutate(percent = round(100 * count / sum(count), digits = opts$digit)) |> 
  arrange(base) |> 
  mutate(text = paste0("'", base, "':", percent, "")) 

# Display the result
result <- paste(percent$text, collapse = ', ')
result <- paste0('{', result, '}')
cat(result)
