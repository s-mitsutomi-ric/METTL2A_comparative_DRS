#!/bin/bash

string=$1

tsvs='Nanocompore/Eventalign_collapse/'*'/out_eventalign_collapse.tsv'
ls $tsvs | grep $string | tr "\n" ',' | sed -e 's/,$//'
