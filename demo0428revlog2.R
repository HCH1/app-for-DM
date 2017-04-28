#install.packages("zoo")
#library(zoo)
diffdm = read.csv("22FDX_Rev1.2_0.0_DRC01Trackv5.csv", header = TRUE)
diffdm2 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
write.csv(x = diffdm2, file = paste(format(Sys.time(), "%Y%m%d"), "_diffdm2.csv", sep = "") )

#merge col
diffdm2$x <- paste(diffdm2$Type, diffdm2$Rule)
#diffdm2$y <- paste(unique(diffdm2$Type),diffdm2$Rule)
diffdm3 <- diffdm2
write.csv(x = diffdm3, file = paste(format(Sys.time(), "%Y%m%d"), "_diffdm3.csv", sep = "") )

diffdm4 <- cbind( diffdm3[1], diffdm3[4] )
write.csv(x = diffdm4, file = paste(format(Sys.time(), "%Y%m%d"), "_diffdm4.csv", sep = "") )
#diffdm4r1 <- diffdm4[diffdm4[1]=="APMOM Design Rules", ]
#write.csv(x = diffdm4r1, file = paste(format(Sys.time(), "%Y%m%d"), "_diffdm4r1.csv", sep = "") )

#install.packages("gtools")
library(gtools)
diffdm4_uni <- unique(diffdm4[1])
big_data = data.frame()
#big_data = list()
for ( i in 1:length(t(diffdm4_uni)) ){ #length(t(diffdm4_uni))
  diffdm4filter <- diffdm4[ diffdm4[1]==t(diffdm4_uni)[,i], ]
  #diffdm4filter <- diffdm4[ diffdm4[1]==diffdm4_uni[i,], ]
  #df <- cbind( t(diffdm4_uni)[i], t(diffdm4filter[2]) )
  #df <- cbind( diffdm4filter[i,], t(diffdm4filter[2]) )
  df <- data.frame( cbind( diffdm4filter[i,], t(diffdm4filter[2]) ) )
  big_data <- smartbind(big_data, df)
  #big_data <- gsub("NA", "", big_data)
  #write.csv(x = diffdm5, file = paste(format(Sys.time(), "%Y%m%d"),"_row",i, "_diffdm5.csv", sep = "") )
  #df_total <- cat(df_total,as.vector(diffdm5))  
  #datalist[[i]] <- diffdm5
}
#big_data[is.na(big_data)] <- 0
#big_data <- gsub("", "", big_data)
write.csv(x = big_data, file = paste(format(Sys.time(), "%Y%m%d"),"_big_data.csv", sep = "") )

#############end