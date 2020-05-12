#!/bin/bash

# load all defaults
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0
module load gcc/8
souce /home/rb643/Py37/bin/activate

# set inputs
sub=$1
ses=$2

# set directories
topdir=/rds/project/rb643/rds-rb643-abcd/
datadir=${topdir}/Data_Imaging
dwidir=${datadir}/${sub}/${ses}/dMRI
fsdir=${datadir}/${sub}/${ses}/surfaces/${sub}

# get the brainmask
cp ${fsdir}/mri/brainmask.mgz ${dwidir}/brainmask.mgz
# convert it
mri_convert --out_orientation RAS ${dwidir}/brainmask.mgz ${dwidir}/brainmask.nii.gz
# align it
3dAllineate -base ${dwidir}/${sub}_ses-baselineYear1Arm1_run-01_dwi.nii -source ${dwidir}/brainmask.nii.gz -cmass -prefix ${dwidir}/brainmask_align.nii.gz

# run
python ${topdir}/Code/abcd_amico_noddi.py ${dwidir}/${sub}_ses-baselineYear1Arm1_run-01_dwi ${dwidir} ${datadir}/${sub}/${ses}/ ${sub}
