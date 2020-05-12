#!/bin/bash
#####
# Calculate and extract FA and MD values
# Rafael Romero Garcia
# rr480@cam.ac.uk(opens in new tab)
# University of Cambridge 2020
#####
#First paratemer $sub is the name of the folder of the subject that want to be processed
#Second parameter is the folder where the freesurfer folders are located

module load afni/17.0.00
module load fsl/6.0.1
module load matlab/r2019b
module load freesurfer/6.0.0

sub=$1

assessment=$2

path_data=/rds/project/rb643/rds-rb643-abcd/Data_Imaging
#path_data=/home/rr480/new/
path_subj=${path_data}/${sub}/${assessment}/
SUBJECTS_DIR=$path_subj/surfaces/
cd $SUBJECTS_DIR
if [ -f ${SUBJECTS_DIR}/${sub}/label/rh.aparc.annot ] && [ ! "${sub}" = 'fsaverage' ]; then
echo 'setting up dirs'
		path_out=${path_subj}/dMRI/parcellations/
		path_out_reg=${path_subj}/dMRI/registrations/
		path_bvals="$(ls ${path_subj}/dMRI/*.bval)"
		path_bvecs="$(ls ${path_subj}/dMRI/*.bvec)"
		mkdir -p ${path_out}
		mkdir -p ${path_out_reg}
echo 'gzipping files'
		if [ -f ${path_subj}/dMRI/*.nii ]; then
			path_dwi="$(ls ${path_subj}/dMRI/*.nii)"
			gzip ${path_dwi}
			path_dwi=${path_dwi}.gz
		elif [ -f ${path_subj}/dMRI/*.nii.gz ]; then
			path_dwi="$(ls ${path_subj}/dMRI/*.nii.gz)"
		else
			path_dwi=${path_dwi}.gz
		fi

echo 'Skullstripping dwi'
		path_dwi_brain=${path_out}/dwi_brain.nii.gz
		if [ ! -f $path_dwi_brain ]; then
			bet $path_dwi $path_dwi_brain -f 0.3
		fi


		path_t1=${SUBJECTS_DIR}/${sub}/mri/brainmask.nii.gz
echo 'mri convert brainmask'
		if [ ! -f $path_t1 ]; then
			mri_convert ${SUBJECTS_DIR}/${sub}/mri/brainmask.mgz $path_t1
		fi
		if [ ! -f ${path_out_reg}/dwi2t1.txt ]; then
echo 'Corregistering'
			flirt 	-in ${path_dwi_brain} -ref ${path_t1} -out $path_out_reg/dwi_t1space.nii.gz -omat ${path_out_reg}/dwi2t1.txt
			convert_xfm -omat $path_out_reg/t12dwi.txt -inverse $path_out_reg/dwi2t1.txt
		fi
		path_voxel=${path_subj}/dMRI/dMRI_img/
		mkdir -p ${path_voxel}
		path_brain_mask_dwi=${path_out_reg}/brainmask_dwispace.nii.gz
		if [ ! -f ${path_brain_mask_dwi} ]; then
			flirt 	-in $path_t1 -ref ${path_dwi_brain} -applyxfm -init ${path_out_reg}/t12dwi.txt -out $path_out_reg/t1_dwispace.nii.gz
			fslmaths $path_out_reg/t1_dwispace.nii.gz -thr 0 -bin $path_out_reg/brainmask_dwispace.nii.gz
		fi
		if [ ! -f ${path_voxel}/dti_FA.nii.gz ]; then
			dtifit -k ${path_dwi_brain} -b ${path_bvals} -r ${path_bvecs} -m ${path_brain_mask_dwi} --sse --save_tensor -o ${path_voxel}/'dti'
		fi
	for parcellation_name in  500_sym.aparc 500.aparc sjh PALS_B12_Lobes aparc HCP.fsaverage.aparc Schaefer_200 Schaefer_400 ; do
		parcellation=${parcellation_name}_seq
		path_par_out=${path_out}/${parcellation}/
		path_par=${path_out}/${parcellation}_dwiSpace.nii.gz
		path_fa=${path_subj}/dMRI/dMRI_img/dti_FA.nii.gz
		path_md=${path_subj}/dMRI/dMRI_img/dti_MD.nii.gz
		mkdir -p ${path_par_out}
		if [ ! -f ${path_out}/${parcellation}_dwiSpace.nii.gz ]; then
			echo "Corregistering ${parcellation}"
			flirt 	-in ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz -ref ${path_dwi_brain} -interp nearestneighbour -applyxfm -init ${path_out_reg}/t12dwi.txt -out ${path_out}/${parcellation}_dwiSpace.nii.gz
		fi
		if [ -f $path_par ]; then
			if [ -f $path_fa ]; then
				if [ ! -f $path_out/FA.txt ]; then
					3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_fa > ${path_par_out}/FA.txt
				fi
			  else
			  	echo "FA not found: $path_fa"
			fi
			if [ -f $path_md ]; then
				if [ ! -f $path_out/MD.txt ]; then
					3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_md > ${path_par_out}/MD.txt
				fi
			  else
			  	echo "FA not found: $path_md"
			fi
		else
			echo "Parcellation not found: $path_par"
		fi
	done
fi
