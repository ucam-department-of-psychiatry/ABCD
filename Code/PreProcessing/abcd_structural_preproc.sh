#!/bin/bash

# load all defaults
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0

baseDirectory=$1
mprageTag=$2
templateDirectory=$3
mmResolution=$4
subject=$5

anatDirectory="$baseDirectory"/anat
finalDirectory="$baseDirectory"/proc_struct
processingDirectory="$baseDirectory"/tmpProcessingStructural
warpDirectory="$baseDirectory"/xfms
firstDirectory="$baseDirectory"/segmentations/fslfirst/
echo $subject

# Make directories - exit if processing directory already exists (to prevent deletion of existing files at the end of this script).
if [[ -d "$processingDirectory" ]]; then
    echo "ERROR: processing directory already exists. Please manually delete this directory and rerun."
    return 2
fi
for x in "$finalDirectory" "$warpDirectory" "$processingDirectory" "$firstDirectory"; do
    [[ ! -d "$x" ]] && mkdir -p "$x"
done

# Skip merge scan if output exists
if [[ ! -e "$firstDirectory"/"$subject"_first_native_all_fast_firstseg.nii.gz ]]; then
    # Reorient to FSL space
    for rawNifti in `find $anatDirectory -mindepth 1 -maxdepth 1 -regextype posix-extended -regex "$mprageTag"`; do
        voxelsize=`fslinfo "$rawNifti" | grep pixdim2 | awk '{printf("%1.1f\n",$2)}'` # Assumes isotropic voxels.
        voxelsize=${voxelsize%.0}
        3dresample -orient RPI -prefix "$processingDirectory"/"$subject"_t1w_"$voxelsize"mm_native.nii.gz -inset "$rawNifti"
    done

  for x in `find "$processingDirectory" -name "*mm_native.nii.gz"`; do

    voxelsize=`fslinfo "$x" | grep pixdim2 | awk '{printf("%1.1f\n",$2)}'` # Assumes isotropic voxels.
    voxelsize=${voxelsize%.0}
    cp $x "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native.nii.gz

  done


    # Brain extraction and subcortical structure labels.
    bet "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native.nii.gz "$processingDirectory"/bet.nii.gz  -B -f 0.1
bet "$processingDirectory"/bet.nii.gz "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native_brain.nii.gz -R -f 0.3
    run_first_all -b -i "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native_brain.nii.gz -o "$firstDirectory"/"$subject"_first_native.nii.gz
    fast "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native_brain.nii.gz
else
    voxelsize=`find "$finalDirectory" -name "*native_brain.nii.gz" | grep -Eo "[0-9].[0-9]+mm_native" | grep -Eo "[0-9].[0.9]+"`
fi

# Loop over all requested templates - could use a check for whether the template and the mask exists.
for mm in $mmResolution; do
    if [[ ! -e "$finalDirectory"/"$subject"_t1w_"$mm"mm_nlMNI152_brain_pve_0.nii.gz ]]; then
        # Register to MNI space and store warps.
        flirt  -ref "$templateDirectory"/MNI152_T1_"$mm"mm_brain.nii.gz -in "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native_brain.nii.gz -out "$finalDirectory"/"$subject"_t1w_"$mm"mm_lMNI152_brain.nii.gz -omat "$warpDirectory"/"$subject"_native2lmni_"$mm"mm.omat -cost mutualinfo -searchcost mutualinfo -dof 12 -interp trilinear
        fnirt --ref="$templateDirectory"/MNI152_T1_"$mm"mm_brain.nii.gz --in="$finalDirectory"/"$subject"_t1w_"$mm"mm_lMNI152_brain.nii.gz --fout="$warpDirectory"/"$subject"_lmni2nlmni_"$mm"mm.nii.gz --interp=linear --refmask="$templateDirectory"/MNI152_T1_"$mm"mm_brain_mask.nii.gz

        # Create warps
        convertwarp -m "$warpDirectory"/"$subject"_native2lmni_"$mm"mm.omat -w "$warpDirectory"/"$subject"_lmni2nlmni_"$mm"mm.nii.gz -r "$templateDirectory"/MNI152_T1_"$mm"mm_brain.nii.gz -o "$warpDirectory"/"$subject"_native2nlmni_"$mm"mm.nii.gz
        invwarp -w "$warpDirectory"/"$subject"_native2nlmni_"$mm"mm.nii.gz -o "$warpDirectory"/"$subject"_nlmni2native_"$mm"mm.nii.gz -r "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native_brain.nii.gz

        # Warp the data
        flirt -in "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native.nii.gz -out "$finalDirectory"/"$subject"_t1w_"$mm"mm_lMNI152.nii.gz  -ref "$templateDirectory"/MNI152_T1_"$mm"mm_brain.nii.gz -applyxfm -init "$warpDirectory"/"$subject"_native2lmni_"$mm"mm.omat
        applywarp -i "$finalDirectory"/"$subject"_t1w_"$voxelsize"mm_native.nii.gz -o "$finalDirectory"/"$subject"_t1w_"$mm"mm_nlMNI152.nii.gz -r "$templateDirectory"/MNI152_T1_"$mm"mm_brain.nii.gz -w "$warpDirectory"/"$subject"_native2nlmni_"$mm"mm.nii.gz

        # Tissue classification
        bet "$finalDirectory"/"$subject"_t1w_"$mm"mm_nlMNI152.nii.gz "$processingDirectory"/bet_nl.nii.gz  -B -f 0.1
  bet "$processingDirectory"/bet_nl.nii.gz "$finalDirectory"/"$subject"_t1w_"$mm"mm_nlMNI152_brain.nii.gz -R -f 0.3
        fast "$finalDirectory"/"$subject"_t1w_"$mm"mm_nlMNI152_brain.nii.gz
    fi
done

# Clear temporary files. Add some checks to be sure there's little chance of unintentional deletes.
find "$processingDirectory" -mindepth 1 -maxdepth 1 -type f -regextype posix-extended -regex ".*[.omat|.mif|.nii.gz|.BRIK|.HEAD|.log|.mnc|.imp]" -delete

# Remove processing directory
find "$processingDirectory" -mindepth 0 -maxdepth 0 -type d -empty -delete
