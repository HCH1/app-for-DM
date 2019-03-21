###https://stackoverflow.com/questions/33018282/list-file-information-in-a-text-file-for-all-the-files-in-a-directory
###http://astrostatistics.psu.edu/su07/R/html/base/html/file.info.html
locpath <- getwd()
locpath_bf <- file.path( locpath, "Images" )
locpath_af <- file.path( locpath, "Images2" )
###https://stat.ethz.ch/pipermail/r-help/2010-October/255439.html
###extract files info with correct path
#f1 <- file.info( list.files( path = "." ) ) #this is getwd()
f1bf <- file.info( list.files( path = locpath_bf, full.names=TRUE ) )
f1af <- file.info( list.files( path = locpath_af, full.names=TRUE  ) )
#write.csv(x = f1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info v1.csv", sep = "") )
write.csv(x = f1bf, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = "") )
write.csv(x = f1af, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = "") )
###read info only 1-2 cols
i1bf = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
i1bf_v1 <- i1bf[1:2]
i1af = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
i1af_v1 <- i1af[1:2]
str(i1bf_v1)
str(i1af_v1)
###full path -> only need base name
i1bf_v1$file.type <- basename( i1bf_v1[,1] )
i1af_v1$file.type <- basename( i1af_v1[,1] )
str(i1bf_v1)
str(i1af_v1)
###vlookup full matrix
#i1bfaf_v1_diff <- left_join(i1bf_v1[1:2], i1bf_v1[1:2], by = "X")
i1bfaf_v1_diff <- full_join(i1af_v1, i1bf_v1, by = "file.type")
str(i1bfaf_v1_diff)
###verify size if diff
i1bfaf_v1_diff$size.diff <- ifelse(i1bfaf_v1_diff$size.x != i1bfaf_v1_diff$size.y
,"1","2")
str(i1bfaf_v1_diff)
###re-order
i1bfaf_v1_diff <- i1bfaf_v1_diff[ order( i1bfaf_v1_diff[ dim(i1bfaf_v1_diff)[2] ] ), ] #order reverse
str(i1bfaf_v1_diff)
###save as
write.csv(x = i1bfaf_v1_diff, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af bf diff.csv", sep = "") )
####################################################end
####################################################end
####################################################end
colnames(i1bfaf_v1_diff)[2] <- "input.bf"
colnames(i1bfaf_v1_diff)[3] <- "input.af"
str(i1bfaf_v1_diff)
write.csv(x = i1bfaf_v1_diff, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf af diff.csv", sep = "") )

i1bfaf_v1_diff$bf.af.diff <- ifelse(i1bfaf_v1_diff$input.bf != i1bfaf_v1_diff$input.af
,"1","2")
str(i1bfaf_v1_diff)








f2 <- as.data.frame(f1)
ff2 <- as.data.frame(ff1)

#str(f2)
#f3 <- f2[ order(-f2[1]), ] #order reverse
#head(f3)

write.csv(x = f2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = "") )
write.csv(x = ff2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = "") )

i1 = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
i1_v1 <- i1
ii1 = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
ii1_v1 <- ii1


colnames(i1_v1)[1] <- "file.name"
str(i1)
#vlookup
i1_v2 <- left_join(i1_v1, i2_v1, by = "gds.pair")


i1_v1 <- i1_v1[ order(i1_v1[1]), ]
head(i1_v1)






library(dplyr)
##input:
i1 = read.csv("1 130BCDLite_DM000064_V1040DRC01 ch2 - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
##i1 = read.csv("1 DM-000064_25_Aug 2018 130BCDL-PTF - Copy ch2 sum.csv", header = TRUE, stringsAsFactors=FALSE)
##i1 = read.csv("1 DM-000282_8_30 June 2018 - Copy ch2 sum.csv", header = TRUE, stringsAsFactors=FALSE)
##i2 = read.csv("2 LCN-002393 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002628130G-LP (v26).csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("3 LM-0001.090 - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
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
###to dig out duplicate GDS#
i1_v4 <- data.frame( table(i1_v3$gds.pair) ) #can do freq sum
i1_v4[i1_v4$Freq > 1,] #export freq >= 2
i1_v4 <- i1_v4[ order(-i1_v4[2]), ] #order reverse
colnames(i1_v4)[1] <- "gds.pair"
write.csv(x = i1_v4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT gds freq v2.csv", sep = "") )
###
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
#vlookup in lpo or in lmt
i1_v3$ans.in.lpo <- ifelse(i1_v3$LPO.Data.Layer.Name == "NA","0","")
i1_v3$ans.in.lmt <- ifelse(i1_v3$LMT.Layer.Number == "NA","0","")
i1_v3$ans.name.diff <- ifelse(i1_v3$DM.Layer.Name != i1_v3$LPO.Data.Layer.Name
,"1","")
###vlookup gds freq
i1_v3 <- left_join(i1_v3, i1_v4, by = "gds.pair")
#i1_v3 <- cbind( i1_v3[,12:length(i1_v3)], i1_v3[1:11] )
i1_v33 <- i1_v3[,12:14]
#replace ans has NA
i1_v33[ is.na( i1_v33 ) ] <- "0"
i1_v33 <- cbind( i1_v33, i1_v3[15], i1_v3[1:11] )
i1_v33 <- i1_v33[ order(i1_v33[1], i1_v33[3], decreasing = TRUE), ]
##
write.csv(x = i1_v33, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT v2.csv", sep = "") )
##freq of LPO.Layer.Category
i1_v33_cate <- data.frame( table(i1_v33$LPO.Layer.Category) ) #can do freq sum
i1_v33_cate
write.csv(x = i1_v33_cate, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT Category freq v2.csv", sep = "") )
###to export TV missing lines
#grep dataframe contain keywords; be care of swith DM#
##i1_tv_v1 <- i1_v3[ grep("DM-000450", i1_v3$ LPO.TV, invert = TRUE), ]
i1_tv_v1 <- i1_v3[ grep("DM-000064", i1_v3$ LPO.TV, invert = TRUE), ]
##i1_tv_v1 <- i1_v3[ grep("DM-000282", i1_v3$ LPO.TV, invert = TRUE), ]
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
#check again all dimm history
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
