# scVI\_Reproducibility

Scvi-tools versions < 1.0.0 automatically sets the global seed to 0 (as shown in the verbose section in the console) and yields reproducible results.

Scvi-tools versions >= 1.0.0 installed from [scVI](https://docs.scvi-tools.org/en/stable/installation.html) tools installation guide do not automatically set a fixed global seed and instead generate random seed every run.

Running integration with scvi-tools versions >= 1.0.0 without manually setting scvi global seed will yield a random seed of 14 digits (this seed will reset with every run and/or everytime you restart/open a new session in R).

Setting scVI global seed manually must be within this allowable interval: 0 to 4294967295.  Going beyond this number will set scvi global seed automatically to 0.
The maximum digits for manual scvi global seed is 10 digits whereas random seed set by scVI is usually 14 digits which means that you cannot replicate a random seed (even if you know which seed was set by scVI) by setting it manually.

Setting scVI global seed from R in python before running scVIIntegration with the IntegrateLayers() function will result in reproducible objects/UMAPs.

NOTE: Regressing out mitochondrial genes with SCTransform has no effect on scVIIntegration as the batch-corrected values that are stored under integrated.scvi reduction slot are exactly the same.

set_seed.py script manually sets the seed and enables reproducibility of scVI with every run.



# scVI\_Reticulate

Running [integration](https://satijalab.org/seurat/articles/integration\_introduction) on a Seurat object in R using scVI tools via Reticulate package. 

# Installation

Python (this will install scvi-tools version > 1.0.0)

```bash

conda create -n scvi-env python=3.12

conda activate scvi-env

#install Pytorch to take advantage of accelerated GPU

#Only install this version of pytorch to enable GPU acceleration

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124 

#(optional) install pytorch for CPU only

#pip3 install torch torchvision torchaudio

#pytorch will install all the numpy scanpy packages that you need. no need to reinstall them.



#Only install this version of Jax to enable GPU acceleration

pip install -U "jax\[cuda12]"

#otherwise install it for CPU

#pip install -U jax



pip install -U scvi-tools

pip install -U scvi-tools\[tutorials]

pip install -U scvi-tools\[optional]

pip install -U scvi-tools\[dev]



conda install -c conda-forge r-base r-essentials r-reticulate

```





R

```bash

install.packages('remotes')

install.packages("R.utils")

install.packages("BiocManager")

BiocManager::install("vjcitn/scviR")

install.packages(reticulate)

#this version of seurat wrappers is crucial. IntegrateLayers() function will not work if you install any other version

remotes::install\_github(repo="satijalab/seurat-wrappers", ref = remotes::github\_pull(184))

```



