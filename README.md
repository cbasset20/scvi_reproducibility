# scVI_Reproducibility
 Scvi-tools versions < 1.0.0 automatically sets the global seed to 0 (as shown in the verbose section in the console) and yields reproducible results.
 
 Scvi-tools versions >= 1.0.0 installed from [scVI] (https://docs.scvi-tools.org/en/stable/installation.html) tools installation guide do not automatically set a fixed global seed and instead generate random seed every run.
 
 Running integration with scvi-tools versions >= 1.0.0 without manually setting scvi global seed will yield a random seed of 14 digits (this seed will reset with every run and/or everytime you restart/open a new session in R). 
 
 Setting scVI global seed manually must be within this allowable interval: 0 to 4294967295.  Going beyond this number will set scvi global seed automatically to 0. 
 The maximum digits for manual scvi global seed is 10 digits whereas random seed set by scVI is usually 14 digits which means that you cannot replicate a random seed (even if you know which seed was set by scVI) by setting it manually. 
 
 Setting scVI global seed from R in python before running scVIIntegration with the IntegrateLayers() function will result in reproducible objects/UMAPs. 
 
 NOTE: Regressing out mitochondrial genes with SCTransform has no effect on scVIIntegration as the batch-corrected values that are stored under integrated.scvi reduction slot are exactly the same. 
