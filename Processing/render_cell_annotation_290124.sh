#!/bin/bash

#SBATCH --time=02:00:00 #HH:MM:SS
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH --mem=20G
#SBATCH --partition=medium
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR

input_rmd="'cell_annotation_290124.Rmd'"
output_html="'cell_annotation_290124.html'"
title="'Cell Annotation 290124'"

eval "$(conda shell.bash hook)"
conda activate R-fixed-biomart
#conda activate R-fixed-scba


Rscript -e "rmarkdown::render(input = ${input_rmd}, output_file = ${output_html}, params = list(title = ${title}))"
