##will
lpo0 = read.csv("LPO-000242.csv", header = TRUE)
class(lpo0)
dim(lpo0)
lpo <- lpo0
lpo$gds1 <- paste( lpo[,17],lpo[,18], sep = ":", collapse = NULL )
lpo$oasis1 <- paste( lpo[,19],lpo[,20], sep = ":", collapse = NULL )
class(lpo)
dim(lpo)
#use column 2 17-20 7 9 4 6 11
lpo2 <- cbind(lpo[2],lpo$gds1,lpo$oasis1,lpo[7],lpo[9],lpo[4],lpo[6],lpo[11])
class(lpo2)
dim(lpo2)
#write.table(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_will.txt", sep = "") )
lpo2 <- lpo2[order(lpo2[1]), ]
write.table(x = lpo2, row.names = FALSE, file = "lpo_will.txt")
##was
llpo0 = read.csv("LPO-000235.csv", header = TRUE)
llpo <- llpo0
llpo$gds1 <- paste( llpo[,17],llpo[,18], sep = ":", collapse = NULL )
llpo$oasis1 <- paste( llpo[,19],llpo[,20], sep = ":", collapse = NULL )
llpo2 <- cbind(llpo[2],llpo$gds1,llpo$oasis1,llpo[7],llpo[9],llpo[4],llpo[6],llpo[11])
llpo2 <- llpo2[order(llpo2[1]), ]
write.table(x = llpo2, row.names = FALSE, file = "lpo_was.txt")
##
library(diffobj)
will_ = readLines("lpo_will.txt", warn = FALSE)
was_ = readLines("lpo_was.txt", warn = FALSE)
length(will_)
length(was_)
diffChr(was_, will_, color.mode="rgb")
####################################################end
####################################################end
ch2 <- lpo2[ which( lpo2[7]=="Active" ), ]
ch2 <- ch2[ which( ch2[8]=="22FDX" ), ]
#filter LAYER_CATEGORY:	
#Common Design FEOL	
#Common Design BEOL	
#Marker Devices	Marker Floorplan	Marker ESD	Marker Voltage	
#Design SRAM	
#Marker Metrology	
#Fill
ch2_feol <- ch2[ which( ch2[4]=="Common Design FEOL"), ]
ch2_feol <- cbind(ch2_feol[1],ch2_feol[5],ch2_feol[2],ch2_feol[3])
#write.csv(x = ch2_feol, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_feol.csv", sep = "") )
write.table(x = ch2_feol, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_feol.txt")

ch2_beol <- ch2[ which( ch2[4]=="Common Design BEOL"), ]
ch2_beol <- cbind(ch2_beol[1],ch2_beol[5],ch2_beol[2],ch2_beol[3])
#write.csv(x = ch2_beol, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_beol.csv", sep = "") )
#write.table(x = ch2_beol, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_beol.txt")

ch2_device <- ch2[ which( ch2[4]=="Marker Devices"|ch2[4]=="Marker Floorplan"|ch2[4]=="Marker ESD"|ch2[4]=="Marker Voltage"), ]
ch2_device <- cbind(ch2_device[1],ch2_device[5],ch2_device[2],ch2_device[3])
#write.csv(x = ch2_device, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_device.csv", sep = "") )
#write.table(x = ch2_device, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_device.txt")

ch2_sram <- ch2[ which( ch2[4]=="Design SRAM"), ]
ch2_sram <- cbind(ch2_sram[1],ch2_sram[5],ch2_sram[2],ch2_sram[3])
#write.csv(x = ch2_sram, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_sram.csv", sep = "") )
#write.table(x = ch2_sram, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_sram.txt")

ch2_pci <- ch2[ which( ch2[4]=="Marker Metrology"), ]
ch2_pci <- cbind(ch2_pci[1],ch2_pci[5],ch2_pci[2],ch2_pci[3])
#write.csv(x = ch2_pci, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_pci.csv", sep = "") )
#write.table(x = ch2_pci, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_pci.txt")

ch2_fill <- ch2[ which( ch2[4]=="Fill"), ]
ch2_fill <- cbind(ch2_fill[1],ch2_fill[5],ch2_fill[2],ch2_fill[3])
#write.csv(x = ch2_fill, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ch2_fill.csv", sep = "") )
#write.table(x = ch2_fill, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_fill.txt")

ch2_all <- rbind(ch2_feol, ch2_beol, ch2_device, ch2_sram, ch2_pci, ch2_fill)
write.table(x = ch2_all, row.names = FALSE, quote = FALSE, sep = "\t", file = "ch2_all.txt")
####################################################end
####################################################end
