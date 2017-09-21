#auto-update R
# installing/loading the package:
if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr
# step by step functions:
check.for.updates.R() # tells you if there is a new version of R or not.
install.R() # download and run the latest R installer
copy.packages.between.libraries() # copy your packages to the newest R installation from the one version before it (if ask=T, it will ask you between which two versions to perform the copying)
#read
lpo = read.csv("LPO-000172.csv", header = TRUE)
#keep original read
lpo1 <- lpo
#create new col
lpo1$x <- paste( lpo1$Data.Layer.Name, lpo1$GDS.Number, lpo1$GDS.Datatype, sep = "|", collapse = NULL )
#do filter
lpo2 <- lpo1[ which( lpo1[6]=="Active" ), ]
#do OR_filter
lpo22 <- lpo2[ which( lpo2[7]=="Common Design FEOL" | lpo2[7]=="Common Design BEOL" 
                     | lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage"
                     | lpo2[7]=="Marker ESD" | lpo2[7]=="Marker Floorplan"
                     | lpo2[7]=="Marker Metrology"
                     | lpo2[7]=="Design SRAM" | lpo2[7]=="Fill"), ]
#do OR_filter
lpo1_dm1 <- merge( lpo1, unique( dm1[6] ) )
#save without col_id
write.csv(x = lpo1_dm1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), 
                                     "_lpo1_dm1.csv", sep = "") )
#AND_rows
lpo3_dm_and_filter <- rbind(lpo1_dm1, lpo22)
#deduplicate
lpo3_dm_and_filter_uni <- unique(lpo3_dm_and_filter)
#vlookup
library(dplyr)
lpo3_dm_and_filter_uni2 <- left_join(lpo3_dm_and_filter_uni, dm1, by = "x")
#order
lpo3_dm_and_filter_uni2 <- lpo3_dm_and_filter_uni2[order(lpo3_dm_and_filter_uni2[43]), ]
#create counts_report
lpo2_feol <- lpo2[ which( lpo2[7]=="Common Design FEOL"), ]
lpo2_beol <- lpo2[ which( lpo2[7]=="Common Design BEOL"), ]
lpo2_device <- lpo2[ which( lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage" ), ]
lpo2_esd <- lpo2[ which( lpo2[7]=="Marker ESD"), ]
lpo2_general <- lpo2[ which( lpo2[7]=="Marker Floorplan"), ]
lpo2_pci <- lpo2[ which( lpo2[7]=="Marker Metrology"), ]
lpo2_sram <- lpo2[ which( lpo2[7]=="Design SRAM"), ]
lpo2_fill <- lpo2[ which( lpo2[7]=="Fill"), ]
#lpo2_sum <- lpo2[ which( lpo2[7]=="22FDX"), ]
lpo_count <- rbind( dim(lpo2_feol),dim(lpo2_beol),dim(lpo2_device),dim(lpo2_esd),
                    dim(lpo2_general),dim(lpo2_pci),dim(lpo2_sram),dim(lpo2_fill),
                    dim(lpo2),dim(unique(lpo2[1])) )
#
dm0_feol <- dm1[ which( dm1[5]=="FEOL"), ]
dm0_beol <- dm1[ which( dm1[5]=="BEOL"), ]
dm0_device <- dm1[ which( dm1[5]=="Device" ), ]
dm0_esd <- dm1[ which( dm1[5]=="ESD"), ]
dm0_general <- dm1[ which( dm1[5]=="General"), ]
dm0_pci <- dm1[ which( dm1[5]=="PCI"), ]
dm0_sram <- dm1[ which( dm1[5]=="SRAM"), ]
dm0_fill <- dm1[ which( dm1[5]=="Fill"), ]
dm_count <- rbind( dim(dm0_feol),dim(dm0_beol),dim(dm0_device),dim(dm0_esd),
                   dim(dm0_general),dim(dm0_pci),dim(dm0_sram),dim(dm0_fill),
                   dim(dm1), dim(unique(dm1[1])) )
#AND_cols
sum_count <- cbind( lpo_count[,1], dm_count[,1] )
#renamed
rownames(sum_count) <- c("FEOL","BEOL","Device","ESD","General","PCI","SRAM","Fill",
                         "database_dim","name_unique")
colnames(sum_count) <- c("LPO_external","DM_ch2.2")
colnames(f1) <- colnames(f2)
#read txt
sum2 = readLines("0524dita1.txt", warn = FALSE)
sum1 = readLines("0522dita1.txt", warn = FALSE)
#read csv -> rows
llpo = read.table("LPO-000202.csv")
#reduce dim
length(sum2)
length(sum1)
sum2 <- sum2[ -(1:length(sum2)*0.95) ]
sum1 <- sum1[ -(1:length(sum1)*0.95) ]
length(sum2)
length(sum1)
#grep bwtween
sum2 <- gsub("<entry", "\n<entry", sum2)
sum2 <- gsub("<title", "\n<title", sum2)
sum1 <- gsub("<entry", "\n<entry", sum1)
sum1 <- gsub("<title", "\n<title", sum1)
#grep keywords
llpo2 <- grep("[!]|[#]|[$]|[%]|[&]|[+]|[=]", llpo, value = TRUE)
sum2v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum2, value = TRUE) #grep /entry & /title & _-fn#
sum1v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum1, value = TRUE) #grep /entry & /title & _-fn#
#do diff
install.packages("diffobj")
library(diffobj)
vignette("diffobj", package="diffobj")
diffChr(sum1, sum2, color.mode="rgb")
diffPrint(target=sum2v1, current=sum1v1, color.mode="rgb")
#https://stackoverflow.com/questions/24858823/extract-data-from-pivot-table-to-data-frame-i-e-reverse-the-pivot
install.packages("reshape2")
library(reshape2)
i1 = read.csv("0705DTT.csv", header = TRUE)
#2d->1d
o1 <- melt(i1, id.vars = "Structure")
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )
#Plot
pie(sum_count[,1])
#creat Matix
iter <- 10
out <- matrix(NA, nrow=iter, ncol=3)
####################################################end
####################################################end
####################################################end
