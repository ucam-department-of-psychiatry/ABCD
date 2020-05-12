#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables

# change to your subject list
#for sub in `cat allsubs.txt` ; do
# check for a single subject first
for file in `cat redodwi.txt`; do

  subject='sub-'${file:0:15}
  echo 'subject: ' ${subject}

sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643/rds-rb643-abcd/logs/unzipdwi/${subject}_unzip2copy_dmri.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=8000 run_unzip2copy_dmri0.sh ${file}


done
