#Setting global seed manually before running 
#SCVIIntegration code gets overwritten by random seed from the function itself.

#The following script sets the global seed manually to 123

import numpy as np

import random

import torch

import scvi
 
def set_seeds(seed=123):

    # Set seeds for random, numpy, and torch

    random.seed(seed)

    np.random.seed(seed)

    torch.manual_seed(seed)

    # Set CUDA seed if available

    if torch.cuda.is_available():

        torch.cuda.manual_seed_all(seed)

    # Print seed verification for random, numpy, and torch

    print(f"Random: {random.random()}")

    print(f"NumPy: {np.random.rand()}")

    if torch.cuda.is_available():

        print(f"CUDA: {torch.rand(1).cuda()}")

    else:

        print(f"Torch: {torch.rand(1)}")

    # Set scvi global seed to 123

    scvi.settings.seed = 123

    print(f"scvi Global Seed: {scvi.settings.seed}")  # Verify scvi seed is set to 123

    return seed  # Return the original seed value (123)
 
# Execute the function

used_seed = set_seeds(seed=123)

print(f"The seed that was returned is: {used_seed}")
 
# Optional: Print scvi version for reference

print(f"Last run with scvi-tools version: {scvi.__version__}")
 