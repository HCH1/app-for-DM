#install.packages("zoo")
#library(zoo)
##\\fab2crp-nas1\home19\HHUNG\Profile\Documents\2018R\201805 SOPLM2LPO_for28slp_v2\201806 28slphv check again lpo vs ch2
lpo = read.csv("LPO-000318 LCN-002051 28G.csv", header = TRUE)
str(lpo)
#merge column 2 6 7 17 18
lpo2 <- cbind(lpo[2]
, lpo$Layer.Description 
, paste( lpo$GDS.Number, lpo$GDS.Datatype, sep = ";", collapse = NULL )
, paste( lpo$Cadence.Name.OA.Number, lpo$Cadence.Purpose.OA.Number, sep = ";", collapse = NULL )
, lpo$Layer.Status
, lpo$Layer.Category
, lpo$Tech.Variant...Included.in.PDK 
)
str(lpo2)
colnames(lpo2) <- c("CAD Level","Description","GDS","Oasis","Status","Category","TV")
str(lpo2)
#do filter
lpo3 <- lpo2[ which( lpo2[5]=="Active" ), ]
#do OR_filter
lpo4 <- lpo3[ which( lpo3[6]=="Common Design FEOL" | lpo3[6]=="Common Design BEOL" 
                     | lpo3[6]=="Marker Devices" | lpo3[6]=="Marker Floorplan"
                     | lpo3[6]=="Marker ESD" | lpo3[6]=="Marker Voltage"
                     | lpo3[6]=="Design SRAM" | lpo3[6]=="Marker Metrology"
                     | lpo3[6]=="Fill"), ]
#for slphv
#lpo5 <- lpo4[ which( lpo4[7]=="28SLPHV" | lpo4[7]=="28SLP;28SLPHV"), ]
#for slp
#lpo5 <- lpo4[ which( lpo4[7]=="28SLP" | lpo4[7]=="28SLP;28SLPHV"), ]
#for hpp
#lpo5 <- lpo4[ which( lpo4[7]=="28SLP;28HPP" | lpo4[7]=="28SLP;28HPP;28SLPHV"), ]
##Tech Variant - Included in PDK
flt1 <- c("28HPP")
flt2 <- c("28HPP;28LPQRF")
flt3 <- c("28HPP;28LPQRF;28LPQRFQCA")
flt4 <- c("28HPP;28LPQRFQCA")
flt5 <- c("28LPQRF")
flt6 <- c("28LPQRF;28LPQRFQCA")
flt7 <- c("28LPQRFQCA")
flt8 <- c("28LPSE")
flt9 <- c("28LPSE;28HPP")
flt10 <- c("28LPSE;28HPP;28LPQRF")
flt11 <- c("28LPSE;28HPP;28LPQRF;28LPQRFQCA")
flt12 <- c("28LPSE;28HPP;28LPQRFQCA")
flt13 <- c("28LPSE;28LPQRF")
flt14 <- c("28LPSE;28LPQRF;28LPQRFQCA")
flt15 <- c("28LPSE;28LPQRFQCA")
flt16 <- c("for lpse")
#for 28LPSE
#lpo5 <- lpo4[ which( lpo4[7]==flt8 | lpo4[7]==flt9 |
#lpo4[7]==flt10 | lpo4[7]==flt11 | lpo4[7]==flt12 | lpo4[7]==flt13 |
#lpo4[7]==flt14 | lpo4[7]==flt15 | lpo4[7]==flt16 ), ]
##for 28LPSE v2
###grep dataframe contain keywords
##lpo5 <- lpo4[grep("28LPSE", lpo4$TV),]
##for 28HPP v2
lpo5 <- lpo4[grep("28HPP", lpo4$TV),]
##for 28LPQRF v2
##lpo5 <- lpo4[grep("28LPQRF", lpo4$TV),]
##for 28LPQRFQCA v2
##lpo5 <- lpo4[grep("28LPQRFQCA", lpo4$TV),]
#order
lpo6 <- lpo5[order(lpo5[3]), ]
str(lpo6)
head(lpo6)
lpo7 <- lpo6
#for slphv
#write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28slphv.csv", sep = "") )
#for slp
#write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28slp.csv", sep = "") )
#for hpp
#write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28hpp.csv", sep = "") )
##for 28LPSE v2
##write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28lpse.csv", sep = "") )
##for 28HPP v2
write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28hpp.csv", sep = "") )
##for 28LPQRF v2
##write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28lpqrf.csv", sep = "") )
##for 28LPQRFQCA v2
##write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28lpqrfqca.csv", sep = "") )
####################################################end
####################################################end
#slphv
#dm1 = read.csv("28SLP-HV_Rev0.1_0.0 ch2 - Copy.csv", header = TRUE)
#slp
#dm1 = read.csv("28SLP_Rev1.1_5.0_DRC02 ch2 - Copy.csv", header = TRUE)
#hpp
dm1 = read.csv("28HPP_Rev1.1_4.0 ch2 - Copy.csv", header = TRUE)
#lpse
#dm1 = read.csv("28LPSe_Rev1.0_3.0 ch2 - Copy.csv", header = TRUE)
#lpqrf
#dm1 = read.csv("28LPQ_RF_Rev1.0_6.0 ch2 - Copy.csv", header = TRUE)
#lpqrfqca
#dm1 = read.csv("28LPQRF_QCA_Rev1.1_0.0_ENG ch2 - Copy.csv", header = TRUE)
str(dm1)
dm1 <- cbind(dm1[2]
, dm1$v5
, paste( dm1$v3, dm1$v4, sep = ";", collapse = NULL )
)
colnames(dm1) <- c("CAD Level","Description","GDS")
dm2 <- dm1[order(dm1[3]), ]
str(dm2)
#slphv
#write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28slphv.csv", sep = "") )
#slp
#write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28slp.csv", sep = "") )
#hpp
write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28hpp.csv", sep = "") )
#lpse
#write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28lpse.csv", sep = "") )
#lpqrf
#write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28lpqrf.csv", sep = "") )
#lpqrfqca
#write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28lpqrfqca.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
