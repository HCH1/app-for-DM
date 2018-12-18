library(dplyr)
##input:
i1 = read.csv("1 DM-000064_25_Aug 2018 130BCDL-PTF - Copy ch2 sum.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002393 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
i3 = read.csv("3 LM-0001.087 130.csv", header = TRUE, stringsAsFactors=FALSE)
#dim(i1)
#dim(i2)
#dim(i3)
##combine gds# as unique
i1_v1 <- cbind( i1, paste( i1$Input.GDS.II.Number, i1$GDS.data.type, sep = ";", collapse = NULL ) )
i1_v1 <- i1_v1[ order(i1_v1[5]), ]
colnames(i1_v1)[5] <- "gds.pair"
#head(i1_v1)
##combine gds# as unique
i2_v1 <- cbind( paste( i2$GDS.Number, i2$GDS.Datatype, sep = ";", collapse = NULL )
, i2[2], i2[7], i2[9], i2[13] )
i2_v1 <- i2_v1[ order(i2_v1[1]), ]
colnames(i2_v1)[1] <- "gds.pair"
#head(i2_v1)
##combine gds# as unique
i3_v1 <- cbind( paste( i3$Input.GDS.Number, i3$Input.GDS.Data.Type, sep = ";", collapse = NULL )
, i3[3] )
i3_v1 <- i3_v1[ order(i3_v1[1]), ]
colnames(i3_v1)[1] <- "gds.pair"
#head(i3_v1)
##
#vlookup
i1_v2 <- left_join(i1_v1, i2_v1, by = "gds.pair")
#dim(i1_v2)
#head(i1_v2)
write.csv(x = i1_v2, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO v1.csv", sep = "") )
##
#vlookup
i1_v3 <- left_join(i1_v2, i3_v1, by = "gds.pair")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
write.csv(x = i1_v3, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT v2.csv", sep = "") )
##
dim(i1)
dim(i1_v1)
dim(i1_v2)
dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
##
i1_v4 <- data.frame( table(i1_v3[5]) ) #can do freq sum
i1_v4[i1_v4$Freq > 1,] #export freq >= 2
i1_v4 <- i1_v4[ order(-i1_v4[2]), ] #order reverse
write.csv(x = i1_v4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_vs ch2 LPO LMT gds freq v2.csv", sep = "") )
####################################################end
####################################################end
####################################################end