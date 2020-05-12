import amico
from sys import argv

subfile=argv[1]
subdir=argv[2]
basedir=argv[3]
sub=argv[4]

amico.core.setup()
ae = amico.Evaluation(basedir,sub)
amico.util.fsl2scheme([subdir + subfile + ".bval"],[subdir + subfile + ".bvec"]])

ae.load_data(dwi_filename = [subfile + ".nii"], scheme_filename = [subfile + ".scheme"], mask_filename = "brainmask_align.nii.gz" b0_thr = 0)
ae.set_model("NODDI")
ae.generate_kernels(regenerate=True)
ae.load_kernels()

ae.fit()
ae.save_results()

# amico.core.setup()
# ae = amico.Evaluation("/home/rb643/Scratch","dwi")
# amico.util.fsl2scheme("/home/rb643/Scratch/dwi/sub-NDARINVW3GNFYF3_ses-baselineYear1Arm1_run-02_dwi.bval","/home/rb643/Scratch/dwi/sub-NDARINVW3GNFYF3_ses-baselineYear1Arm1_run-02_dwi.bvec")
#
# ae.load_data(dwi_filename = "sub-NDARINVW3GNFYF3_ses-baselineYear1Arm1_run-02_dwi.nii", scheme_filename = "sub-NDARINVW3GNFYF3_ses-baselineYear1Arm1_run-02_dwi.scheme", b0_thr = 0)
# ae.set_model("NODDI")
# ae.generate_kernels()
# ae.load_kernels()
#
# ae.fit()
# ae.save_results()
