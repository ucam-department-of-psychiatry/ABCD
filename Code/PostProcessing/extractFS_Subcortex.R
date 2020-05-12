## Generic function to:
## Extract variables from a parcellated freesurfer fileset

## By:
## Richard A.I. Bethlehem
## University of Cambridge
## ©rb643 2019

## EXAMPLE USAGE:
## extractFS_Subcortex("UKB1000028,"./Data_Imaging","aseg.stats",4)
## 4 corresponds to cortical thickness

extractFS_Subcortex <-
  function(ID,
           basepath,
           statsfile,
           measureofinterest,
           ...) {
    
    subject <- ID
    pathtostatsfile <- paste(basepath,
            subject,"surfaces",
            subject,"stats",
            sep = .Platform$file.sep)
    statsfile <- paste(pathtostatsfile, statsfile, sep = .Platform$file.sep)
    numberoflinestoskip <- 80
    volume <- 4
    label <- 5
    
    #temporary hack...
    tempVol <-as.data.frame(t(read.table(statsfile, skip = numberoflinestoskip, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[,volume]))
    colnames(tempVol) <- read.table(statsfile, skip = numberoflinestoskip, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[,label]
    tempVol$NewID <- subject
    
    return(tempVol)
    
  }
