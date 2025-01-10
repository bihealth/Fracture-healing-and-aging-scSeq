#!/bin/bash

#SBATCH --time=40:00:00 #HH:MM:SS
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH --mem-per-cpu=40000
#SBATCH --partition=medium
#SBATCH -o slurm.%A.%a.out # STDOUT
#SBATCH -e slurm.%A.%a.err # STDERR

rna_reference="/data/cephfs-1/work/groups/cubi/tools/cellranger/indices/gex/refdata-gex-mm10-2020-A"
mkdir -p cellranger_count
cd cellranger_count

/data/cephfs-1/work/groups/cubi/tools/cellranger/cellranger-7.1.0/cellranger count \
  --include-introns false \
  --id=${library_name} \
  --libraries ${library_name}.csv \
  --transcriptome ${rna_reference}  \
  --feature-ref=feature_reference.csv \
  --jobmode=slurm \
  --maxjobs=10 \
  --jobinterval=1000
