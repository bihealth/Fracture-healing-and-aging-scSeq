# point to your R packages

conda_pkgs_path <- "/data/gpfs-1/users/milekm_c/work/miniconda/envs/seurat_rstudio/lib/R/library"

# conda_pkgs_path <- "/data/gpfs-1/users/milekm_c/work/miniconda/envs/seurat/lib/R/library"

.libPaths(c(conda_pkgs_path, .libPaths() ))

install_pkgs_path <- "/data/gpfs-1/users/milekm_c/work/lib/R/library"
.libPaths(c(install_pkgs_path, .libPaths() ))


# .libPaths(.libPaths()[-2])
tmod_path <- "/data/gpfs-1/users/milekm_c//work/miniconda/envs/sea_snap_bo_de/lib/R/library"

.libPaths(c(tmod_path, .libPaths() ))
