i1 = read.csv("20190402_10_vs ch2 LPO LMT v3.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("LCN-002681 130RFSOI (v21).csv", header = TRUE, stringsAsFactors=FALSE)
#i2 = read.csv("LCN-002689 130G-LP (v28).csv", header = TRUE, stringsAsFactors=FALSE)
#str(i1)
#str(i2)
i1_v1 <- i1
i1_v1 <- cbind(i1_v1[6],i1_v1[10])
colnames(i1_v1)[1] <- "Data.Layer.Name"
#str(i1_v1)
#do overlap, draft LCN
lcn_v1 <- inner_join(i2, i1_v1, by = "Data.Layer.Name")
i3 <- full_join(lcn_v1, i1_v1, by = "Data.Layer.Name")
i3[ is.na( i3 ) ] <- ""
i3 <- i3[ order( i3[1], decreasing = FALSE ), ] #order reverse
#str(i3)
write.csv(x = i3, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_in DM but not in LPO_for LCN using v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
in1 = read.csv("LCN-002689 130G-LP (v28).csv", header = TRUE, stringsAsFactors=FALSE)
in2 = read.csv("LCN-002681 130RFSOI (v21).csv", header = TRUE, stringsAsFactors=FALSE)
in3 = read.csv("LCN-002702 180BSL (v3).csv", header = TRUE, stringsAsFactors=FALSE)
in4 = read.csv("LCN-002230 130ph (v2).csv", header = TRUE, stringsAsFactors=FALSE)
#str(in1)
in1_v1$oa2 <- paste( in1$Cadence.Layer.Purpose, in1$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )
in2_v1$oa2 <- paste( in2$Cadence.Layer.Purpose, in2$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )
in3_v1$oa2 <- paste( in3$Cadence.Layer.Purpose, in3$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )
in4_v1$oa2 <- paste( in4$Cadence.Layer.Purpose, in4$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )
#str(in1_v1)
#deduplicate
in1_v11 <- data.frame( table(in1_v1$oa2) ) #can do freq sum
in2_v11 <- data.frame( table(in2_v1$oa2) ) #can do freq sum
in3_v11 <- data.frame( table(in3_v1$oa2) ) #can do freq sum
in4_v11 <- data.frame( table(in4_v1$oa2) ) #can do freq sum
###split col to cols by sep
library(tidyr)
in1_v11 <- separate(in1_v11,Var1,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
in2_v11 <- separate(in2_v11,Var1,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
in3_v11 <- separate(in3_v11,Var1,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
in4_v11 <- separate(in4_v11,Var1,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
###create a summary table
ans1 <- full_join(in1_v11, in2_v11, by = "Cadence.Layer.Purpose")
ans1 <- full_join(ans1, in3_v11, by = "Cadence.Layer.Purpose")
ans1 <- full_join(ans1, in4_v11, by = "Cadence.Layer.Purpose")
ans1[ is.na( ans1 ) ] <- ""
#ans1 <- rbind(in1_v11,in2_v11,in3_v11)
write.csv(x = ans1, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_4 lpo OA info v1.csv", sep = "") )
####################################################end
in1_LayerType <- data.frame( table(in1$Layer.Type) ) #can do freq sum
in2_LayerType <- data.frame( table(in2$Layer.Type) ) #can do freq sum
in3_LayerType <- data.frame( table(in3$Layer.Type) ) #can do freq sum
in4_LayerType <- data.frame( table(in4$Layer.Type) ) #can do freq sum
#str(in1_LayerType)
###create a summary table
ans2 <- full_join(in1_LayerType, in2_LayerType, by = "Var1")
ans2 <- full_join(ans2, in3_LayerType, by = "Var1")
ans2 <- full_join(ans2, in4_LayerType, by = "Var1")
ans2[ is.na( ans2 ) ] <- ""
#ans1 <- rbind(in1_v11,in2_v11,in3_v11)
write.csv(x = ans2, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_4 lpo Layer Type freq v1.csv", sep = "") )
####################################################end
i1 = read.csv("LM-0098.015 130ph.csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("LM-0001.090 - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("LM-0159.014.csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("1 LM-0106.038 Export_Layers_By_LMT.csv", header = TRUE, stringsAsFactors=FALSE)
str(i1)
i1$gds.pair <- paste( i1$Input.GDS.Number , i1$Input.GDS.Data.Type, sep = ";", collapse = NULL )
i1_gds_freq <- data.frame( table( i1[dim(i1)[2]] ) )
###re-order
str(i1_gds_freq)
i1_gds_freq <- i1_gds_freq[ order( i1_gds_freq[2], decreasing = TRUE ), ] #order reverse
head(i1_gds_freq)

