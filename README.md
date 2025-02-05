# Project description
Single cell bone healing
# Contacts and links
- P.I: Georg Duda, Dieter Beule
- CUBI Contact: [Miha Milek] [mailto:milek@bih-charite.de]

# Quick Start
## For the preprocessing
- Download the fastq files from GEO: [GSE273792](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE273792).
- Run under Preprocessing/cellranger
- Run under Pre-processing: the single cell pipeline

## For the processing:
Run the scripts under the processing folder to correct for any batch effects and integrate the data

## Figures in the publication
The seurat object to reproduce the figures can be downloaded from  ["zenodo link"](https://zenodo.org/uploads/13990107):

- git clone ["repo"](https://github.com/bihealth/Fracture-healing-and-aging-scSeq.git)
- cd `.../Figures`
- Add the downloaded seurat objet to the folder `Figures / data`. To install all the packages that are useful for creating the figures, use the already created environments in `Figures/envs`
- run `Figures/Scripts/fig1.rmd ... Figures/Scripts/fig5.rmd` to generate figure 2-6 and supplemental figures of the maunscript.
    - Input data for fig1(SFig1), fig2(SFig2), fig3(SFig3) and fig5(SFig5): `data/sobj_group_force_final_version.rds` and `data/sobj_hto.rds`
    - Input data for fig4(SFig4): `data/HSC_pseudotime_correct.rds`
  
    

