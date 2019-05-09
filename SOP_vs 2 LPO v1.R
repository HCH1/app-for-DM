library(dplyr)
##input:
i1 = read.csv("2 LCN-003147 130G-LP (v35).csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("1 Editable V0100FINAL DM000450 (Rev. 1.0_0.3) - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002803 130RFSOI (v22).csv", header = TRUE, stringsAsFactors=FALSE)
#i3 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
###make a sub-ALL
#TV_uwant <- "DM-000282"
#ly_st <- "Active"
#ly_cat <- "Marker Enablement"
###
#i1_v1 <- i1
#i2_v1 <- i2
##combine gds# as unique
i1_v1 <- cbind( i1[1:36], paste( i1[,3],i1[,4],i1[,17],i1[,18],i1[,23],i1[,24], 
sep = ";", collapse = NULL ) )
i2_v1 <- cbind( i2[1:36], paste( i2[,3],i2[,4],i2[,17],i2[,18],i2[,23],i2[,24], 
sep = ";", collapse = NULL ) )
###vlookup sub-ALL vs desc_split vs dict
vs2lpo <- full_join( i1_v1, i2_v1, by = "Data.Layer.Name")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
#replace NA to blank
vs2lpo[ is.na( vs2lpo ) ] <- ""
write.csv(x = vs2lpo, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs 2 LPO v1.csv", sep = "") )
####################################################end
vs2lpo_v2 <- vs2lpo
#str(vs2lpo_v2)
colnames(vs2lpo_v2)[37] <- "LPO1.x"
colnames(vs2lpo_v2)[dim(vs2lpo_v2)[2]] <- "LPO2.y"
#str(vs2lpo_v2)
###grep LPO1 is NIL; but LPO2 has OA#
vs2lpo_v2_lpo1_nil <- vs2lpo_v2[grep("NIL;", vs2lpo_v2$LPO1.x),]
vs2lpo_v2_lpo1_nil <- vs2lpo_v2_lpo1_nil[grep("NIL;", 
vs2lpo_v2_lpo1_nil$LPO2.y, invert = TRUE),]
vs2lpo_v2_lpo1_nil <- vs2lpo_v2_lpo1_nil[ order(
vs2lpo_v2_lpo1_nil[dim(vs2lpo_v2_lpo1_nil)[2]], decreasing = TRUE), ]
write.csv(x = vs2lpo_v2_lpo1_nil, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO1 is NIL but LPO2 has OA v1.csv", sep = "") )
###
###grep LPO2 is NIL; but LPO1 has OA#
vs2lpo_v2_lpo2_nil <- vs2lpo_v2[grep("NIL;", vs2lpo_v2$LPO2.y),]
vs2lpo_v2_lpo2_nil <- vs2lpo_v2_lpo2_nil[grep("NIL;", 
vs2lpo_v2_lpo2_nil$LPO1.x, invert = TRUE),]
vs2lpo_v2_lpo2_nil <- vs2lpo_v2_lpo2_nil[ order(
vs2lpo_v2_lpo2_nil[37], decreasing = TRUE), ]
write.csv(x = vs2lpo_v2_lpo2_nil, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO2 is NIL but LPO1 has OA v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
