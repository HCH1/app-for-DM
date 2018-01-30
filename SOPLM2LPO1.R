library(dplyr)
i1 = read.csv("LM-0053.175 Export_Layers_By_LMT.csv", header = TRUE)
i2 = read.csv("LPO-000253.csv", header = TRUE)
dim(i1) #24r
dim(i2) #37r
coln2 <- colnames(i2)
coln2[1] <- c("Number")
str(coln2)
dumx3 <- matrix( NA, nrow=dim(i1)[1], ncol=3 )
dumx4 <- matrix( NA, nrow=dim(i1)[1], ncol=4 )
dumx5 <- matrix( NA, nrow=dim(i1)[1], ncol=5 )
dumx13 <- matrix( NA, nrow=dim(i1)[1], ncol=13 )
#footstop "."
dumx_fs <- matrix( ".", nrow=dim(i1)[1], ncol=1 )
dim(dumx0)
#create LPO_draft1
mx1 <- cbind( i1[1],i1[3],i1[2],dumx5,
#create "." or ".." at the end
paste( i1$Description, dumx_fs, sep = "", collapse = NULL ),
dumx3,i1[4],dumx3,i1[7],i1[8],i1[9],i1[10],dumx4,dumx13 )
#replace colnames base on formal LPO
dim(mx1)
colnames(mx1) <- coln2[1:dim(t(mx1))[1]]
#replace ".." -> "."
mx1$Layer.Description <- gsub("[.]{2}", ".", mx1$Layer.Description )
#replace start is "." -> ""
mx1$Layer.Description <- gsub("^[.]{1}", "", mx1$Layer.Description )
str(mx1)
mx11 <- mx1
#replace NA -> blank
mx11[is.na(mx11)] <- ""
str(mx11)
write.csv(x = mx11, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft1.csv", sep = "") )
#library(dplyr)
mx1_v2 <- mx11
#vs 22's LPO
#i2_v2 <- cbind( i2[2:7],i2[9],i2[10],i2[11],i2[13],i2[17:24] )
#i2_v2 <- cbind( i2[2:dim(t(mx1))[1]] )
#dim(i2_v2)
#mx1_v2 <- left_join(mx1_v2, i2_v2, by = "Data.Layer.Name")
#vlookup
mx1_v2 <- left_join(mx11, i2, by = "Data.Layer.Name")
str(mx1_v2)
mx1_v3 <- mx1_v2
#replace NA -> blank
mx1_v3[is.na(mx1_v3)] <- ""
str(mx1_v3)
write.csv(x = mx1_v3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft2.csv", sep = "") )
#re-cbind draft LPO
mx2 <- cbind( mx1_v3[1:3], mx1_v3[40:44], mx1_v3[9], mx1_v3[46:48], mx1_v3[13]
, mx1_v3[50:52], mx1_v3[17:20], mx1_v3[57:73] )
str(mx2)
write.csv(x = mx2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft3.csv", sep = "") )
####################################################end
####################################################end
