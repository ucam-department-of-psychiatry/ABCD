import numpy as np
import math
import nibabel as nib
from sys import argv
import matplotlib.pyplot as plt
import nilearn
from nilearn import plotting
from nilearn import image

display = plotting.plot_anat(argv[1]) 
display.add_overlay(argv[2], cmap=plotting.cm.black_red) 

display.savefig('QC_checkreg.png')
display.close()
