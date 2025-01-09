# Fracture-healing-and-aging-scSeq
# Project description
In this project, we use scRNAseq to identify cellular phenotypes that may influence the bone healing outcome in mice with differential immune experience due to ageing. We aim to understand the cellular and molecular basis of delayed bone healing in mice, and ultimately identify potential targets to reverse it in elderly bone fracture patients.​
# Contacts and links
P.I.: Georg Duda, Dieter Beule, Katharina Schmidt-Bleek

CUBI contact e-mail: mireille.ngokingha-tchouto@charite.de and miha.milek@bih-charite.de

# Quick start
Get the Seurat object from zenodo
```

conda create -n figures_bonehealing -f Figures/envs/monocle.yaml
conda activate figures_bonehealing

git clone "repo"
cd Figures/data
wget "zenodo_link"


```
To reproduce the figures run scripts in Figures/Scripts (fig1-5.Rmd). 


