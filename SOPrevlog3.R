#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
install.packages("diffobj")
library(diffobj)
#vignette("diffobj", package="diffobj")
sum1 = read.csv("22FDSOI_Rev1.2_0.0_DRC03_TEST3_Workingvs22FDSOI_Rev1.2_0.0_DRC02DRCTrack.csv", header = TRUE)
sum2 = read.csv("22FDX_Rev1.2_0.0_QA01V3_Workingvs22FDSOI_Rev1.2_0.0_DRC03DRCTrack.csv", header = TRUE)
diffPrint(target=sum2, current=sum1, color.mode="rgb")
####################################################end
#install.packages("zoo")
#library(zoo)
diffdm = read.csv("22FDX_Rev1.2_0.0_DRC01Trackv5.csv", header = TRUE)
diffdm2 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
diffdm2 <- diffdm2[order(diffdm2[1]), ]
write.csv(x = diffdm2, file = paste(format(Sys.time(), "%Y%m%d"), "_diffdm2.csv", sep = "") )
#install.packages("gtools")
#library(gtools)
diffdm4_uni <- unique(diffdm2[1]) #length(t(diffdm4_uni)) 113
#big_data = data.frame()
#ans_o2 <- cbind( diffdm4_uni[1], ans_o1[1] )
#head(ans_o2)
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) #create dummy 113 1
for ( i in 1:length(t(diffdm4_uni)) ){ #length(t(diffdm4_uni)) 113
#== right hand side, must be an element, so use paste 
a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
#aaa <- diffdm2[diffdm2[1]=="APMOM Design Rules", ] #40 3
#a4 <- paste(a3$Type, a3$Rule)
a4 <- cbind( a3[2], a3[3] )
a4t <- as.matrix( t(a4) )
a4t <- as.vector(a4t)
a4t <- a4t[!duplicated(a4t)]
#a4 <- unique(t(a4))
a5 <- paste( t(a4t),collapse=" " )
ans_o1[i] <- a5
}
#head(ans_o1)
ans_o2 <- cbind( diffdm4_uni, ans_o1 )
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d"), "_rev_hist.csv", sep = "") )
##vlookup with _internal.csv
grule = read.csv("22FDX_Rev1.2_0.0_QA02_D2_internal.csv", header = TRUE)
#head(grule)
grule2 <- cbind( unique(grule[8]), unique(grule[10]) )
colnames(grule2)[1] <- "Section"
#head(grule2)
write.csv(x = grule2, file = paste(format(Sys.time(), "%Y%m%d"), "_grule2.csv", sep = "") )
ans_o3 <- merge(ans_o2, grule2, by = "Section")
ans_o3 <- ans_o3[order(ans_o3[3]), ]
#library(dplyr)
#ans_o3 <- left_join(ans_o2, grule2, by = c("Section"="Table.Title"))
write.csv(x = ans_o3, file = paste(format(Sys.time(), "%Y%m%d"), "_rev_hist2.csv", sep = "") )
####################################################end
