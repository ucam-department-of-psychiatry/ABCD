#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
dataDir=/rds/project/rb643/rds-rb643-abcd/Data_Imaging

rawDir=/rds/project/rb643/rds-rb643-abcd/Data_Raw/dMRI

# change to your subject list
for sub in `cat allsubs.txt` ; do
# check for a single subject first

#for sub in NDARINV085CYDEZ; do
subject='sub-'${sub}
    tmpDir=/rds/project/rb643/rds-rb643-abcd/Temp/${subject}

    # get the tar file for that subject
    subfile="$(find ${rawDir}/ -name "${sub}_*.tgz")"
    echo "found: " ${subfile}
    # make temp unzip directory
    mkdir -p ${tmpDir}
    # unzip it
    tar -xf ${subfile} --directory ${tmpDir}
    # copy it to the right directory
    if [ -d ${tmpDir}/${subject}/ses-baselineYear1Arm1/dwi/ ]; then
    mkdir -p ${dataDir}/${subject}/ses-baseline-year1/dMRI/
    mv ${tmpDir}/${subject}/ses-baselineYear1Arm1/dwi/* ${dataDir}/${subject}/ses-baseline-year1/dMRI/
    # remove the temp folder
    rm -R ${tmpDir}
  fi
    #rm ${subfile}

done
