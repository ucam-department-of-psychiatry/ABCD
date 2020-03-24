## write a script to extract and copy files
abcd_unzip2copy <- function(subject,...){

library(data.table)
#subject = "NDARINVZZZP87KR"

basedir = '/rds/project/rb643/rds-rb643-abcd/Data_Imaging'
tempdir = '/rds/project/rb643/rds-rb643-abcd/Temp/'
dir.create(tempdir)
# get subject name and session ID
  
 # setup subjects output directories anat, func and fmap for subject that don't have an output yet
 if(!dir.exists(paste(basedir,paste('sub-',subject,sep = ""),sep=.Platform$file.sep))){
   
    print(paste('working on: ', subject, sep=""))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),sep=.Platform$file.sep))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1',sep=.Platform$file.sep))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','anat',sep=.Platform$file.sep))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','func',sep=.Platform$file.sep))
    dir.create(paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','fmap',sep=.Platform$file.sep))
 } 
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
  file.copy(anatFiles,paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','anat',sep=.Platform$file.sep))
  
  funcFiles <- list.files(list.dirs(tempdir)[list.dirs(tempdir) %like% "func" & list.dirs(tempdir) %like% "baseline"], 
                       full.names = TRUE)
  file.copy(funcFiles,paste(basedir,paste('sub-',subject,sep = ""),'ses-baseline-year1','func',sep=.Platform$file.sep))
  
  # clean up the temporary directory 
  unlink(list.dirs(tempdir),recursive = T)
  
}
