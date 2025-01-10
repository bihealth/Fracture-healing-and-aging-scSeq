#!/bin/bash

path_to_fastq="/fast/groups/cubi/work/milekm/mireille/raw_data_sodar"
out="/fast/groups/cubi/work/milekm/mireille/de/rerun/cellranger/cellranger_count"
path_to_csv="/fast/groups/cubi/work/milekm/mireille/de/rerun/cellranger"

mkdir -p $out
cd $out

while IFS=',' read library_name fastq_dir_ge prefix_ge modality_ge fastq_dir_ac prefix_ac modality_ac
do 
  mkdir -p $library_name
  echo "fastqs,sample,library_type" > "$library_name".csv
	echo "${fastq_dir_ge},${prefix_ge},${modality_ge}" >> "$library_name".csv
	echo "${fastq_dir_ac},${prefix_ac},${modality_ac}" >> "$library_name".csv
done < $path_to_csv/map_ln_to_fastq.csv




