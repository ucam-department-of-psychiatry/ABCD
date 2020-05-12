df.exist <- read.table('./Data/dwiexists.txt',header = F)
df.files <- read.table('./Data/dwifiles.txt',header = F)


df.files$ID <- substr(df.files$V1,1,15)

'%!in%' <- function(x,y)!('%in%'(x,y))

df <- df.files[df.exist$V1 %in% df.files$ID,]
df <- df[!duplicated(df$ID),]
write.table(df$V1,'./Data/dwi_done.txt',col.names = F, row.names = F, quote = F)

df <- df.files[df.exist$V1 %in% df.files$ID,]
df <- df[duplicated(df$ID),]
write.table(df$V1,'./Data/dwi_secondrun.txt',col.names = F, row.names = F, quote = F)
