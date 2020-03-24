#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables

# change to your subject list
#for sub in `cat allsubs.txt` ; do
# check for a single subject first
for sub in NDARINVHLKBLZ33; do
subject=${sub}

sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643/rds-rb643-abcd/logs/${subject}_unzip2copy.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:15:00 --mem=8000 run_unzip2copy_sub.sh ${subject}


done
