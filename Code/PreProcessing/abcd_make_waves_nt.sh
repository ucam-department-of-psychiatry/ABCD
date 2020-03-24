#!/bin/bash
sub=$1
ses=$2
run=$3
tpatt=$4

# load all defaults
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0

# set up the xdg renderer
xdgDir=/home/rb643/TempDir/${sub}_${ses}
mkdir -p ${xdgDir}
export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${ses}

export MATLABPATH=/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

# setup directories
topdir=/rds/project/rb643/rds-rb643-abcd/
datadir=${topdir}/Data_Imaging

t1w_dir=${datadir}/${sub}/${ses}/anat
rs_dir=${datadir}/${sub}/${ses}/func
freesurfer_dir=${datadir}/${sub}/${ses}/surfaces/${sub}
procdir=${datadir}/${sub}/${ses}/xtmp/${run}/
procfunc=${datadir}/${sub}/${ses}/proc_func/${run}
qcfunc=${datadir}/${sub}/${ses}/proc_func/${run}/qc

mkdir -p ${procdir}
mkdir -p ${procfunc}
mkdir -p ${qcfunc}

# check t patterns
echo $tpatt

# copy and convert freesurfer
mri_convert --out_orientation RAS  -rt nearest --reslice_like ${t1w_dir}/${sub}_${ses}_${run}_T1w.nii ${freesurfer_dir}/mri/brain.mgz ${procdir}/${sub}_${ses}_brain.nii.gz

#cp ${rs_dir}/${sub}_${ses}_task-rest_acq-645_bold.nii.gz ${base_dir}/${sub}_${ses}_task-rest_acq-645_bold.nii.gz
cp ${rs_dir}/${sub}_${ses}_task-rest_${run}_bold.nii ${procdir}/${sub}_${ses}_task-rest_${run}_bold.nii

cd ${procdir}/
# run wavelet code
python /home/rb643/matlab/fmri_spt/speedyppX.py -d ${sub}_${ses}_task-rest_${run}_bold.nii -a ${sub}_${ses}_brain.nii.gz -o --wds --SP --EDOF --rmot --rmotd --rcsf --nobandpass --zeropad=100 --csftemp=MNI152 --csfpeel=6 --tpattern=${tpatt} --OVERWRITE

# generate some QC plots
echo "------- generating QC plots -------"
cd ${procdir}/
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/FD.py ${sub}_${ses}_task-rest_${run}_bold_motion.1D
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/SP.py ${sub}_${ses}_task-rest_${run}_bold_SP.txt

matlab -nodisplay -r "wavelet_qc('spp.${sub}_${ses}_task-rest_${run}_bold/${sub}_${ses}_task-rest_${run}_bold_sm.nii.gz','spp.${sub}_${ses}_task-rest_${run}_bold/${sub}_${ses}_task-rest_${run}_bold_wds.nii.gz');quit"
# check registration
echo "------- registration checks -------"
fslmaths ${sub}_${ses}_task-rest_${run}_bold_pp.nii.gz -Tmean mean_spp.nii.gz
source /home/rb643/py360/bin/activate
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/CheckReg.py ${sub}_brain.nii.gz mean_spp.nii.gz

# copy out needed files

echo "------- copying needed files -------"
cp QC_checkreg.png ${qcfunc}/QC_Checkreg.png
cp QC_Despiked.png ${qcfunc}/QC_Despiked.png
cp QC_FS.png ${qcfunc}/QC_FS.png
cp QC_SP.png ${qcfunc}/QC_SP.png

cp ${sub}_${ses}_task-rest_${run}_bold_EDOF.nii.gz ${procfunc}/${sub}_${ses}_task-rest_${run}_bold_EDOF.nii.gz
cp ${sub}_${ses}_task-rest_${run}_bold_motion.1D ${procfunc}/${sub}_${ses}_task-rest_${run}_bold_motion.1D
cp ${sub}_${ses}_task-rest_${run}_bold_motion_fd.txt ${procfunc}/${sub}_${ses}_task-rest_${run}_bold_motion_fd.txt
cp ${sub}_${ses}_task-rest_${run}_bold_pp.nii.gz ${procfunc}/${sub}_${ses}_task-rest_${run}_bold_pp.nii.gz
cp ${sub}_${ses}_task-rest_${run}_bold_SP.txt ${procfunc}/${sub}_${ses}_task-rest_${run}_bold_SP.txt
cp _spp_${sub}_${ses}_task-rest_${run}_bold.sh ${procfunc}/_spp_${sub}_${ses}_task-rest_${run}_bold.sh

# clean-up
echo "------- cleaning up -------"
rm -R ${xdgDir}
rm -R ${procdir}
