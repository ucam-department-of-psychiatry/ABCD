#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory
dataDir=/rds/project/rb643/rds-rb643-abcd/Data_Imaging

# change to your subject list
#for sub in `cat allsubs.txt` ; do
for sub in NDARINVX6WEX0YJ ; do
subject='sub-'${sub}

basedir=${dataDir}/${subject}

if [ -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T1w.nii ] && [ -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T2w.nii ]
then
echo 'submitted' ${subject}
sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643/rds-rb643-abcd/logs/${subject}_fs.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=20:00:00 --mem=12000 run_freesurfer_subT2.sh ${subject}

elif [ -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T1w.nii ] && [ ! -e ${basedir}/ses-baseline-year1/anat/${subject}_ses-baselineYear1Arm1_run-01_T2w.nii ] 
then
echo 'submitted'
sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643/rds-rb643-abcd/logs/${subject}_fslogT1.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=20:00:00 --mem=12000 run_freesurfer_subT1.sh ${subject}

fi

done
