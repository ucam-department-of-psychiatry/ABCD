library(dplyr)
library(data.table)

df <- read.table('abcd_allsubs.txt',header=FALSE)
df$NewID <- paste("sub-",df$V1,sep="")

# add the morphological variables
source("extractFS_Params.R")
output <- data.frame()
basepath <- "~/rds/rds-rb643-abcd/Data_Imaging/"
statsfile1 <- "lh.HCP.fsaverage.aparc.log"
statsfile2 <- "rh.HCP.fsaverage.aparc.log"

for (i in unique(df$NewID)) {
  inputfile <- paste(basepath,i,"ses-baseline-year1/surfaces",i,"stats",statsfile1,sep=.Platform$file.sep)
  if(file.exists(inputfile)) {
    print(i)
	try({
    tempOut <- as.data.frame(extractFS_Params(ID = i,
                                            basepath,
                                            statsfile1,
                                            statsfile2,
                                            measureofinterest = 2))
  output <- rbind(output,tempOut)
	})
  }
}

write.csv(output, file = '../Data_Out/HCP/Struct_Vol.csv')

output1 <- data.frame()
output2 <- data.frame()
output3 <- data.frame()
output4 <- data.frame()
source('alffmap.R')
parcellationfolder <- "HCP.fsaverage.aparc_seq"
parcellationfile <- "ts_raw.txt"
for (i in unique(df$NewID)) {
  inputfile <- paste(basepath,i,"func","fMRI","parcellations",parcellationfolder,parcellationfile,sep=.Platform$file.sep)
  if(file.exists(inputfile)) {
    set.seed(1)
    mat <- t(as.matrix(read.table(inputfile, header=FALSE, sep=",")))
    if(dim(mat)[2] == 376 && dim(mat)[1]== 490){
      print(i)
      tempOut <- as.data.frame(apply(mat,FUN=alffmap,MARGIN=2))
      tempMean <- as.data.frame(t(colMeans(mat)))
      tempSD <-  as.data.frame(t(sqrt(colSds(mat))))
      tempOut$ID <-tempMean$ID <- tempSD$ID <- i
      output1 <- rbind(output1,tempOut[1,])
      output2 <- rbind(output2,tempOut[2,])
      output3 <- rbind(output3,tempMean)
      output4 <- rbind(output4,tempSD)
    }
  }
}

write.csv(output1, file = '../Output/alff.csv')
write.csv(output2, file = '../Output/falff.csv')
write.csv(output3, file = '../Output/SignalMean.csv')
write.csv(output4, file = '../Output/SignalSdS.csv')



df <- read.table('Sublist.txt',header=FALSE)
df$NewID <- paste("UKB",df$V1,sep="")

# add the morphological variables
source("extractFS_Subcortex.R")
output <- data.frame()
basepath <- "~/rds/rds-rb643-ukbiobank2/Data_Imaging/"
statsfile <- "aseg.stats"

for (i in unique(df$NewID)) {
  inputfile <- paste(basepath,i,"surfaces",i,"stats",statsfile,sep=.Platform$file.sep)
  if(file.exists(inputfile)) {
    print(i)
    tempOut <- as.data.frame(extractFS_Subcortex(ID = i,
                                            basepath,
                                            statsfile,
                                            measureofinterest = 4))
  output <- rbind(output,tempOut)
  }
}
