#!/bin/bash

module load afni
module load freesurfer
module load fsl
module load afni
module load rstudio


subject=$1
dataDir=$2

echo 'working on ' $subject
assessment='ses-baseline-year1'
basedir=${dataDir}/${subject}/${assessment}
surfdir=${basedir}/surfaces/${subject}/
vol2surf=${basedir}/surfaces/vol2surf_DWI
tmpDIR=${basedir}/TempDir/
dwiDIR=${basedir}/dMRI/dMRI_img//
noddiDIR=${basedir}/dMRI/AMICO/NODDI/
parDIR=${surfdir}/parcellation/

parcellation=HCP.fsaverage.aparc
SUBJECTS_DIR=${basedir}/surfaces/



if [ -f ${basedir}/dMRI/*.nii ]; then
	path_dwi="$(ls ${basedir}/dMRI/*.nii)"
	gzip ${basedir}
	path_dwi=${basedir}.gz
elif [ -f ${basedir}/dMRI/*.nii.gz ]; then
	path_dwi="$(ls ${basedir}/dMRI/*.nii.gz)"
else
	path_dwi=${basedir}.gz
fi

echo "Checking:  $vol2surf/parcellations/${parcellation}/dti_FA_rh.txt"
if [ ! -f $vol2surf/parcellations/${parcellation}/dti_FA_rh.txt ]; then

if [ ! -f ${surfdir}/mri/T1.nii ]; then
echo 'Converting'
	mri_convert -i ${surfdir}/mri/T1.mgz -o ${surfdir}/mri/T1.nii
fi


if [ ! -f "$vol2surf"/bbregister/DWI_to_T1.lta ]; then
	mkdir -p "$vol2surf"/bbregister/
	bbregister --s "$subject" --mov $path_dwi --reg "$vol2surf"/bbregister/DWI_to_T1.lta --init-fsl --dti
fi


#ConvertSurface -i_gii ${vol2surf}/NODDI_ICVF_lh_al2surf.func.gii -o_fs ${vol2surf}/NODDI_ICVF_lh_al2surf.func.pial

cd ${surfdir}
echo "Checking SUMA"
if [ ! -f  ${surfdir}/SUMA/std.60.rh.thickness.niml.dset ]; then
	echo "running SUMA"
	rm -r /SUMA/
	@SUMA_Make_Spec_FS -NIFTI -sid ${subject} -fs_setup
	gzip *.nii
fi


#declare -a files=("NODDI_ISOVF" "NODDI_ICVF" "NODDI_OD" "dti_MD" "dti_FA")
declare -a files=("FIT_ICVF" "FIT_OD" "FIT_ISOVF" "dti_MD" "dti_FA")


for hemi in lh rh; do
	[[ $hemi == lh ]] && hemisphere=l || hemisphere=r
	if [ ! -f ${vol2surf}/${hemi}_thickness_std60.func.gii ]; then
		ConvertDset -o_gii -input ${surfdir}/SUMA/std.60.${hemi}.thickness.niml.dset -prefix ${vol2surf}/${hemi}_thickness_std60.func.gii
	fi


	for file in ${files[@]}; do
echo "checking vol2vol"
	if  [ ! -f $vol2surf/${file}_T1space.nii.gz ]; then

		if [ -f $dwiDIR/${file}.nii.gz ]; then
			p_file=$dwiDIR/${file}.nii.gz
		elif [ -f $noddiDIR/${file}.nii.gz ]; then
			p_file=$noddiDIR/${file}.nii.gz
		else
			echo "ERROR file not found:  $dwiDIR/${file}.nii.gz "
		fi		
		mri_vol2vol  	--reg "$vol2surf"/bbregister/DWI_to_T1.lta \
				--mov ${p_file} \
				--fstarg \
				--o $vol2surf/${file}_T1space.nii.gz 
	fi

echo "Checking $vol2surf/${file}_T1space_al2std60_${hemi}.func.gii "
	if [ ! -f  $vol2surf/${file}_T1space_al2std60_${hemi}.func.gii ]; then

		wb_command -volume-to-surface-mapping $vol2surf/${file}_T1space.nii.gz ${surfdir}/SUMA/std.60.${hemi}.pial.gii $vol2surf/${file}_T1space_al2std60_${hemi}.func.gii -myelin-style ${surfdir}/SUMA/${hemi}.ribbon.nii.gz ${vol2surf}/${hemi}_thickness_std60.func.gii 5
	fi


	if [ ! -f $vol2surf/${file}_T1space_al2std60_${hemi}.txt ]; then
		echo "Running WB_surf2table"
		Rscript /rds/project/rb643-1/rds-rb643-ukbiobank2/Code/WB_surf2table_giii.r $vol2surf/${file}_T1space_al2std60_${hemi}.func.gii $vol2surf/${file}_T1space_al2std60_${hemi}.txt
	fi

	if [ ! -f $vol2surf/surface/${file}_T1space_al2std60_back2sub_${hemi}.1D ]; then
		SurfToSurf -i_gii ${surfdir}/SUMA/${hemi}.sphere.gii -i_gii  ${surfdir}/SUMA/std.60.${hemi}.sphere.gii -data $vol2surf/${file}_T1space_al2std60_${hemi}.txt -prefix $vol2surf/${file}_T1space_al2std60_back2sub_${hemi}
		mkdir $vol2surf/surface/
		mv $vol2surf/${file}_T1space_al2std60_back2sub_${hemi}.1D  $vol2surf/surface/${file}_T1space_al2std60_back2sub_${hemi}.1D 	
	fi

	mkdir -p $vol2surf/parcellations/${parcellation}/

	if [ ! -f $vol2surf/parcellations/${parcellation}/${file}_${hemi}.txt ]; then
		Rscript /rds/project/rb643-1/rds-rb643-ukbiobank2/Code/WB_annot2table.r ${surfdir}/label/${hemi}.${parcellation}.annot $vol2surf/surface/${file}_T1space_al2std60_back2sub_${hemi}.1D $vol2surf/parcellations/${parcellation}/${file}_${hemi}.txt
	fi

	done

done
	rm -r ${surfdir}/SUMA/
	rm ${surfdir}/mri/orig/COR*
	find $vol2surf/ -maxdepth 1 -type f -delete
	rm ${surfdir}/surf/*.asc
fi
