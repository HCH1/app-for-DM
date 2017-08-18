#LPO vs DMch2p2 
lpo = read.csv("LPO-000172.csv", header = TRUE)
lpo1 <- lpo
lpo1$x <- paste( lpo1$Data.Layer.Name, lpo1$GDS.Number, lpo1$GDS.Datatype, sep = "|", collapse = NULL )
#
dm = read.csv("22FDXch2p2.csv", header = TRUE)
dm1 <- dm
dm1$x <- paste( dm1$CAD.Levels, dm1$Layer.No, dm1$Data.Type, sep = "|", collapse = NULL )
#lpo1_col7 <- unique( lpo1[7] )
#?????????????????????external
lpo2 <- lpo1[ which( lpo1[6]=="Active" ), ]
lpo2 <- lpo2[ which( lpo2[11]=="22FDX" ), ]
#????????????LPO??????????????????ch2p2?????????rows
lpo22 <- lpo2[ which( lpo2[7]=="Common Design FEOL" | lpo2[7]=="Common Design BEOL" 
                     | lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage"
                     | lpo2[7]=="Marker ESD" | lpo2[7]=="Marker Floorplan"
                     | lpo2[7]=="Marker Metrology"
                     | lpo2[7]=="Design SRAM" | lpo2[7]=="Fill"), ]
#LPO & DMch2p2?????? ??????LPO????????????????????????
lpo1_dm1 <- merge( lpo1, unique( dm1[6] ) )
write.csv(x = lpo1_dm1, file = paste(format(Sys.time(), "%Y%m%d_%H"), 
                                     "_lpo1_dm1.csv", sep = "") )
#??? ?????? & LPO??????rows row?????? ???????????????
lpo3_dm_and_filter <- rbind(lpo1_dm1, lpo22)
lpo3_dm_and_filter_uni <- unique(lpo3_dm_and_filter)
#?????????rows ??? DMch2p2 ??????col?????? 
#library(dplyr)
lpo3_dm_and_filter_uni2 <- left_join(lpo3_dm_and_filter_uni, dm1, by = "x")
lpo3_dm_and_filter_uni2 <- lpo3_dm_and_filter_uni2[order(lpo3_dm_and_filter_uni2[43]), ]
write.csv(x = lpo3_dm_and_filter_uni2, file = paste(format(Sys.time(), "%Y%m%d_%H"), 
                                                   "_lpo3_dm_and_filter_uni2.csv", sep = "") )
#
#Common Design FEOL	Common Design BEOL	Marker Devices	Marker Voltage	
#Marker ESD	Marker Floorplan	Marker Metrology	Design SRAM	
lpo2_feol <- lpo2[ which( lpo2[7]=="Common Design FEOL"), ]
lpo2_beol <- lpo2[ which( lpo2[7]=="Common Design BEOL"), ]
lpo2_device <- lpo2[ which( lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage" ), ]
lpo2_esd <- lpo2[ which( lpo2[7]=="Marker ESD"), ]
lpo2_general <- lpo2[ which( lpo2[7]=="Marker Floorplan"), ]
lpo2_pci <- lpo2[ which( lpo2[7]=="Marker Metrology"), ]
lpo2_sram <- lpo2[ which( lpo2[7]=="Design SRAM"), ]
lpo2_fill <- lpo2[ which( lpo2[7]=="Fill"), ]
#lpo2_sum <- lpo2[ which( lpo2[7]=="22FDX"), ]
sum_lpo2 <- rbind( lpo2_feol,lpo2_beol,lpo2_device,lpo2_esd,lpo2_general,lpo2_pci,lpo2_sram,lpo2_fill )
lpo_count <- rbind( dim(lpo2_feol),dim(lpo2_beol),dim(lpo2_device),dim(lpo2_esd),
                    dim(lpo2_general),dim(lpo2_pci),dim(lpo2_sram),dim(lpo2_fill),
                    dim(sum_lpo2),dim(lpo2),dim(unique(lpo2[1])) )
#
dm0_feol <- dm1[ which( dm1[5]=="FEOL"), ]
dm0_beol <- dm1[ which( dm1[5]=="BEOL"), ]
dm0_device <- dm1[ which( dm1[5]=="Device" ), ]
dm0_esd <- dm1[ which( dm1[5]=="ESD"), ]
dm0_general <- dm1[ which( dm1[5]=="General"), ]
dm0_pci <- dm1[ which( dm1[5]=="PCI"), ]
dm0_sram <- dm1[ which( dm1[5]=="SRAM"), ]
dm0_fill <- dm1[ which( dm1[5]=="Fill"), ]
sum_dm0 <- rbind( dm0_feol,dm0_beol,dm0_device,dm0_esd,dm0_general,dm0_pci,dm0_sram,dm0_fill )
dm_count <- rbind( dim(dm0_feol),dim(dm0_beol),dim(dm0_device),dim(dm0_esd),
                   dim(dm0_general),dim(dm0_pci),dim(dm0_sram),dim(dm0_fill),
                   dim(sum_dm0),dim(dm1),dim(unique(dm1[1])) )
#
sum_count <- cbind( lpo_count[,1], dm_count[,1] )
rownames(sum_count) <- c("FEOL","BEOL","Device","ESD","General","PCI","SRAM","Fill",
                         "sum_above","database_dim","name_unique")
colnames(sum_count) <- c("LPO_external","DM_ch2.2")
write.csv(x = sum_count, file = paste(format(Sys.time(), "%Y%m%d_%H"), 
                                      "_sum_count.csv", sep = "") )
sum_count
####################################################end
####################################################end
####################################################end