library(dplyr)
##input:
##i1 = read.csv("1 DM-000064_25_Aug 2018 130BCDL-PTF - Copy ch2 sum.csv", header = TRUE, stringsAsFactors=FALSE)
i1 = read.csv("1 DM-000282_8_30 June 2018 - Copy ch2 sum.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002393 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("3 LM-0001.087 130.csv", header = TRUE, stringsAsFactors=FALSE)
#dim(i1)
#dim(i2)
#dim(i3)
##sometimes DM table name is diff, so rename.
colnames(i1)[1] <- "DM.Layer.Name"
colnames(i1)[2] <- "DM.Description"
colnames(i1)[3] <- "DM.GDS.Number"
colnames(i1)[4] <- "DM.GDS.Datatype"
##combine gds# as unique
i1_v1 <- cbind( i1, paste( i1$DM.GDS.Number, i1$DM.GDS.Datatype, sep = ";", collapse = NULL ) )
i1_v1 <- i1_v1[ order(i1_v1[5]), ]
colnames(i1_v1)[5] <- "gds.pair"
#head(i1_v1)
##combine gds# as unique
i2_v1 <- cbind( paste( i2$GDS.Number, i2$GDS.Datatype, sep = ";", collapse = NULL )
, i2[2], i2[7], i2[9], i2[13], i2[11] )
i2_v1 <- i2_v1[ order(i2_v1[1]), ]
colnames(i2_v1)[1] <- "gds.pair"
colnames(i2_v1)[2] <- "LPO.Data.Layer.Name"
colnames(i2_v1)[3] <- "LPO.Layer.Category"
colnames(i2_v1)[4] <- "LPO.Layer.Description"
colnames(i2_v1)[5] <- "LPO.Layer.Type"
colnames(i2_v1)[6] <- "LPO.TV"
#head(i2_v1)
##combine gds# as unique
i3_v1 <- cbind( paste( i3$Input.GDS.Number, i3$Input.GDS.Data.Type, sep = ";", collapse = NULL )
, i3[3] )
i3_v1 <- i3_v1[ order(i3_v1[1]), ]
colnames(i3_v1)[1] <- "gds.pair"
colnames(i3_v1)[2] <- "LMT.Layer.Number"
#head(i3_v1)
##
#vlookup
i1_v2 <- left_join(i1_v1, i2_v1, by = "gds.pair")
#dim(i1_v2)
#head(i1_v2)
#write.csv(x = i1_v2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO v1.csv", sep = "") )
##
#vlookup
i1_v3 <- left_join(i1_v2, i3_v1, by = "gds.pair")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
write.csv(x = i1_v3, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT v2.csv", sep = "") )
#vlookup in lpo or in lmt
i1_v3$ans.in.lpo <- ifelse(i1_v3$LPO.Data.Layer.Name == "NA","FALSE","")
i1_v3$ans.in.lmt <- ifelse(i1_v3$LMT.Layer.Number == "NA","FALSE","")
i1_v3 <- cbind( i1_v3[,12:13], i1_v3[1:11] )
##
i1_v4 <- data.frame( table(i1_v3$gds.pair) ) #can do freq sum
i1_v4[i1_v4$Freq > 1,] #export freq >= 2
i1_v4 <- i1_v4[ order(-i1_v4[2]), ] #order reverse
write.csv(x = i1_v4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT gds freq v2.csv", sep = "") )
###
###to export TV missing lines
#grep dataframe contain keywords
i1_tv_v1 <- i1_v3[ grep("DM-000282", i1_v3$ LPO.TV, invert = TRUE), ]
##combine gds# as unique
i2_tv_v1 <- cbind( paste( i2$GDS.Number, i2$GDS.Datatype, sep = ";", collapse = NULL )
, i2)
i2_tv_v1 <- i2_tv_v1[ order(i2_tv_v1[1]), ]
colnames(i2_tv_v1)[1] <- "gds.pair"
#vlookup
i1_tv_v2 <- left_join(i1_tv_v1, i2_tv_v1, by = "gds.pair")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
write.csv(x = i1_tv_v2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT then TV missing.csv", sep = "") )
##check again all dimm history
dim(i1)
dim(i1_v1)
dim(i1_v2)
dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
dim(i1_tv_v1)
dim(i1_tv_v2)
##
###to do diff report
library(diffobj)
##do diff for layer name
DM_ <- as.vector( t( i1_v3$DM.Layer.Name ) )
LPO_ <- as.vector( t( i1_v3$LPO.Data.Layer.Name ) )
length(DM_)
length(LPO_)
diffChr(LPO_, DM_, color.mode="rgb")
