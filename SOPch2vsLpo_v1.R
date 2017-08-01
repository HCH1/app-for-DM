#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
####################################################end
#install.packages("zoo")
#library(zoo)
diffdm = read.csv("LPO-000172.csv", header = TRUE)
#col2 7 9 17 18
diffdm2 <- cbind( diffdm[2], diffdm[17], diffdm[18], diffdm[9], diffdm[7] )
diffdm2 <- diffdm2[order(diffdm2[1]), ]
write.csv(x = diffdm2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm2.csv", sep = "") )
##
#install.packages("diffobj")
library(diffobj)
#vignette("diffobj", package="diffobj")
sum1 = read.csv("22FDXch2_2.csv", header = TRUE)
sum1 <- sum1[order(sum1[1]), ]
sum2 = read.csv("20170801_17_diffdm2.csv", header = TRUE)
sum2 <- sum2[,-1]
diffPrint(target=sum2, current=sum1, color.mode="rgb")
##
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
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist.csv", sep = "") )
##vlookup with _internal.csv
grule = read.csv("22FDX_Rev1.2_0.0_QA02_D2_internal.csv", header = TRUE)
#head(grule)
grule2 <- cbind( unique(grule[8]), unique(grule[10]) )
colnames(grule2)[1] <- "Section"
#head(grule2)
write.csv(x = grule2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_grule2.csv", sep = "") )
ans_o3 <- merge(ans_o2, grule2, by = "Section")
ans_o3 <- ans_o3[order(ans_o3[3]), ]
#library(dplyr)
#ans_o3 <- left_join(ans_o2, grule2, by = c("Section"="Table.Title"))
write.csv(x = ans_o3, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist2.csv", sep = "") )
####################################################end

a33 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[2,],collapse=" " ), ]
a44 <- as.matrix( t(a33) )
a44 <- as.vector(a44)
a44 <- a44[!duplicated(a44)]
a55 <- paste( unique(t(a44)),collapse=" " )
write.csv(x = a55, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_a55.csv", sep = "") )



#big_data = list()
for ( i in 1:length(t(diffdm4_uni)) ){ #length(t(diffdm4_uni))
  diffdm4filter <- diffdm4[ diffdm4[1]==t(diffdm4_uni)[,i], ]
  #diffdm4filter <- diffdm4[ diffdm4[1]==diffdm4_uni[i,], ]
  #df <- cbind( t(diffdm4_uni)[i], t(diffdm4filter[2]) )
  #df <- cbind( diffdm4filter[i,], t(diffdm4filter[2]) )
  df <- data.frame( cbind( diffdm4filter[i,], t(diffdm4filter[2]) ) )
  big_data <- smartbind(big_data, df)
  #big_data <- gsub("NA", "", big_data)
  #write.csv(x = diffdm5, file = paste(format(Sys.time(), "%Y%m%d_%H"),"_row",i, "_diffdm5.csv", sep = "") )
  #df_total <- cat(df_total,as.vector(diffdm5))  
  #datalist[[i]] <- diffdm5
}
#big_data[is.na(big_data)] <- 0
#big_data <- gsub("", "", big_data)
write.csv(x = big_data, file = paste(format(Sys.time(), "%Y%m%d_%H"),"_big_data.csv", sep = "") )



diffdm5 <- paste(diffdm2$Section, diffdm2$Type, diffdm2$Rule)
diffdm5 <- as.matrix(diffdm5)
diffdm5 <- as.vector(diffdm5)
diffdm5 <- unique(t(diffdm5))
write.csv(x = diffdm5, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm5.csv", sep = "") )


#merge col
diffdm2$x <- paste(diffdm2$Type, diffdm2$Rule)
#diffdm2$y <- paste(unique(diffdm2$Type),diffdm2$Rule)
diffdm3 <- diffdm2
write.csv(x = diffdm3, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm3.csv", sep = "") )
 
diffdm4 <- cbind( diffdm3[1], diffdm3[4] )
write.csv(x = diffdm4, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm4.csv", sep = "") )
#diffdm4r1 <- diffdm4[diffdm4[1]=="APMOM Design Rules", ]
#write.csv(x = diffdm4r1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm4r1.csv", sep = "") )
#diffdm5 <- as.matrix(diffdm2)