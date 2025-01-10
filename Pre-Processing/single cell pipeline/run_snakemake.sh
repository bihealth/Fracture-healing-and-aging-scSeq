#!/bin/bash

#SBATCH --job-name=run_snakemake
#SBATCH --time=10:00:00 #HH:MM:SS
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH --mem-per-cpu=2000
#SBATCH --partition=medium
#SBATCH -o slurm_logs/slurm.%x.%j.out # STDOUT
#SBATCH -e slurm_logs/slurm.%x.%j.err # STDERR

export SBATCH_DEFAULTS=" --output=slurm_logs/%x-%j.log"

date
snakemake --use-conda -j2 --profile=cubi-v1
date
