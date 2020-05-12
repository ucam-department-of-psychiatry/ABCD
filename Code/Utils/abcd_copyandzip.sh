#!/bin/bash
#
# This script copies output file to a specific folder
#
#

dataDir=/rds/project/rb643-1/rds-rb643-abcd/Data_Imaging
transferFolder=/rds/project/rb643-1/rds-rb643-abcd/Data_Out/Asegstats/
mkdir -p $transferFolder

for sub in `cat abcd_allsubs.txt` ; do
	sub='sub-'${sub}

	if [ -e ${dataDir}/${sub}/ses-baseline-year1/surfaces/${sub}/stats/aseg.stats ]
	then
		echo 'copying aseg for: '${sub}
		cp ${dataDir}/${sub}/ses-baseline-year1/surfaces/${sub}/stats/aseg.stats $transferFolder/${sub}_aseg.stats
		#cp ${dataDir}/${sub}/func/fMRI/parcellations/HCP.fsaverage.aparc_seq/ts_sc2345.txt $transferFolder2/${sub}_ts_sc2345.txt
		#cp ${dataDir}/${sub}/surfaces/${sub}/surf/rh.thickness.fsaverage.mgh $transferFolder/rh_ct_nosmooth/${sub}_rh.thickness.fsaverage.mgh
	fi

done
