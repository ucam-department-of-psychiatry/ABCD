## SETUP
rm(list = ls()) # clear the workspace
library(easypackages) # then we can do the rest in one go

# get a list of all potentially useful packages
list.of.packages <- c("Hmisc","ggplot2","caret","gplots","Rmisc","dplyr",
                      "MatchIt","optmatch","data.table","plotrix","ggthemes", "knitr",
                      "viridis","coin","plyr","psytabs","RColorBrewer","boot", "kableExtra",
                      "msir","lmtest", "ggpubr","stats", "reshape2","xtable",
                      "ez","apa","parallel", "jmuOutlier","Rtsne","fpc", "cluster",
                      "RCurl","nlme","foreach","doParallel", "gridExtra","cowplot")

source("https://bit.ly/2q4XQ66")

# check if they are already installed and otherwise install them
# note: this doesn't work for biocLite tools
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) { install.packages(new.packages)}

# then load them all
libraries(list.of.packages)
rm(list.of.packages, new.packages)

## LOAD DATA
df <- read.table('./Data/mriqcrp102.txt', header = T)[-1,]

# select some data
df.main <- df %>% dplyr::select(
  sex,interview_age, interview_date, src_subject_id,subjectkey,iqc_t1_1_seriestime,
  iqc_t1_1_voxvol,iqc_t1_2_voxvol, iqc_t2_1_voxvol, iqc_t2_2_voxvol,
  iqc_t1_1_qc_score, iqc_t1_1_qc_score,
  iqc_t2_1_qc_score, iqc_t2_1_qc_score, 
  iqc_rsfmri_1_qc_score, iqc_rsfmri_2_qc_score,
  iqc_rsfmri_1_fm_invalid, iqc_rsfmri_2_fm_invalid,
  iqc_rsfmri_1_mean_motion, iqc_rsfmri_2_mean_motion,
  iqc_rsfmri_1_mean_motion_filt, iqc_rsfmri_2_mean_motion_filt,
  iqc_rsfmri_1_brain_tsnr_mean, 
  iqc_rsfmri_1_brain_tsnr_median, 
  iqc_rsfmri_1_sub_02_nody
)

# convert the numeric ones to numeric
cols = 17:23
df.main[,cols] = apply(df.main[,cols], 2, function(x) as.numeric(as.character(x)));

# remove the asexuals
df.main <- df.main[!(is.na(df.main$sex) | df.main$sex==""), ]

# check who has qc-passed t1, t2 and rsfmri
df.main <- df.main[ which( df.main$iqc_t1_1_qc_score == 1 & 
                               df.main$iqc_t2_1_qc_score == 1 & 
                               df.main$iqc_rsfmri_1_qc_score == 1) , ]

# plot some QC metrics
meantSNR <- ggplot(data = df.main, aes(y = iqc_rsfmri_1_brain_tsnr_mean, x = sex, fill = sex)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = iqc_rsfmri_1_brain_tsnr_mean), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Sex") +
  ylab("Mean tsnr") +
  coord_flip() +
  theme_cowplot()

mediantSNR <- ggplot(data = df.main, aes(y = iqc_rsfmri_1_brain_tsnr_median, x = sex, fill = sex)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = iqc_rsfmri_1_brain_tsnr_median), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Sex") +
  ylab("Median tsnr") +
  coord_flip() +
  theme_cowplot()

meanMotion <- ggplot(data = df.main, aes(y = iqc_rsfmri_1_mean_motion, x = sex, fill = sex)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = iqc_rsfmri_1_mean_motion), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Sex") +
  ylab("Mean FD") +
  coord_flip() +
  theme_cowplot()

meanMotionFilt <- ggplot(data = df.main, aes(y = iqc_rsfmri_1_mean_motion_filt, x = sex, fill = sex)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = iqc_rsfmri_1_mean_motion_filt), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Sex") +
  ylab("Mean FD - using filtering") +
  coord_flip() +
  theme_cowplot()

subMotion <- ggplot(data = df.main, aes(y = iqc_rsfmri_1_sub_02_nody, x = sex, fill = sex)) +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y = iqc_rsfmri_1_sub_02_nody), position = position_jitter(width = .15), 
             size = 1.5, alpha = 0.8) +
  geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
  expand_limits(x = 1.5) +
  guides(fill = FALSE) +
  guides(color = FALSE) +
  xlab("Sex") +
  ylab("Time (s) with FD < 0.2mm") +
  coord_flip() +
  theme_cowplot()

# combine the plots
ggarrange(ggarrange(meantSNR,mediantSNR, ncol = 2),
          ggarrange(meanMotion,meanMotionFilt, subMotion, ncol = 3),
          nrow = 2)


