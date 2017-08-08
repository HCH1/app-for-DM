#輸入LPO
lpo = read.csv("LPO-000172.csv", header = TRUE)
#col2 7 9 17 18 
#col4 Cadence Layer Purpose 
#col11 Tech Variant
lpo1 <- cbind( lpo[2], lpo[17], lpo[18], lpo[9], lpo[7], lpo[4], lpo[11])
lpo1 <- lpo1[order(lpo1[1]), ]
write.csv(x = lpo1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_lite.csv", sep = "") )
#for external cus
lpo2 <- lpo1[ which( lpo1[7]=="22FDX"), ]
#Common Design FEOL	Common Design BEOL	Marker Devices	Marker Voltage	
#Marker ESD	Marker Floorplan	Marker Metrology	Design SRAM	
lpo2_feol <- lpo2[ which( lpo2[5]=="Common Design FEOL"), ]
lpo2_beol <- lpo2[ which( lpo2[5]=="Common Design BEOL"), ]
lpo2_device <- lpo2[ which( lpo2[5]=="Marker Devices" | lpo2[5]=="Marker Voltage" ), ]
lpo2_esd <- lpo2[ which( lpo2[5]=="Marker ESD"), ]
lpo2_general <- lpo2[ which( lpo2[5]=="Marker Floorplan"), ]
lpo2_pci <- lpo2[ which( lpo2[5]=="Marker Metrology"), ]
lpo2_sram <- lpo2[ which( lpo2[5]=="Design SRAM"), ]
lpo2_fill <- lpo2[ which( lpo2[5]=="Fill"), ]
#lpo2_sum <- lpo2[ which( lpo2[7]=="22FDX"), ]
lpo_count <- rbind( dim(lpo2_feol),dim(lpo2_beol),dim(lpo2_device),dim(lpo2_esd),dim(lpo2_general),dim(lpo2_pci),dim(lpo2_sram),dim(lpo2_fill),dim(lpo2),dim(unique(lpo2[1])) )
write.csv(x = lpo2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_external.csv", sep = "") )
##
#輸入ch2
dm0 = read.csv("22FDXch2p2.csv", header = TRUE)
#
dm0_feol <- dm0[ which( dm0[5]=="FEOL"), ]
dm0_beol <- dm0[ which( dm0[5]=="BEOL"), ]
dm0_device <- dm0[ which( dm0[5]=="Device" ), ]
dm0_esd <- dm0[ which( dm0[5]=="ESD"), ]
dm0_general <- dm0[ which( dm0[5]=="General"), ]
dm0_pci <- dm0[ which( dm0[5]=="PCI"), ]
dm0_sram <- dm0[ which( dm0[5]=="SRAM"), ]
dm0_fill <- dm0[ which( dm0[5]=="Fill"), ]
dm_count <- rbind( dim(dm0_feol),dim(dm0_beol),dim(dm0_device),dim(dm0_esd),dim(dm0_general),dim(dm0_pci),dim(dm0_sram),dim(dm0_fill),dim(dm0), dim(unique(dm0[1])) )
#
sum_count <- cbind( lpo_count[,1], dm_count[,1] )
rownames(sum_count) <- c("FEOL","BEOL","Device","ESD","General","PCI","SRAM","Fill","sum","name_unique")
colnames(sum_count) <- c("LPO_external","DM_ch2.2")
write.csv(x = sum_count, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
sum_count
#
sum1 <- dm0
sum1 <- sum1[order(sum1[1]), ]
#輸入lpo_lite
sum2 <- lpo2
#更改LPO的欄位名稱, Data.Layer.Name	Layer.No.	Data.Type	Description	ch
colnames(sum1)[1] <- "Data.Layer.Name"
#讓LPO只選某些rows 基於ch2 這樣比較好做diff 類似vlookup
#sum22 <- semi_join(sum2, sum1[1], by = "Data.Layer.Name" )
#library(dplyr)
sum22 <- merge(sum2, sum1[1])
write.csv(x = sum1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2v1.csv", sep = "") )
write.csv(x = sum22, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpov1.csv", sep = "") )
#檢查DM是否有重複? DRES LDFET6V5 NLDEV
duplicate_dm <- dim(sum1[1])-dim( unique(sum1[1]) )
duplicate_dm
dim( unique(sum22[1]) ) 
#install.packages("diffobj")
#library(diffobj)
#vignette("diffobj", package="diffobj")
#檢查DM's ch, Data.Layer.Name	Layer.No.	Data.Type	Description	ch
suma <- sum1
#suma <- cbind( suma[1], suma[2], suma[3], suma[5] )
suma$x <- paste( suma$Data.Layer.Name, suma$Layer.No., suma$Data.Type, sep = "|", collapse = NULL )
sumav2 <- cbind( suma[6], suma[4], suma[5] )
#檢查LPO's ch, Data.Layer.Name	GDS.Number	GDS.Datatype	Layer.Description	Layer.Category	Cadence.Layer.Purpose
sumb <- sum22
#sumb <- cbind( sumb[1], sumb[2], sumb[3], sumb[5], sumb[6] )
sumb$x <- paste( sumb$Data.Layer.Name, sumb$GDS.Number, sumb$GDS.Datatype, sep = "|", collapse = NULL )
sumbv2 <- cbind( sumb[8], sumb[4], sumb[5], sumb[6], sumb[7] )
write.csv(x = sumav2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2v2.csv", sep = "") )
write.csv(x = sumbv2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpov2.csv", sep = "") )
#串聯columns
ans1 <- left_join(sumbv2, sumav2, by = "x")
ans1 <- ans1[order(ans1[7]), ]
ans1 <- unique(ans1)
write.csv(x = ans1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ans1.csv", sep = "") )
ans2 <- cbind( ans1[1], ans1[4], ans1[5], ans1[3], ans1[7], ans1[2], ans1[6] )
write.csv(x = ans2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ans2.csv", sep = "") )
####################################################end
####################################################end
