#install.packages("zoo")
#library(zoo)
lpo = read.csv("LPO-000312.csv", header = TRUE)
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
lpo5 <- lpo4[ which( lpo4[7]=="28SLPHV" | lpo4[7]=="28SLP;28SLPHV"), ]
#order
lpo6 <- lpo5[order(lpo5[3]), ]
str(lpo6)
head(lpo6)
lpo7 <- lpo6
write.csv(x = lpo7, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo to ch2 28lpshv.csv", sep = "") )
####################################################end
####################################################end
dm1 = read.csv("28SLP-HV_Rev0.1_0.0 ch2.csv", header = TRUE)
str(dm1)
dm1 <- cbind(dm1[2]
, dm1$v5
, paste( dm1$v3, dm1$v4, sep = ";", collapse = NULL )
)
colnames(dm1) <- c("CAD Level","Description","GDS")
dm2 <- dm1[order(dm1[3]), ]
str(dm2)
write.csv(x = dm2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2 28lpshv.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end