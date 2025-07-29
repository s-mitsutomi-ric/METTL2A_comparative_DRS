#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N count_reads

# ディレクトリを指定
dir=$1
output_file=$2

# ヘッダーを出力ファイルに書き込む
echo -e "File\tchrM\tNonchrM" > $output_file

# ディレクトリ内の全てのTSVファイルに対してループ
for file in ${dir}/*.sam; do

  echo "Processing $file"
  
  # 'chrM'である行の数をカウント
  chrM_count=$(awk -F'\t' '$3 == "chrM"' $file | wc -l)
  
  # 'chrM'でない行の数をカウント
  non_chrM_count=$(awk -F'\t' '$3 != "chrM"' $file | wc -l)
  
  # 結果を出力ファイルに書き込む
  echo -e "$(basename $file)\t$chrM_count\t$non_chrM_count" >> $output_file
done
