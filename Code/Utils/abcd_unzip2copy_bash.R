#!/usr/bin Rscript
## write a script to extract and copy files
  # read in arguments
  args <- commandArgs(trailingOnly = TRUE)

  # get subject name
  subject <- as.character(args[1])
    print(paste('working on: ', subject, sep=""))

  
  # add library
  library(data.table)
  
  # set up temp directory
  basedir = '/rds/project/rb643/rds-rb643-abcd/Data_Imaging'
  tempdir = paste('/rds/project/rb643/rds-rb643-abcd/Temp_',subject,'/',sep="")
  if(!dir.exists(tempdir)){
  dir.create(tempdir)
  }

  # setup subjects output directories anat, func and fmap for subject that don't have an output yet
  if(!dir.exists(paste(basedir,paste('sub-',subject,sep = ""),sep=.Platform$file.sep))){
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),sep=.Platform$file.sep))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1',sep=.Platform$file.sep))
  }

  anatdir <- paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','anat',sep=.Platform$file.sep)
  funcdir <- paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','func',sep=.Platform$file.sep)
  fmapdir <- paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','fmap',sep=.Platform$file.sep)

  if(!dir.exists(anatdir)){ dir.create(anatdir)}
  if(!dir.exists(funcdir)){ dir.create(funcdir)}
  if(!dir.exists(fmapdir)){ dir.create(fmapdir)}
  
  # list all files for that subject
  allfiles <- list.files(path = '/rds/project/rb643/rds-rb643-abcd/Data_Raw/fmriresults01/',
                         pattern = subject, 
                         full.names = T,
                         include.dirs = F)
  
  # grab only T1, T2 and rsfMRI
  allfiles <- allfiles[allfiles %like% "MPROC-T1" | allfiles %like% "MPROC-T2" | allfiles %like% "MPROC-rsfMRI"]
  
  # extract all those to a temporary directory 
  for(file in allfiles){untar(file, exdir = tempdir)}
  # clean up the untarred files
  unlink(allfiles)
  
  # move selected files from temp directory to final directory
  anatFiles <- list.files(list.dirs(tempdir)[list.dirs(tempdir) %like% "anat" & list.dirs(tempdir) %like% "baseline"], 
                          full.names = TRUE) #, pattern = "run-01")
  file.copy(anatFiles,anatdir)
  
  funcFiles <- list.files(list.dirs(tempdir)[list.dirs(tempdir) %like% "func" & list.dirs(tempdir) %like% "baseline"], 
                          full.names = TRUE)
  file.copy(funcFiles,funcdir)
  
  # clean up the temporary directory 
  unlink(list.dirs(tempdir),recursive = T)
  

