#輸入LPO
lpo = read.csv("LPO-000172.csv", header = TRUE)
#col2 7 9 17 18 col4 Cadence Layer Purpose
lpo2 <- cbind( lpo[2], lpo[17], lpo[18], lpo[9], lpo[7], lpo[4] )
lpo2 <- lpo2[order(lpo2[1]), ]
write.csv(x = lpo2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_lite.csv", sep = "") )
##
#輸入ch2
sum1 = read.csv("22FDXch2p2.csv", header = TRUE)
sum1 <- sum1[order(sum1[1]), ]
#輸入lpo_lite
sum2 <- lpo2
#更改LPO的欄位名稱, Data.Layer.Name	Layer.No.	Data.Type	Description	ch
colnames(sum1)[1] <- "Data.Layer.Name"
###library(dplyr)
#讓LPO只選某些rows 基於ch2 這樣比較好做diff 類似vlookup
#sum22 <- semi_join(sum2, sum1[1], by = "Data.Layer.Name" )
sum22 <- merge(sum2, sum1[1])
write.csv(x = sum1, file = "ch2v1.csv")
write.csv(x = sum22, file = "lpov1.csv")
#install.packages("diffobj")
#library(diffobj)
#vignette("diffobj", package="diffobj")
#檢查DM's ch, Data.Layer.Name	Layer.No.	Data.Type	Description	ch
suma <- sum1
suma <- cbind( suma[1], suma[2], suma[3], suma[5] )
suma$x <- paste( suma$Data.Layer.Name, suma$Layer.No., suma$Data.Type, sep = "|", collapse = NULL )
sumav2 <- cbind( suma[5], suma[4] )
#檢查LPO's ch, Data.Layer.Name	GDS.Number	GDS.Datatype	Layer.Description	Layer.Category	Cadence.Layer.Purpose
sumb <- sum22
sumb <- cbind( sumb[1], sumb[2], sumb[3], sumb[5], sumb[6] )
sumb$x <- paste( sumb$Data.Layer.Name, sumb$GDS.Number, sumb$GDS.Datatype, sumb$Cadence.Layer.Purpose, sep = "|", collapse = NULL )
sumbv2 <- cbind( sumb[6], sumb[5] )
write.csv(x = sumav2, file = "ch2_type_v2.csv")
write.csv(x = sumbv2, file = "lpo_type_v2.csv")
diffPrint(sumav2, sumbv2, color.mode="rgb")
#檢查DM's desc, Data.Layer.Name	Layer.No.	Data.Type	Description	ch
sum3 <- sum1
sum3 <- cbind( sum3[1], sum3[2], sum3[3], sum3[4] )
sum3$x <- paste( sum3$Data.Layer.Name, sum3$Layer.No., sum3$Data.Type, sep = "|", collapse = NULL )
sum3v2 <- cbind( sum3[5], sum3[4] )
#檢查LPO's desc, Data.Layer.Name	GDS.Number	GDS.Datatype	Layer.Description	Layer.Category	Cadence.Layer.Purpose
sum4 <- sum22
sum4 <- cbind( sum4[1], sum4[2], sum4[3], sum4[4], sum4[6] )
sum4$x <- paste( sum4$Data.Layer.Name, sum4$GDS.Number, sum4$GDS.Datatype, sumb$Cadence.Layer.Purpose, sep = "|", collapse = NULL )
sum4v2 <- cbind( sum4[6], sum4[5] )
write.csv(x = sum3v2, file = "ch2_Desc_v2.csv")
write.csv(x = sum4v2, file = "lpo_Desc_v2.csv")
diffPrint(sum3v2, sum4v2, color.mode="rgb")
#diffChr(sum1v2, sum22v2, color.mode="rgb")
#diffCsv(target="ch2v22.csv", current="lpov22.csv", color.mode="rgb")
####################################################end
####################################################end
