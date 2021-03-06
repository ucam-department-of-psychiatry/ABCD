#!/bin/bash
# This script submits freesurfer jobs   Set up variables subject
#directory within BIDS structure

# change to overearching bids directory
topdir=/rds/project/rb643/rds-rb643-abcd/
datadir=${topdir}/Data_Imaging
surfaceTemplateDirectory=/home/rb643/Tools/templates/conte69
aromadir=/home/rb643/Tools/ICA-AROMA-master


# change to your subject list
#for sub in `cat allsubs.txt` ; do
for sub in NDARINVX6WEX0YJ ; do
sub='sub-'${sub}
  for ses in ses-baselineYear1Arm1 ; do
    for run in `cat abcd_allruns.txt` ; do

			basedir=${datadir}/${sub}/ses-baseline-year1/
      rs_dir=${basedir}/func

			if [ -e ${rs_dir}/${sub}_${ses}_task-rest_${run}_bold.nii ]; then

       echo 'working on: ' ${sub} 'run: ' ${run} 'session: ' ${ses}

        sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem
--output=${topdir}/logs/rs/${sub}_${ses}_${run}_rslog.log --nodes=1 --ntasks=1
--cpus-per-task=1 --time=05:00:00 --mem=12000 abcd_functional_processing.sh
${basedir} ${sub} ${run} "1"  ${surfaceTemplateDirectory} ${aromadir}

      fi
    done
  done
done
