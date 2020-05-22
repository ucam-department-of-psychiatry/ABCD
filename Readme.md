# ABCD Code repository

# About ABCD
The ABCD Study is a landmark, longitudinal study of brain development and child health. Investigators at 21 sites around the country will measure brain maturation in the context of social, emotional and cognitive development, as well as a variety of health and environmental outcomes.

We strongly encourage others in the Department to share in this resource so please feel free to get in touch with us and/or distribute this white paper draft to other within the Department you think might be interested.

Richard A.I. Bethlehem (rb643)    
Varun Warrier (vw260)      

## How to access this resource
Accessing this data resource is currently done on a case by case basis and access is dependent on having an active approved ABCD application with NIMH

## Authorship, usage and acknowledgements
If you are using the existing variables available from the ABCD, you do not need to include anyone as co-authors. However, if you are using variables generated by others (for example imaging metrics processed using specific pipelines, polygenic scores, bespoke phenotypic variables), please contact the person who has generated the variables before using them. Please check with them re. authorship in accordance with the University's authorship guidelines (see: http://www.medschl.cam.ac.uk/wp-content/uploads/2014/02/CoS14_68-Authorship_Code_of_Practice-FINAL.pdf?04c0fc). If you are unsure if variables were generated by a specific user or were ABCD default please contact Varun or Richard to check.

If you are creating a new variable and would like to make it available for others to use please include the following:    
1. A readme file with the description of the variables, your name and contact information, and details of use   
2. A file, or a link to a webpage (github, OSF etc) with detailed methods you used for generating the variables including the code.    

Finally, when making use of this resource please acknowledge the following funding sources that continue to make storage and processing of this dataset possible in your publications:

"This research was co-funded by the NIHR Cambridge Biomedical Research Centre and a Marmaduke Sheild grant to RAIB. The views expressed are those of the author(s) and not necessarily those of the NHS, the NIHR or the Department of Health and Social Care."


## File and folder structure for imaging data
ABCD imaging data largely follows the BIDS standard for folder structure, in order to stay close to the UK BioBank folder structure we chose to have processed data nested rather then as a top level derivatives folder. At the moment the structural and functional data are provided for each subject in the **anat** and **func** subdirectories. See below for an overview of the standard file and folder structure.

Phenotypic data is currently stored in **../Data_Phenotype/**. This folder contains all text files of available data. As tempting as it may be, please **DO NOT** copy this file to a local directory to play with.

```{r, echo=TRUE}
# ~/Data_Imaging/  
# #               .../subID/  
# .
# └── ses-baseline-year1
#     ├── anat
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_T1w.json
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_T1w.nii
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_T2w.json
#     │   └── <sub>_ses-baselineYear1Arm1_run-01_T2w.nii
#     ├── dMRI
#     │   ├── AMICO >> contains the NODDI derivatives
#     │   ├── dMRI_img >> contains the processed DWI images (e.g. FA, MD etc.)
#     │   ├── parcellations >> contains subdirectories for each parcellation scheme and the extracted values in a txt file
#     │   ├── registrations >> registrations to the T1 image and accompanying brainmasks
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_dwi.bval
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_dwi.bvec
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_dwi.json
#     │   ├── <sub>_ses-baselineYear1Arm1_run-01_dwi.nii.gz
#     │   └── <sub>_ses-baselineYear1Arm1_run-01_dwi.scheme
#     ├── fmap >> currently empty
#     ├── func >> unprocessed resting-state data
#     │   ├── <sub>_ses-baselineYear1Arm1_task-rest_run-01_bold.json
#     │   ├── <sub>_ses-baselineYear1Arm1_task-rest_run-01_bold.nii
#     │   ├── <sub>_ses-baselineYear1Arm1_task-rest_run-01_motion.tsv
#     │   ├── ...
#     │   ├── <sub>_ses-baselineYear1Arm1_task-rest_run-04_bold.json
#     │   ├── <sub>_ses-baselineYear1Arm1_task-rest_run-04_bold.nii
#     │   └── <sub>_ses-baselineYear1Arm1_task-rest_run-04_motion.tsv
#     ├── proc_struct >> processed structural T1, warps to MNI, tissue maps etc.
#     │   ├── <sub>_t1w_1mm_lMNI152_brain.nii.gz
#     │   ├── <sub>_t1w_1mm_native_brain.nii.gz
#     │   ├── <sub>t1w_1mm_nlMNI152_brain_pve_0.nii.gz
#     │   ├── <sub>t1w_1mm_nlMNI152_brain_pve_1.nii.gz
#     │   ├── <sub>t1w_1mm_nlMNI152_brain_pve_2.nii.gz
#     │   └── <sub>_t1w_1mm_nlMNI152.nii.gz
#     │   └── ...
#     ├── segmentations >> fslfirst subocrtical segmentations
#     │   └── fslfirst
#     ├── surfaces >> freesurfer directory
#     │   ├── conte69 >> freesurfer mapped to Conte69
#     │   └── <sub> >> standard freesurfer output, including a parcellations folder for the standard freesurfer output
#     └── xfms >> warping directory containing the warps generated for output in proc_struct
#         ├── <sub>_lmni2nlmni_1mm.nii.gz
#         ├── <sub>native2lmni_1mm.omat
#         ├── <sub>native2nlmni_1mm.nii.gz
#         └── <sub>nlmni2native_1mm.nii.gz
#
```

## Structural imaging

### Freesurfer reconstruction
Freesurfer reconstructions have currently been completed succesfully for +/- 11000 datasets using the combined T1 and T2 HCP freesurfer pipeline, see [here](https://www.ncbi.nlm.nih.gov/pubmed/23668970) for more information. They can be found in **~/surfaces/**. Euler indices have been computed as a proxy measure for the quality of the freesurfer reconstruction. For more information on this index see the NeuroImage article on it [here](https://www.ncbi.nlm.nih.gov/pubmed/29278774). Reconstructions include the brainstem [substructure parcellations](http://www.nmr.mgh.harvard.edu/~iglesias/pdf/Neuroimage_2015_brainstem.pdf).   

Pipeline development, analyses, quality control and parcellations of these freesurfer reconstructions were done by Rafael Romero-Garica (rr480), Lisa Ronan (lr344) and Richard A.I. Bethlehem (rb643). When you make use of the freesurfer or parcellated data, please include these people accordingly on any manuscript. Some basic quality control can be found [here](/PostProcessing/).

### Structural Parcellation
Freesurfer reconstructions have been parcellated using the *desikan killiany atlas*, our in-house *308 parcellation*, the *glasser parcellation*, the *scheaffer200* and *schaeffer400* parcellations and some more fine-grained parcellations (suggestions on which to include in future updates are welcome). All stats files for each respective parcellation can be found in the freesurfer **~/surfaces/{subID}/stats** subdirectory.

### Diffusion weighted imaging
As of May 2020 diffusion weighted data has been made available for approximately 10000 subjects. Minimally processed DTI data was used (include pre and post Eddy correction and gradient unwarping) and we subsequently used [FSLs dti fit](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide) to reconstruct FA and MD maps and we used the [AMICO](https://github.com/daducci/AMICO) toolset to generate NODDI maps . The diffusion directory also contains parcellated files for FA, MD and NODDI for the same parcellation templates as mentioned above.
