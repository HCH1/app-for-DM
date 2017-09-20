#install.packages("zoo")
#library(zoo)
lpo = read.csv("LPO-000200.csv", header = TRUE)
lpo2 <- lpo
lpo3 <- lpo2[lpo2[6]=="Active", ]
lpo3 <- lpo3[lpo3[11]=="22FDX", ]
#DMM-010311
lpo3 <- lpo3[ which( lpo3[7]=="Common Design FEOL" | lpo3[7]=="Common Design BEOL" 
                     | lpo3[7]=="Marker Devices" | lpo3[7]=="Marker Voltage"
                     | lpo3[7]=="Marker ESD" | lpo3[7]=="Marker Floorplan"
                     | lpo3[7]=="Marker Metrology"
                     | lpo3[7]=="Design SRAM" | lpo3[7]=="Fill"), ]

lpo3 <- lpo3[ order(lpo3[2]), ]
lpo3 <- lpo3[ order(lpo3[7]), ]
write.csv(x = lpo3, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_ch2p2.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end