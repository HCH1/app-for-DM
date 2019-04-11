library(dplyr)
##input:
i1 = read.csv("DMC_Result_130BCDLite_130BCDlite_V1040QA01_20190329_1706.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("LCN-002718 130G-LP (v29).csv", header = TRUE, stringsAsFactors=FALSE)
###
###SOP to check two files diff: add new key col > xxx_join() > logic check > replace NA > save as
i1_v1 <- i1
i2_v1 <- i2
#str(i1_v1)
i1_v1 <- cbind( i1_v1[2], i1_v1[1], i1_v1[5], i1_v1[6] )
colnames(i1_v1)[1] <- "Data.Layer.Name"
#str(i1_v1)
#str(i2_v1)
ans1 <- full_join(i2_v1, i1_v1, by = "Data.Layer.Name")
ans1 <- ans1[ order(ans1[ dim(ans1)[2]-2 ], na.last = TRUE, decreasing = FALSE  ), ]
#str(ans1)
ans1[ is.na( ans1 ) ] <- ""
write.csv(x = ans1, row.names = TRUE
, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_SOP_DMC map to LPO v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end