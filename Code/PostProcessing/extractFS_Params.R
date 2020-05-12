## Generic function to:
## Extract variables from a parcellated freesurfer fileset

## By:
## Richard A.I. Bethlehem
## University of Cambridge
## ©rb643 2019

## EXAMPLE USAGE:
## extractFS_Params("UKB1000028,"./Data_Imaging","lh.500_sym.aparc.log","rh.500_sym.aparc.log",4)
## 4 corresponds to cortical thickness

extractFS_Params <-
  function(ID,
           basepath,
           statsfile1,
           statsfile2,
           measureofinterest,
           ...) {

    subject <- ID
    pathtostatsfile <- paste(basepath,
            subject,"ses-baseline-year1/surfaces",
            subject,"stats",
            sep = .Platform$file.sep)
    statsfileLH <- paste(pathtostatsfile, statsfile1, sep = .Platform$file.sep)
    statsfileRH <- paste(pathtostatsfile, statsfile2, sep = .Platform$file.sep)
    numberoflinestoskip <- 15
    label <- 10

    #temporary hack...
    temp <-
      c(
        read.table(statsfileLH, skip = 14, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[2:182,measureofinterest],
        read.table(statsfileRH, skip = 14, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[2:182,measureofinterest]
      )
    temp <- as.data.frame(t(temp))
    tempLabel <-
      c(paste("lh_", as.character(
        read.table(statsfileLH, skip = 14, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[2:182,label]
      ), sep = ""),
      paste("rh_", as.character(
        read.table(statsfileRH, skip = 14, row.names = NULL, fill = TRUE, blank.lines.skip = FALSE, as.is = TRUE, strip.white = FALSE, skipNul = FALSE)[2:182,label]
      ), sep = ""))
    colnames(temp) <- tempLabel

    df <- temp
    df$NewID <- subject


    return(df)

  }
