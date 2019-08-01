#v1 oa1 o22 vs PDK from AMY
library(dplyr)
##input:
i1 = read.csv("2 LCN-003353 180BSL (v11).csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-003290 130G-LP (v44).csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("2 LCN-003302 130RFSOI (v23).csv", header = TRUE, stringsAsFactors=FALSE)
i4 = read.csv("DM-000290 pdk info by AMY v0.csv", header = TRUE, stringsAsFactors=FALSE)
#
i1tv = "180BSL v11"
i2tv = "130G-LP v44"
i3tv = "130RFSOI v23"
i4tv = "dm-290 pdk by AMY"
#
i1_v1 <- i1
i4_v1 <- i4
vs_oa1 <- full_join(i4_v1, i1_v1, by = "Cadence.Layer.Name")
vs_oa1[ is.na(vs_oa1) ] <- ""
vs_oa1 <- vs_oa1[ order(vs_oa1[1], decreasing = FALSE), ]
#
write.csv(x = vs_oa1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",i1tv
,"_",i4tv
, "_vs oa1 v1.csv", sep = "") )
#
vs_oa2 <- full_join(i4_v1, i1_v1, by = "Cadence.Layer.Purpose")
vs_oa2[ is.na(vs_oa2) ] <- ""
vs_oa2 <- vs_oa2[ order(vs_oa2[1], decreasing = FALSE), ]
#
write.csv(x = vs_oa2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",i1tv
,"_",i4tv
, "_vs oa2 v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end