abcd_extractdwi <- function(filelist,outfile,parcellation,file,...) {
  filelist <- read.table(filelist)

  outp <- data.frame()

  for (i in filelist$V1) {
    eid <- paste('sub-', i, sep = "")
    inputdir <-
      paste(
        "/rds/project/rb643/rds-rb643-abcd/Data_Imaging",
        eid,
        'ses-baseline-year1',
        'dMRI',
        'parcellations',
        parcellation,
        sep = .Platform$file.sep
      )
    if (file.exists(paste(inputdir,file,sep=.Platform$file.sep))) {
      print(eid)
	try({
      	tempOut <- read.table(paste(inputdir,file,sep=.Platform$file.sep))
      	tempOut$ID <- eid
      	outp <- rbind(outp, tempOut)
	})
    }
  }

  write.table(outp,
              file = outfile,
              quote=FALSE,
              row.names = FALSE,
              col.names = TRUE,
              sep = ",")

}
