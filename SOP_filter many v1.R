#v1 filter many gds
library(dplyr)
##input:
i11 = read.csv("20190708_10_LM-0159_vs_LCN-002803_diff by R v1.csv", header = TRUE, stringsAsFactors=FALSE)
#grep dataframe contain keywords
lmt_col3p3 <- "Generic"
lmt_col1 <- "LM-0159"
lmt_col2 <- "Layer Mapping Table"
lmt_col4 <- "Layer"
lpo_col1 <- "LCN-002803"
i1 <- i11
#i1b <- i1[grep("124;0|130;0|201;0|234;39|28;0", i1$name),]
i1b <- i1[grep("124;0|130;0|201;0|23;39|25;0|87;0", i1$name),]
###re-order
i1b <- i1b[ order( i1b$name
, na.last = FALSE, decreasing = FALSE ), ] #order reverse
write.csv(x = i1b, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",lmt_col1,"_vs_",lpo_col1
, "_filter many gds by R v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end