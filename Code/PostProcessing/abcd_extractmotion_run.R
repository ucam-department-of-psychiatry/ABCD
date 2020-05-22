source("abcd_extractmotions.R")

df <- read.table('abcd_allsubs.txt',header=FALSE)
df$NewID <- paste("sub-",df$V1,sep="")
basepath <- "/rds/project/rb643/rds-rb643-abcd/Data_Imaging"

output <- data.frame()
for (i in unique(df$NewID)) {
  inputfile <- paste(basepath,i,'ses-baseline-year1','func',paste0(i,'_ses-baselineYear1Arm1_task-rest_run-01_motion.tsv'),sep = .Platform$file.sep)
  if(file.exists(inputfile)){
    print(i)
    try({
    tempOut <- as.data.frame(extractMotionParams(inputfile))
    tempOut$eid <- i
    output <- rbind(output,tempOut)
    })
  }
}
