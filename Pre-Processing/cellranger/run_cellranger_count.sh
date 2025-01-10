#!/bin/bash

for library_name in P1741_04_11A5_prox_dist P1741_05_11B2_fx; do sbatch --export=library_name=${library_name} cellranger_count.sh; done

#for library_name in P1741_01_11A2_fx; do sbatch --export=library_name=${library_name} cellranger_count.sh; done

#for library_name in $(ls cellranger_count | sed 's/.csv//'); do sbatch --export=library_name=${library_name} cellranger_count.sh; done
