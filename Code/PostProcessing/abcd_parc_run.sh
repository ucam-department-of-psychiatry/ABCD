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
for sub in `cat abcd_allsubs.txt` ; do
#for sub in NDARINVX6WEX0YJ ; do
subject='sub-'${sub}
session='ses-baseline-year1'

basedir=${dataDir}/${subject}

if [ -d ${basedir}/ses-baseline-year1/dMRI/ ]; then
echo 'submitting dwi pipeline for: ' ${subject}
sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643/rds-rb643-abcd/logs/parcnoddi/${subject}_noddi.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:30:00 --mem=8000 abcd_parc_noddi.sh $subject $session

fi

done
