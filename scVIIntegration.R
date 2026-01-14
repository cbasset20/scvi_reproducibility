library(Seurat)
library(reticulate)
library(SeuratWrappers)
options(future.globals.maxSize = 1e40)
set.seed(123) #important for reproducibility 


#Load object 
obj <- readRDS("~/obj.rds)
obj <- SCTransform(obj)
obj <- RunPCA(obj)



# SCVIIntegration ---------------------------------------------------------

#tell reticulate which pyth env to use so it executes the source_python() code
use_condaenv("PATH/to/scvi-env", required = TRUE) 
#set seed(123) in python env from R
source_python("~/PATH/to/set_seed.py") #refer to https://github.com/cbasset20/scVI_Reproducibility.git for the script


obj.scvi <- IntegrateLayers(
  object = obj, method = scVIIntegration, 
  orig.reduction = "pca", new.reduction = "integrated.scvi", 
  assay = "SCT", 
  conda_env = "PATH/to/scvi-env",
  verbose = TRUE
)

#verify seed
py_run_string("import torch; print(torch.initial_seed())")

# Access the scvi module via reticulate
scvi <- import("scvi")
# Check the global seed (if set)
py_run_string("import scvi; print(scvi.settings.seed)")
scvi$settings$seed


obj.scvi <- FindNeighbors(obj.scvi, 
reduction = "integrated.scvi", 
dims = 1:30
)

obj.scvi <- FindClusters(lg.scvi, 
                        resolution =  0.4
)

#important step for reproducibility of UMAPs
#set seed within RunUMAP function
obj.scvi <- RunUMAP(obj.scvi, 
reduction = "integrated.scvi", dims = 1:30, 
reduction.name = "umap.scvi", #optional
seed.use = 0
)


