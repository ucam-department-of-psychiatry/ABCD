#!/bin/bash

# load all defaults
echo 'loading modules'
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0
module load gcc/8
source /home/rb643/Py37/bin/activate

# set inputs
sub=$1
ses=$2

# set directories
echo 'setting up dirs'
topdir=/rds/project/rb643/rds-rb643-abcd/
datadir=${topdir}/Data_Imaging
dwidir=${datadir}/${sub}/${ses}/dMRI
fsdir=${datadir}/${sub}/${ses}/surfaces/${sub}

# get the brainmask
echo 'copying mask and dwi-file'
cp ${dwidir}/registrations/brainmask_dwispace.nii.gz ${dwidir}/brainmask_dwispace.nii.gz
cp ${dwidir}/registrations/dwi_brain.nii.gz ${dwidir}/dwi_brain.nii.gz

# run
echo 'running AMICO'
cd ${dwidir}
python ${topdir}/Code/abcd_amico_noddi.py ${sub}_ses-baselineYear1Arm1_run-01_dwi ${datadir}/${sub}/${ses}/ ${dwidir}/brainmask_dwispace.nii.gz

echo 'cleaning up folders'
rm ${dwidir}/brainmask_dwispace.nii.gz
rm ${dwidir}/dwi_brain.nii.gz
echo 'removing kernels'
rm -R ${datadir}/${sub}/${ses}/kernels
