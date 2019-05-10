library(dplyr)
##input:
i11 = read.csv("2 LCN-003147 130G-LP (v35).csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("1 Editable V0100FINAL DM000450 (Rev. 1.0_0.3) - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i22 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
#i3 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
###make a sub-ALL
#TV_uwant <- "DM-000282"
#ly_st <- "Active"
#ly_cat <- "Marker Enablement"
lmt_col3p3 <- "Generic"
lmt_col1 <- "LM-0001.091"
lmt_col2 <- "Layer Mapping Table"
lmt_col4 <- "Layer"
###
i1 <- i11
i2 <- i22
#str(i1)
i1 <- i1[grep("Mask|Drawn", i1$Layer.Type),]
i1 <- i1[grep("Active", i1$Layer.Status),]
#str(i1)
#i1 <- i1[grep("", i1$Tech.Variant...Included.in.PDK, invert = TRUE),]
##combine LPO col M B == LMT col C
col3 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
col3[ is.na( col3 ) ] <- lmt_col3p3

col1 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
col1[ is.na( col1 ) ] <- lmt_col1

col2 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
col2[ is.na( col2 ) ] <- lmt_col2

col4 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
col4[ is.na( col4 ) ] <- lmt_col4
###LMT Layer.Number = LPO col 13 2 36 dummy
###col 17 18 25 26
i1_v1 <- cbind( col1,col2,
paste( i1[,13],i1[,2],i1[,36],col3, sep = "_", collapse = NULL )
,col4,i1[17:18],i1[25:26] )
colnames(i1_v1) <- colnames(i2[1,])[1:8]
#str(i1_v1)
i1_v1$Layer.Number <- gsub("__", "_", i1_v1$Layer.Number, ignore.case = TRUE)
#str(i1_v1)
i1_v1[ is.na( i1_v1 ) ] <- ""
#str(i1_v1)
write.csv(x = i1_v1, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lmt from sub-lpo.csv", sep = "") )
####################################################end
###col 5 6 3
i1_v2 <- cbind( paste( i1_v1[,5],i1_v1[,6],i1_v1[,3],
sep = ";", collapse = NULL ) )
i1_v2 <- as.data.frame(table(i1_v2))
colnames(i1_v2)[1] <- "name"

i2_v2 <- cbind( paste( i2[,5],i2[,6],i2[,3],
sep = ";", collapse = NULL ) )
i2_v2 <- as.data.frame(table(i2_v2))
colnames(i2_v2)[1] <- "name"

sublpo_lmt_diff <- full_join( i1_v2, i2_v2, by = "name")
colnames(sublpo_lmt_diff)[2:3] <- c("sub-lpo","sub-lmt")
###re-order
sublpo_lmt_diff <- sublpo_lmt_diff[ order( sublpo_lmt_diff[3]
, na.last = FALSE, decreasing = TRUE ), ] #order reverse
sublpo_lmt_diff <- sublpo_lmt_diff[ order( sublpo_lmt_diff[2]
, na.last = FALSE, decreasing = TRUE ), ] #order reverse

#sublpo_lmt_diff[ is.na( sublpo_lmt_diff ) ] <- ""
write.csv(x = sublpo_lmt_diff, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sublpo vs lmt diff v1.csv", sep = "") )
####################################################end
###col 5 6
i1_v3 <- cbind( paste( i1_v1[,5],i1_v1[,6],
sep = ";", collapse = NULL ) )
i1_v3 <- as.data.frame(table(i1_v3))
colnames(i1_v3)[1] <- "GDS pair"


i2_v3 <- cbind( paste( i2[,5],i2[,6],
sep = ";", collapse = NULL ) )
i2_v3 <- as.data.frame(table(i2_v3))
colnames(i2_v3)[1] <- "GDS pair"

sublpo_lmt_gds_diff <- full_join( i1_v3, i2_v3, by = "GDS pair")
colnames(sublpo_lmt_gds_diff)[2:3] <- c("sub-lpo","sub-lmt")
###re-order
sublpo_lmt_gds_diff <- sublpo_lmt_gds_diff[ order( sublpo_lmt_gds_diff[3]
, na.last = TRUE, decreasing = TRUE ), ] #order reverse
sublpo_lmt_gds_diff <- sublpo_lmt_gds_diff[ order( sublpo_lmt_gds_diff[2]
, na.last = FALSE, decreasing = TRUE ), ] #order reverse

write.csv(x = sublpo_lmt_gds_diff, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sublpo vs lmt GDS diff v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
