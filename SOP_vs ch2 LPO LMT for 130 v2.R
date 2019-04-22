library(dplyr)
##input:
i1 = read.csv("1 130BCD_DM000282_V0950PRE01_Base_Editable ch2 - Copy - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i4tv = "DM-000282"
#i1 = read.csv("1 Editable V0100FINAL DM000450 (Rev. 1.0_0.3) - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002745 130G-LP (v31).csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
#dim(i1)
#dim(i2)
#dim(i3)
##sometimes DM table name is diff, so rename.
colnames(i1)[1] <- "DM.Layer.Name"
colnames(i1)[2] <- "DM.Description"
colnames(i1)[3] <- "DM.GDS.Number"
colnames(i1)[4] <- "DM.GDS.Datatype"
##combine gds# as unique
i1_v1 <- i1
i1_v1$gds.pair <- paste( i1_v1$DM.GDS.Number, i1_v1$DM.GDS.Datatype, sep = ";", collapse = NULL )
i1_v1 <- i1_v1[ order(i1_v1[5]), ]
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
#write.csv(x = i1_v4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT gds freq v2.csv", sep = "") )
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
write.csv(x = i1_v33, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT v2.csv", sep = "") )
###
###freq of LPO.Layer.Category
i1_v33_cate <- data.frame( table(i1_v33$LPO.Layer.Category) ) #can do freq sum
colnames(i1_v33_cate)[1] <- "Layer.Category"
i1_v33_cate
write.csv(x = i1_v33_cate, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT Category freq v2.csv", sep = "") )
###
###export sub LPO by wanted Category
#do OR_filter; use inner_join will keep only correct rows
sublpo_Category <- inner_join(i2, i1_v33_cate, by = "Layer.Category")
#grep invert = TRUE; can not choose Enablement for auto sync ch2.
sublpo_Category <- sublpo_Category[ grep("Marker Enablement", 
sublpo_Category$Layer.Category, invert = TRUE), ]
#str(sublpo_Category)
#table(sublpo_Category$Layer.Category)
#do filter for correct TV
###
#grep dataframe contain keywords
#grep TV=i4tv from sub-LPO
subLPO_TV_v2 <- sublpo_Category[grep(i4tv, sublpo_Category$Tech.Variant...Included.in.PDK),]
#str(subLPO_TV_v2)
#replace NA to blank
subLPO_TV_v2[ is.na( subLPO_TV_v2 ) ] <- ""
#order Data.Layer.Name
subLPO_TV_v2 <- subLPO_TV_v2[ order(subLPO_TV_v2[2]), ] #order reverse
#table(subLPO_TV_v2$Layer.Category)
write.csv(x = subLPO_TV_v2, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sublpo_Category_TV_for_LCN_using.csv", sep = "") )
###
###do a lite diff between sub-LPO vs DM ch2, by layer name
sublpo_lite1 <- cbind( subLPO_TV_v2[2], 
paste( subLPO_TV_v2$GDS.Number, subLPO_TV_v2$GDS.Datatype, sep = ";", collapse = NULL )
, subLPO_TV_v2[1] )
colnames(sublpo_lite1)[1] <- "Layer.Name"
colnames(sublpo_lite1)[2] <- "subLPO.gds.pair"
colnames(sublpo_lite1)[3] <- "subLPO.LV"
sublpo_lite1 <- sublpo_lite1[ order(sublpo_lite1[1]), ]
str(sublpo_lite1)
###make a sub dm for diff
subdm_lite1 <- cbind( i1[1], 
paste( i1$DM.GDS.Number, i1$DM.GDS.Datatype, sep = ";", collapse = NULL ) )
colnames(subdm_lite1)[1] <- "Layer.Name"
colnames(subdm_lite1)[2] <- "subDM.gds.pair"
subdm_lite1 <- subdm_lite1[ order(subdm_lite1[1]), ]
str(subdm_lite1)
diff_subdm_vs_sublpo_by_Category_tv <- full_join(sublpo_lite1, subdm_lite1, by = "Layer.Name")
diff_subdm_vs_sublpo_by_Category_tv <- diff_subdm_vs_sublpo_by_Category_tv[ order(diff_subdm_vs_sublpo_by_Category_tv[2], na.last = FALSE), ]
write.csv(x = diff_subdm_vs_sublpo_by_Category_tv, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diff_subdm_vs_sublpo_by_Category_TV.csv", sep = "") )
###
###to export TV missing lines
#grep dataframe contain keywords; be care of swith DM#
###
i1_tv_v1 <- i1_v3[ grep( i4tv, i1_v3$LPO.TV, invert = TRUE), ]
##i1_tv_v1 <- i1_v3[ grep("130RFSOI", i1_v3$LPO.TV, invert = TRUE), ]
##i1_tv_v1 <- i1_v3[ grep("DM-000064", i1_v3$LPO.TV, invert = TRUE), ]
##i1_tv_v1 <- i1_v3[ grep("DM-000282", i1_v3$LPO.TV, invert = TRUE), ]
##combine gds# as unique
i2_tv_v1 <- cbind( paste( i2$GDS.Number, i2$GDS.Datatype, sep = ";", collapse = NULL )
, i2)
i2_tv_v1 <- i2_tv_v1[ order(i2_tv_v1[1]), ]
colnames(i2_tv_v1)[1] <- "gds.pair"
#vlookup
i1_tv_v2 <- left_join(i1_tv_v1, i2_tv_v1, by = "gds.pair")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
#replace NA to blank
i1_tv_v2[ is.na( i1_tv_v2 ) ] <- ""
write.csv(x = i1_tv_v2, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT then TV missing.csv", sep = "") )
###
###export missing TV for LCN submit
i2_v1a <- i2
#i2_v1a$gds.pair <- cbind( i2_v1a, paste( i2_v1a$GDS.Number, i2_v1a$GDS.Datatype, sep = ";", collapse = NULL ) )
i2_v1a$gds.pair <- paste( i2_v1a$GDS.Number, i2_v1a$GDS.Datatype, sep = ";", collapse = NULL )
#str(i2_v1a)
missing_TV_for_LCN <- inner_join(i2_v1a, cbind( i1_tv_v2[5], i1_tv_v2[1] ), by = "gds.pair")
#check DM name =? LPO name
missing_TV_for_LCN$ans.vs.dm.lpo.name <- ifelse(missing_TV_for_LCN$DM.Layer.Name == missing_TV_for_LCN$Data.Layer.Name ,"1","2")
#replace NA to blank
missing_TV_for_LCN[ is.na( missing_TV_for_LCN ) ] <- ""
write.csv(x = missing_TV_for_LCN, row.names = TRUE
, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_missing_TV_for_LCN_using.csv", sep = "") )
###
###check again all dimm history
dim(i1)
dim(i1_v1)
dim(i1_v2)
dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
dim(i1_tv_v1)
dim(i1_tv_v2)
###
###to do diff report
library(diffobj)
##do diff bwtween sub-LPO vs DM ch2, by layer name
####################################################end
##this is old one
#DM_ <- as.vector( t( i1_v3$DM.Layer.Name ) )
#LPO_ <- as.vector( t( i1_v3$LPO.Data.Layer.Name ) )
#length(DM_)
#length(LPO_)
#diffChr(LPO_, DM_, color.mode="rgb")
####################################################end
##do diff for layer name
DM_ <- as.vector( t( i1[ order(i1[1]), ]$DM.Layer.Name ) )
subLPO_ <- as.vector( t( subLPO_TV_v2$Data.Layer.Name ) )
length(DM_)
length(subLPO_)
diffChr(subLPO_, DM_, color.mode="rgb")
