extractEuler_run <- function() {
  filelist <- read.table('abcd_allsubs.txt')
  source("extractEuler.R")

  outp <- data.frame()

  for (i in filelist$V1) {
    eid <- paste('sub-', i, sep = "")
    inputdir <-
      paste(
        '~/rds/rds-rb643-abcd/Data_Imaging',
        eid,
        'ses-baseline-year1/surfaces',
        eid,
        'surf',
        sep = .Platform$file.sep
      )
    if (file.exists(paste(inputdir,'/lh.orig.nofix',sep=""))) {
      print(eid)
	try({
      	tempOut <- extractEuler(inputdir, eid)
      	tempOut$oldID <- i
      	outp <- rbind(outp, tempOut)
	})
    }
  }

  write.table(outp,
              file = '~/rds/rds-rb643-abcd/Data_Out/QC_Euler.csv',
              quote=FALSE,
              row.names = FALSE,
              col.names = TRUE,
              sep = ",")

}
