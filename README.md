# Project description
The scripts for Tchouto et. al paper on pronounced B cell impairment in adult immune-experienced mice [link to article](https://www.frontiersin.org/journals/immunology/articles/10.3389/fimmu.2025.1511902/abstract).

## Data source
The data used in this repository was provided by:  
- [Christian H. Bucher] [Julius Wolff Institute of Biomechanics and Musculoskeletal Regeneration]
- [Ann-Kathrin Mess] [Julius Wolff Institute of Biomechanics and Musculoskeletal Regeneration]
- [Katharina Schmidt-Bleek] [Julius Wolff Institute of Biomechanics and Musculoskeletal Regeneration]

## Contacts and links
- P.I: Georg Duda, Dieter Beule
- CUBI Contact: [Miha Milek] [mailto:milek@bih-charite.de]

## Quick Start
### For the preprocessing
- Download the fastq files from GEO: [GSE273792](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE273792).
- Run under Preprocessing: cellranger
- Run under Pre-processing: the single cell pipeline

### For the processing:
Run the scripts under the processing folder to correct for any batch effects and integrate the data

### Figures in the publication
The seurat object to reproduce the figures can be downloaded from  ["zenodo link"](https://zenodo.org/uploads/13990107):

- git clone ["repo"](https://github.com/bihealth/Fracture-healing-and-aging-scSeq.git)
- cd `.../Figures`
- Add the downloaded seurat objet to the folder `Figures/data`. To install all the packages that are useful for creating the figures, use the already created environments in `Figures/envs`
- run `Figures/Scripts/fig1.rmd ... Figures/Scripts/fig5.rmd` to generate figure 2-6 and supplemental figures of the maunscript. Input data for the figures are found in the folder `Figures/data` except for fig1a which is in `Figures/images/fig1a.svg`

  
    

