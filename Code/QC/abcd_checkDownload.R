setwd("~/Dropbox/Research/Projects/ABCD")

df <-  read.table('./Data/fmriresults01.txt', header = T)[-1,]
allfiles <- read.table('./Data/allfiles.txt', header = F)
finished <- read.table('./Data/finishedsubs.txt', header = F)
partial <- read.table('./Data/tempsubs.txt', header = F)
unfinished <- read.table('./Data/notrun.txt', header = F)

#convert all files
splitfiles <- strsplit(as.character(allfiles$V1),"_")
last_elems <- unlist(lapply(splitfiles, head, n = 1L))
allfiles <- as.data.frame(as.character(last_elems))
colnames(allfiles) <- "V1"
allfiles <- as.data.frame(unique(allfiles$V1))
colnames(allfiles) <- "V1"
allfiles$V1 <- as.character(allfiles$V1)

# convert finished files
finished$V1 <- as.character(finished$V1)
splitfiles <- strsplit(finished$V1,"sub-")
last_elems <- unlist(lapply(splitfiles, tail, n = 1L))
finished$V1 <- as.character(last_elems)

# convert partially finished files
partial$V1 <- as.character(partial$V1)
splitfiles <- strsplit(partial$V1,"Temp_")
last_elems <- unlist(lapply(splitfiles, tail, n = 1L))
partial$V1 <- as.character(last_elems)

# convert unfinished files
unfinished$V1 <- as.character(unfinished$V1)
splitfiles <- strsplit(unfinished$V1,"/")
last_elems <- unlist(lapply(splitfiles, tail, n = 1L))
splitfiles <- strsplit(last_elems,"_")
last_elems <- unlist(lapply(splitfiles, head, n = 1L))
rm(unfinished)
unfinished <- as.data.frame(as.character(unique(as.character(last_elems))))
colnames(unfinished) <- "V1"
unfinished$V1 <- as.character(unfinished$V1)

overlap <- unfinished$V1 %in% partial$V1
any(overlap)
overlap <- unfinished$V1 %in% finished$V1
keep <- unfinished[!unfinished$V1 %in% finished$V1,]

overlap <- unfinished$V1 %in% allfiles$V1

keep <- last_elems %in% allfiles
df2 <- df[!keep,]

length(unique(df2$derived_files))

keepfiles <- as.data.frame(unique(df2$derived_files))
write.table(keepfiles$`unique(df2$derived_files)`,'./Code/aws3_links.txt', 
            quote = FALSE, row.names = FALSE, col.names = FALSE)


partial <- read.table('./Code/partialsubs2.txt', header =F)
unfinished <- read.table('./Code/unfinishedsubs3.txt', header =F)
