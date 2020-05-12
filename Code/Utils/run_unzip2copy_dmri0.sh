#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
file=$1
dataDir=/rds/project/rb643/rds-rb643-abcd/Data_Imaging

rawDir=/rds/project/rb643/rds-rb643-abcd/Data_Raw/dMRI

# change to your subject list
#for file in `cat redodwi.txt` ; do
#for file in NDARINV00J52GPG_baselineYear1Arm1_ABCD-MPROC-DTI_20180906170146.tgz ; do
# check for a single subject first

  #for sub in NDARINV085CYDEZ; do
    subject='sub-'${file:0:15}
    echo 'subject: ' ${subject}
    tmpDir=/rds/project/rb643/rds-rb643-abcd/Temp/${subject}

    # make temp unzip directory
    mkdir -p ${tmpDir}
    # unzip it
    tar -xf ${rawDir}/${file} --directory ${tmpDir}
    # copy it to the right directory
    if [ -d ${tmpDir}/${subject}/ses-baselineYear1Arm1/dwi/ ]; then
    mkdir -p ${dataDir}/${subject}/ses-baseline-year1/dMRI/
    mv ${tmpDir}/${subject}/ses-baselineYear1Arm1/dwi/* ${dataDir}/${subject}/ses-baseline-year1/dMRI/
    # remove the temp folder
    rm -R ${tmpDir}
    fi
    #rm ${subfile}

#done
