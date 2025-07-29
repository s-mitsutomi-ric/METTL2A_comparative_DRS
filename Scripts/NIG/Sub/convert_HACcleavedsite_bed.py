#!/usr/bin/env python3

import argparse
import gzip
import re

def check_extension(input_file, output_file):

    if not re.match('.*\.bed(\.gz)?$', input_file):
        raise ValueError('Input file must be a .bed or .bed.gz file')
    
    if not re.match('.*\.bed(\.gz)?$', output_file):
        raise ValueError('Output file must be a .bed or .bed.gz file')

def process_bed_file(input_file, output_file):

    open_func_in  = gzip.open if input_file.endswith('.gz')  else open
    open_func_out = gzip.open if output_file.endswith('.gz') else open

    with open_func_in(input_file, 'rt') as infile, open_func_out(output_file, 'wt') as outfile:
        
        for line in infile:
            fields = line.strip().split('\t')
            chrom, start, end, name, score, strand = fields[:6]
            start, end = int(start), int(end)
            
            if strand == '+':
                end = start
                start -= 1

            elif strand == '-':
                start = end
                end += 1

            outfile.write('\t'.join([chrom, str(start), str(end), name, score, strand]) + '\n')

def main():
    
    # Parse arguments ------------------------------------------------------------------------------

    parser = argparse.ArgumentParser(
        prog='convert mapping info in bed format to information of cleaved position in bed format', 
        description="""
        convert mapping info in bed format to information of cleaved position in bed format
        """
    )

    parser.add_argument(
        '-i', '--input', help = 'input bed file (or gzipped bed file)', required=True
    )

    parser.add_argument(
        '-o', '--output', help = 'output bed file (or bed.gz)', required=True
    )

    args = parser.parse_args()

    # Process bed file --------------------------------------------------------------------------------
    check_extension(args.input, args.output)
    process_bed_file(args.input, args.output)

if __name__ == '__main__':
    main()
