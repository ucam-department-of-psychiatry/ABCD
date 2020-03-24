#!/bin/bash
#
# This counts existing files
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory
dataDir=/rds/project/rb643/rds-rb643-abcd/Data_Imaging

# change to your subject list
for sub in `cat allsubs.txt` ; do
subject='sub-'${sub}

basedir=${dataDir}/${subject}
#echo ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T1w.nii
if [ -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T1w.nii ] && [ -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T2w.nii ]
then

echo ${subject}

fi

done
