#v1 compare oa1 oa2
#LM-0106.038
#LM-0001.091
#LM-0159.014
library(dplyr)
##input:
i1 = read.csv("2 LCN-003343 180BSL (v8).csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-003290 130G-LP (v44).csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("2 LCN-003302 130RFSOI (v23).csv", header = TRUE, stringsAsFactors=FALSE)
i1tv = "180BSL v8"
i2tv = "130G-LP v44"
i3tv = "130RFSOI v23"
###grep file1's oa1 oa2
i1_v1 <- i1
i1_v1oa1 <- paste( i1_v1$Cadence.Layer.Name, i1_v1$Cadence.Name.OA.Number, sep = ";", collapse = NULL )
i1_v1oa2 <- paste( i1_v1$Cadence.Layer.Purpose, i1_v1$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )

i1_v1oa1_f <- data.frame( table(i1_v1oa1) ) #can do freq sum
i1_v1oa2_f <- data.frame( table(i1_v1oa2) ) #can do freq sum

i1_v1oa1_f <- i1_v1oa1_f[ order(i1_v1oa1_f[1], decreasing = TRUE), ]
i1_v1oa2_f <- i1_v1oa2_f[ order(i1_v1oa2_f[1], decreasing = TRUE), ]
colnames(i1_v1oa1_f) <- c("oa1",i1tv)
colnames(i1_v1oa2_f) <- c("oa2",i1tv)
###grep file2's oa1 oa2
i2_v1 <- i2
i2_v1oa1 <- paste( i2_v1$Cadence.Layer.Name, i2_v1$Cadence.Name.OA.Number, sep = ";", collapse = NULL )
i2_v1oa2 <- paste( i2_v1$Cadence.Layer.Purpose, i2_v1$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )

i2_v1oa1_f <- data.frame( table(i2_v1oa1) ) #can do freq sum
i2_v1oa2_f <- data.frame( table(i2_v1oa2) ) #can do freq sum

i2_v1oa1_f <- i2_v1oa1_f[ order(i2_v1oa1_f[1], decreasing = TRUE), ]
i2_v1oa2_f <- i2_v1oa2_f[ order(i2_v1oa2_f[1], decreasing = TRUE), ]
colnames(i2_v1oa1_f) <- c("oa1",i2tv)
colnames(i2_v1oa2_f) <- c("oa2",i2tv)
###grep file3's oa1 oa2
i3_v1 <- i3
i3_v1oa1 <- paste( i3_v1$Cadence.Layer.Name, i3_v1$Cadence.Name.OA.Number, sep = ";", collapse = NULL )
i3_v1oa2 <- paste( i3_v1$Cadence.Layer.Purpose, i3_v1$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )

i3_v1oa1_f <- data.frame( table(i3_v1oa1) ) #can do freq sum
i3_v1oa2_f <- data.frame( table(i3_v1oa2) ) #can do freq sum

i3_v1oa1_f <- i3_v1oa1_f[ order(i3_v1oa1_f[1], decreasing = TRUE), ]
i3_v1oa2_f <- i3_v1oa2_f[ order(i3_v1oa2_f[1], decreasing = TRUE), ]
colnames(i3_v1oa1_f) <- c("oa1",i3tv)
colnames(i3_v1oa2_f) <- c("oa2",i3tv)
###vs oa1
vs_oa1 <- full_join(i1_v1oa1_f, i2_v1oa1_f, by = "oa1")
vs_oa1 <- full_join(vs_oa1, i3_v1oa1_f, by = "oa1")
vs_oa1[ is.na( vs_oa1 ) ] <- ""
vs_oa1 <- vs_oa1[ order(vs_oa1[1], decreasing = FALSE), ]
###vs oa2
vs_oa2 <- full_join(i1_v1oa2_f, i2_v1oa2_f, by = "oa2")
vs_oa2 <- full_join(vs_oa2, i3_v1oa2_f, by = "oa2")
vs_oa2[ is.na(vs_oa2) ] <- ""
vs_oa2 <- vs_oa2[ order(vs_oa2[1], decreasing = FALSE), ]
#
write.csv(x = vs_oa2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",i1tv
,"_",i2tv
,"_",i3tv
, "_vs oa2 v1.csv", sep = "") )
#
write.csv(x = vs_oa1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",i1tv
,"_",i2tv
,"_",i3tv
, "_vs oa1 v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end