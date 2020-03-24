#!/bin/bash
#
# This script run freesurfer on HPC
#
#
# Set up variables

# subject directory within BIDS structure
subject=$1

echo $subject
# change to overearching bids directory
dataDir=/rds/project/rb643/rds-rb643-abcd/Data_Imaging
basedir=${dataDir}/${subject}
surfdir=${basedir}/ses-baseline-year1/surfaces/
tmpDIR=/home/rb643/TempDir

# set up and make necessary subfolders
mkdir -p ${surfdir}
mkdir -p ${tmpDIR}

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

# Run freesurufer
recon-all -subject ${subject} -i ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T1w.nii -T2 ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T2w.nii -T2pial -all -no-isrunning


