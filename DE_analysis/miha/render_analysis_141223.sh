#!/bin/bash

#SBATCH --time=4:00:00 #HH:MM:SS
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH --mem-per-cpu=20000
#SBATCH --partition=medium
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR

input_rmd="'DE_final_analysis_141223.Rmd'"
output_html="'DE_final_analysis_141223_pseudoid.html'"
title="'DE final analysis 141223'"
shrinkage_type="'normal'"

eval "$(conda shell.bash hook)"
conda activate R-fixed-biomart


Rscript -e "rmarkdown::render(input = ${input_rmd}, output_file = ${output_html}, params = list(title = ${title},shrinkage_type = ${shrinkage_type}))"
