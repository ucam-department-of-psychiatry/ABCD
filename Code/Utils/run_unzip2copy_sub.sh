#!/bin/bash
#
# This script runs custom R code on HPC
#
#
# Set up variables

# subject directory within BIDS structure
subject=$1

echo $subject
export TMPDIR=${tmpDIR}

# Run R
Rscript abcd_unzip2copy_bash.R ${subject}



