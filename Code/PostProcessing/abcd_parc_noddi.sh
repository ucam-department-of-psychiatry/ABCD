#!/bin/bash
#####

module load afni/17.0.00
module load fsl/6.0.1
module load matlab/r2019b
module load freesurfer/6.0.0

sub=$1
assessment=$2

path_data=/rds/project/rb643/rds-rb643-abcd/Data_Imaging
#path_data=/home/rr480/new/
path_subj=${path_data}/${sub}/${assessment}/dMRI

for parcellation_name in  500_sym.aparc 500.aparc sjh PALS_B12_Lobes aparc HCP.fsaverage.aparc Schaefer_200 Schaefer_400 ; do
  parcellation=${parcellation_name}_seq
  path_par_out=${path_subj}/parcellations/${parcellation}/
  path_par=${path_subj}/parcellations/${parcellation}_dwiSpace.nii.gz
  path_ISOVF=${path_subj}/AMICO/NODDI/FIT_ISOVF.nii.gz
  path_OD=${path_subj}/AMICO/NODDI/FIT_OD.nii.gz
  path_ICVF=${path_subj}/AMICO/NODDI/FIT_ICVF.nii.gz

  if [ -f $path_par ]; then
    if [ -f $path_ISOVf ]; then
      if [ ! -f $path_out/NODDI_ISOVF.txt ]; then
        3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_ISOVF > ${path_par_out}/NODDI_ISOVF.txt
      fi
      else
        echo "ISOVF not found: $path_ISOVF"
    fi
    if [ -f $path_OD ]; then
      if [ ! -f $path_out/NODDI_OD.txt ]; then
        3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_OD > ${path_par_out}/NODDI_OD.txt
      fi
      else
        echo "OD not found: $path_md"
    fi

    if [ -f $path_ICVF ]; then
      if [ ! -f $path_out/NODDI_ICVF.txt ]; then
        3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_ICVF > ${path_par_out}/NODDI_ICVF.txt
      fi
      else
        echo "ICVF not found: $path_md"
    fi

  else
    echo "Parcellation not found: $path_par"
  fi
done
