#http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram
#install.packages("corrplot")
library(corrplot)
i1 = read.csv("0927DTT2.csv", header = TRUE)
i2 <- i1
i2 <- i2[-1]
dtt_c1 <- cor(i2)
#dtt_c2 <- dtt_c1[ order(rownames(dtt_c1)), ]
#dtt_c3 <- dtt_c2[ order(colnames(dtt_c2)), ]
write.csv(x = dtt_c1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dtt_c1.csv", sep = "") )
dtt_c1_lite <- dtt_c1[-c(1:99), -c(1:99)]
corrplot(dtt_c1_lite, method="color")
#head(round(dtt_c1,2))
#corrplot(dtt_c1, method="circle")
#fast reduce last rows/cols
#dtt_c1_lite <- dtt_c1[-c(31:dim(dtt_c1)[1]), -c(31:dim(dtt_c1)[1])] # delete columns 5 through 7
#dtt_c1_lite <- dtt_c1_lite[order(-dtt_c1_lite[,1]), ]
#corrplot(dtt_c1_lite, method="number")
#corrplot(dtt_c1, type="upper")
####################################################end
####################################################end
####################################################end
####################################################end