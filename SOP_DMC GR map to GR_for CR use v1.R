library(dplyr)
##input:
i1 = read.csv("20190411_11_SOP_DMC map to LPO, then sort GR v1.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("130BCDLITE_Rev1.0_4.0_DRC03_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
###
###SOP to check two files diff: add new key col > xxx_join() > logic check > replace NA > save as
i1_v1 <- i1
i2_v1 <- i2
i1_v1 <- data.frame( table(i1_v1) ) #can do freq sum
colnames(i1_v1)[1] <- "Name"
#str(i1_v1)
#str(i2_v1)
ans1 <- full_join(i2_v1, i1_v1, by = "Name")
ans1 <- ans1[ order(ans1[ dim(ans1)[2]-4 ], na.last = TRUE, decreasing = FALSE  ), ]
ans1 <- ans1[ order(ans1[ dim(ans1)[2] ], na.last = TRUE, decreasing = FALSE  ), ]
#str(ans1)
ans1[ is.na( ans1 ) ] <- ""
write.csv(x = ans1, row.names = TRUE
, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_SOP_DMC GR map to GR_for CR use v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end