#https://stackoverflow.com/questions/24858823/extract-data-from-pivot-table-to-data-frame-i-e-reverse-the-pivot
#install.packages("reshape2")
library(reshape2)
ii1 = read.csv("28LPSe_DPTT1.csv", header = FALSE)
ii2 <- ii1
#merge 2 rows
r1 <- t( paste( t(ii2)[,1], t(ii2)[,2], sep = "_", collapse = NULL ) )
#set another colnames
colnames(ii2) <- as.vector(r1)
write.csv(x = ii2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DPTT.csv", sep = "") )
#remove 2 rows., use colnames for melt
o0 <- melt(ii2[-(1:2),], id.vars = as.vector(r1)[1], warn = FALSE)
o1 <- o0
#o1 <- o1[order(o1[3]), ]
#o1 <- o1[order(o1[2]), ]
#o1 <- o1[order(o1[1]), ]
o2 <- o1
#merge cols
o2$x <- paste( o2$value, o2$variable, sep = "", collapse = NULL )
##1CN & 0CP will become Masks List, but ZG & OP are invert.
#replace
o2$x <- gsub("CP_ZG", "CN_ZG", o2$x)
o2$x <- gsub("CP_OP", "CN_OP", o2$x)
write.csv(x = o2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DPTT.csv", sep = "") )
##
o3 <- o2
#replace _XXX -> ""
o3$x <- gsub("[_][0-9A-Z]+", "", o3$x)
write.csv(x = o3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DPTT2.csv", sep = "") )
##
o4 <- o3
#filter only 1CN & 0CP
o4 <- o4[ which( o4[4]=="1CN"|o4[4]=="0CP" ), ]
##find unique devices
o4_uni <- unique(o4[1])
dim(o4_uni)
#create dummy
ans_o1 <- matrix( NA, nrow=length(t(o4_uni)), ncol=1 ) 
o5 <- cbind(o4[1],o4[2])
#loop
for ( i in 1:length(t(o4_uni)) ){
#filter unique devices 1 by 1
a4 <- o5[ which( o5[1]==paste( o4_uni[i,], collapse=" " ) ), ]
a4t <- as.matrix( t(a4[2]) ) #1*n matrix
a4tv <- as.vector(a4t) #convert to line
#merge vector -> char
a5 <- paste( t(a4tv), collapse=" " )
#replace
a5 <- gsub("CN_", "", a5)
a5 <- gsub("CP_", "", a5)
#save to i-th row 1 by 1
ans_o1[i] <- a5
}
#create opuput format
ans_o2 <- cbind( o4_uni, ans_o1 )
write.csv(x = ans_o2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DPTT3.csv", sep = "") )
###vlookup
library(dplyr)
ans3 <- left_join(ii2, ans_o2)
write.csv(x = ans3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DPTT_ans.csv", sep = "") )
####################################################end
####################################################end
####################################################end