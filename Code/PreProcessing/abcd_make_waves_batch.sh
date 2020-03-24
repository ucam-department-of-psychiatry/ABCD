#!/bin/bash
# This script submits freesurfer jobs   Set up variables subject
#directory within BIDS structure

# change to overearching bids directory
topdir=/rds/project/rb643/rds-rb643-abcd/
datadir=${topdir}/Data_Imaging
tpatt="seq"


# change to your subject list
for sub in `cat abcd_allsubs.txt` ; do
  #for sub in NDARINVX6WEX0YJ ; do
  for ses in ses-baselineYear1Arm1 ; do
    for run in 'cat abcd_allruns.txt' ; do

      rs_dir=${datadir}/${sub}/${ses}/func

      if [ -e ${rs_dir}/${sub}_${ses}_task-rest_${run}_bold.nii ]
      then

        echo 'working on: ' ${sub} 'run: ' ${run} 'session: ' ${ses}

        sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${topdir}/logs/rs/${sub}_${ses}_rslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=05:00:00 --mem=48000 abcd_make_waves_nt.sh ${sub} ${ses} ${run} ${tpatt}

      fi
    done
  done
done
