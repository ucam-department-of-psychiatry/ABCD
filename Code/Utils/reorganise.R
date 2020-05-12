setwd("~/GitHub/ABCD")
colnamesHCP <- read.csv('./Data/colnames.csv')

CT <- read.csv('./Data/Struct_CT.csv')[,c(3:182,184:364)]
SA <- read.csv('./Data/Struct_SA.csv')[,c(3:182,184:364)]
Vol <- read.csv('./Data/Struct_Vol.csv')[,c(3:182,184:364)]
meanCurv <- read.csv('./Data/Struct_meanCurv.csv')[,c(3:182,184:364)]
GaussianCurv <- read.csv('./Data/Struct_GaussianCurv.csv')[,c(3:182,184:364)]
IntrinsicCurv <- read.csv('./Data/Struct_IntrinsicCurv.csv')[,c(3:182,184:364)]
FoldingIdex <- read.csv('./Data/Struct_FoldingIndex.csv')[,c(3:182,184:364)]

df = FoldingIdex
temp = matrix(NA,nrow = nrow(df),ncol = 180)
for (i in 1:180){
  
  temp[,i] <- colMeans(rbind(df[,i],df[,180+i])) 
}

temp <- as.data.frame(temp)
colnames(temp) <- colnamesHCP$region
temp$newID <- df$NewID

write.csv(temp,'./Data/Hemimean/Struct_FoldingIdex.csv')

df = FoldingIdex
temp <- as.data.frame(rowMeans(df[,1:360]))
temp$newID <- df$NewID
colnames(temp) <- c("FoldingIdex","NewID")
write.csv(temp,'./Data/Corticalmean/Struct_FoldingIdex.csv')